import 'package:flutter_application_1/consts/consts.dart'; 
Widget homeButtons({width,height,icon, String? title,onpress}){
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [Image.asset(icon, width: 26),10.heightBox,title!.text.fontFamily(semibold).color(darkFontGrey).make()],
  ).box.rounded.color(const Color(0xFFDAD3BE)).size(width, height).make();
}