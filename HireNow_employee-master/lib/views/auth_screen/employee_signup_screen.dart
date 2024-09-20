import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/consts/colors.dart';
import 'package:flutter_application_1/views/home_Screen/home_pages.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EmployeeSignupScreen extends StatefulWidget {
  const EmployeeSignupScreen({Key? key}) : super(key: key);

  @override
  State<EmployeeSignupScreen> createState() => _EmployeeSignupScreenState();
}

class _EmployeeSignupScreenState extends State<EmployeeSignupScreen> {
  int _currentStep = 0;
  bool passwordVisible = false;
  bool cpasswordVisible = false;
  bool _termsAccepted = false;

  // Form keys for each step
  final _formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>()
  ];
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  // Controllers for form fields
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _skillController = TextEditingController();
  final _languageController = TextEditingController();
  final _educationController = TextEditingController();

  final List<String> _skills = [];
  final List<String> _languages = [];
  final List<String> _education = [];

  XFile? _selectedImage;

  // Pick image from gallery
  void _pickImageFromGallery() async {
    try {
      final pickedImage = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxHeight: 150,
        maxWidth: 150,
        imageQuality: 90,
      );
      setState(() {
        _selectedImage = pickedImage;
      });
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  // Validate the current step
  bool _validateStep(int step) {
    return _formKeys[step].currentState?.validate() ?? false;
  }

  // Continue to next step or submit the form
  void _onStepContinue() {
    if (_currentStep == 0 && _selectedImage == null) {
      _showSnackBar('Please select an image first');
    } else if (_validateStep(_currentStep)) {
      if (_currentStep < 1) {
        setState(() {
          _currentStep++;
        });
      } else if (_termsAccepted) {
        _submitForm();
      } else {
        _showSnackBar('Please accept the terms and conditions');
      }
    }
  }

  // Go back to the previous step
  void _onStepCancel() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
    }
  }

  // Determine the step state based on validation
  StepState _getStepState(int step) {
    return _validateStep(step) ? StepState.complete : StepState.error;
  }

  // Submit the form and store data in Firebase
  void _submitForm() async {
    final fullName = _fullNameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final phone = _phoneController.text.trim();
    final address = _addressController.text.trim();
    final description = _descriptionController.text.trim();
    final skills = _skills;
    final languages = _languages;
    final education = _education;
    final imageUrl = _selectedImage != null
        ? await _uploadImage(File(_selectedImage!.path))
        : null;

    try {
      // Create user in Firebase Authentication
      final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
         final userId = userCredential.user?.uid;

      // Store user data in Firestore
      await FirebaseFirestore.instance.collection('users').doc(userCredential.user?.uid).set({
        'id': userId,  
        'name': fullName,
        'email': email,
        'phone': phone,
        'address': address,
        'description': description,
        'skills': skills,
        'languages': languages,
        'education': education,
        'imageUrl': imageUrl,
        'password':password
       
      });

      // Navigate to HomePagesScreen
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomePagesScreen(userId: userCredential.user?.uid ?? '',)),
        (Route<dynamic> route) => false,
      );
    } catch (e) {
      _showSnackBar('Error: $e');
    }
  }

  // Upload image to Firebase Storage and return the image URL
  Future<String?> _uploadImage(File image) async {
    try {
      final storageRef = FirebaseStorage.instance.ref().child('profile_images/${DateTime.now().toIso8601String()}');
      final uploadTask = storageRef.putFile(image);
      final snapshot = await uploadTask.whenComplete(() {});
      final downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }

  // Show a snack bar with a message
  void _showSnackBar(String message) {
    _scaffoldKey.currentState?.hideCurrentSnackBar();
    _scaffoldKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontFamily: 'Lato',
          ),
        ),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _scaffoldKey,
      child: Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          title: const Text(
            'Employee Signup',
            style: TextStyle(
              color: Colors.blue,
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
          elevation: 1,
          shadowColor: Colors.deepOrange,
        ),
        body: Stepper(
          type: StepperType.horizontal,
          connectorColor:
              const WidgetStatePropertyAll(Color.fromARGB(255, 0, 200, 0)),
          connectorThickness: 2,
          currentStep: _currentStep,
          onStepContinue: _onStepContinue,
          onStepCancel: _onStepCancel,
          elevation: 0,
          steps: [
            Step(
              title: const Text('Account'),
              content: _buildAccountForm(),
              isActive: _currentStep >= 0,
              state: _getStepState(0),
            ),
            Step(
              title: const Text('Complete Profile'),
              content: _buildPersonalInfoForm(),
              isActive: _currentStep >= 1,
              state: _getStepState(1),
            ),
          ],
          controlsBuilder: (BuildContext context, ControlsDetails details) {
            return Row(
              children: <Widget>[
                const SizedBox(height: 70),
                ElevatedButton(
                  onPressed: details.onStepContinue,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0095FF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    _currentStep == 1 ? 'Create Account' : "Continue",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                _currentStep == 0
                    ? const SizedBox()
                    : TextButton(
                        onPressed: details.onStepCancel,
                        child: const Text(
                          'Back',
                          style: TextStyle(
                            color: Colors.purple,
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                          ),
                        ),
                      ),
              ],
            );
          },
        ),
      ),
    );
  }

  // Build form for Step 1: Account details
  Form _buildAccountForm() {
    return _buildForm(
      _formKeys[0],
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: _pickImageFromGallery,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurpleAccent,
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              child: Text(
                'Pick Image',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            ),
            _selectedImage != null
                ? Image.file(File(_selectedImage!.path), height: 100, width: 100)
                : const Text('No image selected'),
          ],
        ),
        const SizedBox(height: 20),
        _buildTextFormField(
          controller: _fullNameController,
          label: 'Full Name',
          hintText: 'Enter your full name',
        ),
        const SizedBox(height: 20),
        _buildTextFormField(
          controller: _emailController,
          label: 'Email',
          hintText: 'Enter your email',
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 20),
        _buildTextFormField(
          controller: _passwordController,
          label: 'Password',
          hintText: 'Enter your password',
          obscureText: !passwordVisible,
          suffixIcon: IconButton(
            icon: Icon(
              passwordVisible ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: () {
              setState(() {
                passwordVisible = !passwordVisible;
              });
            },
          ),
        ),
        const SizedBox(height: 20),
        _buildTextFormField(
          controller: _phoneController,
          label: 'Phone Number',
          hintText: 'Enter your phone number',
          keyboardType: TextInputType.phone,
        ),
      ],
    );
  }

  // Build form for Step 2: Complete profile
  Form _buildPersonalInfoForm() {
    return _buildForm(
      _formKeys[1],
      children: [
        _buildTextFormField(
          controller: _addressController,
          label: 'Address',
          hintText: 'Enter your address',
        ),
        const SizedBox(height: 20),
        _buildTextFormField(
          controller: _descriptionController,
          label: 'Description',
          hintText: 'Enter a brief description',
        ),
        const SizedBox(height: 20),
        _buildSkillsSection(),
        const SizedBox(height: 20),
        _buildLanguagesSection(),
        const SizedBox(height: 20),
        _buildEducationSection(),
        const SizedBox(height: 20),
        CheckboxListTile(
          title: const Text('I accept the terms and conditions'),
          value: _termsAccepted,
          onChanged: (bool? value) {
            setState(() {
              _termsAccepted = value ?? false;
            });
          },
        ),
      ],
    );
  }

  // Build common form fields
  Form _buildForm(GlobalKey<FormState> formKey, {required List<Widget> children}) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  // Build text form field
  TextFormField _buildTextFormField({
    required TextEditingController controller,
    required String label,
    required String hintText,
    TextInputType? keyboardType,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
    );
  }

  // Build skills section
  Column _buildSkillsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTextFormField(
          controller: _skillController,
          label: 'Skill',
          hintText: 'Enter a skill',
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            if (_skillController.text.isNotEmpty) {
              setState(() {
                _skills.add(_skillController.text.trim());
                _skillController.clear();
              });
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurpleAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          child: const Text('Add Skill'),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 4,
          children: _skills
              .map((skill) => Chip(
                    label: Text(skill),
                    onDeleted: () {
                      setState(() {
                        _skills.remove(skill);
                      });
                    },
                  ))
              .toList(),
        ),
      ],
    );
  }

  // Build languages section
  Column _buildLanguagesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTextFormField(
          controller: _languageController,
          label: 'Language',
          hintText: 'Enter a language',
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            if (_languageController.text.isNotEmpty) {
              setState(() {
                _languages.add(_languageController.text.trim());
                _languageController.clear();
              });
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurpleAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          child: const Text('Add Language'),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 4,
          children: _languages
              .map((language) => Chip(
                    label: Text(language),
                    onDeleted: () {
                      setState(() {
                        _languages.remove(language);
                      });
                    },
                  ))
              .toList(),
        ),
      ],
    );
  }

  // Build education section
  Column _buildEducationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTextFormField(
          controller: _educationController,
          label: 'Education',
          hintText: 'Enter your education',
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            if (_educationController.text.isNotEmpty) {
              setState(() {
                _education.add(_educationController.text.trim());
                _educationController.clear();
              });
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurpleAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          child: const Text('Add Education'),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 4,
          children: _education
              .map((edu) => Chip(
                    label: Text(edu),
                    onDeleted: () {
                      setState(() {
                        _education.remove(edu);
                      });
                    },
                  ))
              .toList(),
        ),
      ],
    );
  }
}
