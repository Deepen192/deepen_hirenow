import 'package:flutter/services.dart'; // Import for LengthLimitingTextInputFormatter
import 'package:flutter_application_1/consts/consts.dart';

class customTextField extends StatefulWidget {
  final String? title;
  final String? hint;
  final TextEditingController? controller;
  final bool isPass;
  final bool isNumericKeyboard;
  final int? maxLength; // Maximum length for the input

  const customTextField({
    super.key,
    this.title,
    this.hint,
    this.controller,
    this.isPass = false,
    this.isNumericKeyboard = false, // Default to false
    this.maxLength, // Maximum length for the input
  });

  @override
  _customTextFieldState createState() => _customTextFieldState();
}

class _customTextFieldState extends State<customTextField> {
  late bool _isObscure;

  @override
  void initState() {
    super.initState();
    _isObscure = widget.isPass;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.title!.text.color(Colors.orange).fontFamily(semibold).size(16).make(),
        5.heightBox,
        TextFormField(
          obscureText: _isObscure,
          controller: widget.controller,
          keyboardType: widget.isNumericKeyboard ? TextInputType.number : TextInputType.text, // Set keyboard type
          inputFormatters: widget.maxLength != null ? [LengthLimitingTextInputFormatter(widget.maxLength!)] : null, // Limit input based on maxLength
          decoration: InputDecoration(
            hintStyle: const TextStyle(
              fontFamily: semibold,
              color: textfieldGrey,
            ),
            hintText: widget.hint,
            isDense: true,
            fillColor: lightGrey,
            filled: true,
            border: InputBorder.none,
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: redColor),
            ),
            // Add suffix icon for password field
            suffixIcon: widget.isPass
                ? IconButton(
                    icon: Icon(
                      // Change icon based on _isObscure value
                      _isObscure ? Icons.visibility : Icons.visibility_off,
                      color: textfieldGrey,
                    ),
                    onPressed: () {
                      setState(() {
                        // Toggle _isObscure value on icon tap
                        _isObscure = !_isObscure;
                      });
                    },
                  )
                : null,
          ),
        ),
        5.heightBox,
      ],
    );
  }
}
