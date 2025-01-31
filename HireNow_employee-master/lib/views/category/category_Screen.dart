import 'package:flutter_application_1/consts/consts.dart';
import 'package:flutter_application_1/controllers/product_controller.dart';
import 'package:flutter_application_1/views/category/category_details.dart';
import 'package:flutter_application_1/widgets_common/bg_widget.dart';
import 'package:get/get.dart'; 
class CategoryScreen extends StatelessWidget {
  final String userId;
  const CategoryScreen({Key? key, required this.userId});

  @override
  Widget build(BuildContext context) {    
    var controller= Get.put(JobController(userId));   
    return bgWidget(
      child:Scaffold(
        appBar:AppBar(
          backgroundColor: const Color(0xFFDAD3BE),
          title:categories.text.fontFamily(bold).color(Colors.black).make(),
        ),
        body: Container(
          padding:const EdgeInsets.all(12),
          child:GridView.builder(
            shrinkWrap: true,
            itemCount: 9,
            gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, mainAxisSpacing: 8,crossAxisSpacing: 8,mainAxisExtent: 200),
            itemBuilder:(context,index){
           return Column(
            children: [
              Image.asset(categoryImages[index],height: 120,width:200 ,fit: BoxFit.cover,),
              10.heightBox,
              categoriesList[index].text.color(darkFontGrey).align(TextAlign.center).make(),
              ],
           ).box.white.rounded.clip(Clip.antiAlias).outerShadowSm.make().onTap(() {
            controller.getSubCategories(categoriesList[index]);
            Get.to(()=>CategoryDetails(title: categoriesList[index], userId:userId,));
           });
          }),
      ),
    ));
  
  }
}