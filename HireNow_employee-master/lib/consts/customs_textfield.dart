// TODO Implement this library.
import 'package:flutter_application_1/consts/consts.dart';
import 'package:flutter_application_1/widgets_common/text_style.dart';
 Widget customTextField({label,hint,controller, isDesc = false}){
  return TextFormField(
    style: const TextStyle(color: whiteColor),
    controller: controller,
    maxLines: isDesc ? 4:1,
    decoration: InputDecoration(
      isDense: true,
      label: normalText(text: label),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: whiteColor,
        )),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: whiteColor,
          )),
      hintText: hint,
      hintStyle: const TextStyle(color: lightGrey)
      
      ),
      
  );
 }