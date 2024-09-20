import 'package:flutter_application_1/consts/consts.dart';
import 'package:flutter_application_1/views/category/category_details.dart';
import 'package:get/get.dart';
Widget featuredButton({String ? title, icon}){
  return Row(
    children: [
      Image.asset(icon,width: 60,height:40, fit: BoxFit.fill),
      10.widthBox,
      title!.text.fontFamily(semibold).color(darkFontGrey).make(),
    ],
  ).box.width(200)
  .margin(const EdgeInsets.symmetric(horizontal: 4))
  .color(const Color(0xFFDAD3BE))
  .padding(const EdgeInsets.all(4))
  .roundedSM.outerShadowSm
  .make()
  .onTap(() {
    Get.to(() => CategoryDetails(title: title, userId: '',));
  });
}