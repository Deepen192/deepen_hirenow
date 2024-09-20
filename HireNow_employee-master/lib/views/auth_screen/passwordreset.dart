import 'package:get/get.dart';
import 'package:flutter_application_1/consts/consts.dart';
import 'package:flutter_application_1/controllers/auth_controller.dart';  // ensure correct casing

class ForgotPasswordScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final AuthController authController = Get.find<AuthController>();

  ForgotPasswordScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
         backgroundColor: const Color(0xFFEF9C66),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Forgot Password',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Enter your email here",
              style: TextStyle(color: Color(0xFFEF9C66), fontSize: 18),
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(color: Color(0xFFEF9C66)),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
              style: const TextStyle(color: Colors.black),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                await _resetPassword(context, authController);
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black, backgroundColor: lightGolden, // Text color
                elevation: 0, // Set elevation to 0 to remove shadow
              ),
              child: const Text(
                'Reset Password',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _resetPassword(BuildContext context, AuthController authController) async {
    if (emailController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter your email');
      return;
    }

    // Show loading indicator
    Get.dialog(
      const Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );

    // Trigger password reset
    var result = await authController.resetPassword(
      email: emailController.text,
      context: context,
    );

    // Close loading indicator
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }

    if (result) {
      Get.snackbar('Success', 'Password reset email sent', colorText: Colors.black);
    } else {
      Get.snackbar('Error', 'Email not Found. Please try again.', colorText: Colors.black);
    }
  }
}
