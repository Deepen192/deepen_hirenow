import 'package:flutter_application_1/consts/consts.dart';

Widget confirmButton({required VoidCallback onPress, required Color color, required Color textColor, required String title}) {
  return Expanded(
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.all(12),
      ),
      onPressed: onPress,
      child: title.text.color(textColor).fontFamily(bold).make(),
    ),
  );
}
