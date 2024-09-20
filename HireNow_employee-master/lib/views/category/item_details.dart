import 'package:flutter_application_1/consts/consts.dart';
import 'package:flutter_application_1/controllers/product_controller.dart';
import 'package:flutter_application_1/services/firestore_services.dart';
import 'package:flutter_application_1/views/brand/office_screen.dart';
import 'package:flutter_application_1/views/cart/confirm_screen.dart';
import 'package:flutter_application_1/views/chat_screen/chat_screen.dart';

import 'package:flutter_application_1/widgets_common/our_button.dart';
import 'package:get/get.dart';

class ItemDetails extends StatelessWidget {
  final String? title;
  final dynamic data;
  final String userId;
    final bool showIcon;
  
  const ItemDetails({super.key, required this.title,this.data, required this.userId,this.showIcon=true,});

  @override
  Widget build(BuildContext context) {   
   var controller = Get.put(JobController(userId));
    return WillPopScope(
      onWillPop: () async{
        controller.resetValues();
        return true;
      },

    
      child: Scaffold(
        backgroundColor: lightGrey,
        appBar: AppBar(
          backgroundColor: const Color(0xFFDAD3BE),
          iconTheme: const IconThemeData(color: Colors.white),
          leading:
          IconButton(
            onPressed:(){
            controller.resetValues();
            Get.back();
          },
          icon:const Icon(Icons.arrow_back),
          ),
          title: title!.text.color(Colors.black).fontFamily(bold).make(),
          actions: [ 
            // IconButton(
            //   icon: const Icon(Icons.shopping_cart),
            //   onPressed: () {
            //     Get.to(() => ConfirmScreen(fromItemDetails: true, userId: userId));
            //   },
            // ),    
             Obx(
               () => IconButton(
                onPressed: () {
                if(controller.isFav.value){
                  controller.removeFromWishlist(data.id,context);
                  
                }else{
                  controller.addToWishlist(data.id,context);               
                }
               }, icon: Icon(
                Icons.favorite_outlined,
                color: controller.isFav.value ? Colors.grey :whiteColor,
                )),
             ),

          ],
        ),
        body: Column(
          children: [
            Expanded(
              child:Padding(
              padding:const EdgeInsets.all(8),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //swiper section
                    VxSwiper.builder(
                      autoPlay: true,
                      height: 350,
                      itemCount: data['p_imgs'].length,
                      aspectRatio: 16 / 9, 
                      viewportFraction: 1.0,
                      itemBuilder: (context, index) {
                      return Image.network(
                        data["p_imgs"][index], 
                        width: double.infinity,
                        fit: BoxFit.cover,
                        );
                    }),
                    10.heightBox,
                    //title.text.make
                    title!.text.size(16).color(darkFontGrey).fontFamily(semibold).make(),
                    10.heightBox,
                    //rating
                  VxRating(
                isSelectable: true,
                value: 0, // Set initial value to 0
                onRatingUpdate: (value) async {
                  String productId = data.id;

                  // Fetch the current user's data
                  var userSnapshot = await FirestoreServices.getUser(currentUser!.uid).first;

                  // Extract the user's ID from the snapshot
                  String userId = userSnapshot.docs.first['id'];

                  String userRating = value.toString();

                  String result = await controller.addRating(productId, userId, userRating, context);

                  // Display the result message to the user
                  VxToast.show(context, msg: result);
                },
                normalColor: textfieldGrey,
                selectionColor: golden,
                count: 5,
                maxRating: 5,
                size: 25,
              ),


                      10.heightBox,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (data['pd_price'] != null && data['pd_price'].isNotEmpty) ...[
                            // Display both p_price with strikethrough and pd_price
                            Text(
                              "Pay:Rs.${data['p_price']}",
                              style: const TextStyle(
                                color: Colors.black,
                                fontFamily: bold,
                                fontSize: 18,
                                
                              ),
                            ),
                            10.heightBox,
                            Text(
                              "Discount:${data['pd_percentage']}%",
                              style: const TextStyle(
                                color: Colors.black,
                                fontFamily: bold,
                                fontSize: 18,
                              ),
                            ),
                          ] else
                            // Display only p_price when pd_price is null or empty
                            Text(
                              "Price: Rs.${data['p_price']}",
                              style: const TextStyle(
                                color: Colors.orange,
                                fontFamily: bold,
                                fontSize: 18,
                              ),
                            ),
                        ],
                      ),
                      10.heightBox,
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "Seller".text.white.fontFamily(semibold).make(),
                              5.heightBox,
                              "${data['p_seller']}".text.fontFamily(semibold).color(darkFontGrey).size(16).make()
                            ],
                          )),
                           if (showIcon)
                          CircleAvatar(
                            backgroundColor: const Color(0xFFEF9C66),
                            child: IconButton(
                              icon: const Icon(Icons.person,color: whiteColor,),
                              onPressed: () {
                                Get.to(() => AboutShop(vendorId: data['vendor_id'],
                                userId: userId, data:'p_seller',));
                              },
                            ),
                          ),
                          const SizedBox(width: 20,),
                          const CircleAvatar(
                            backgroundColor: Color(0xFFEF9C66),
                            child: Icon(Icons.message_rounded, color: whiteColor),
                          ).onTap(() {
                            Get.to(
                              () => ChatScreen(userId:userId,),
                            arguments: [data['p_seller'], data['vendor_id']],
                            );
                          }),
                        ],
                      ).box.height(60).padding(const EdgeInsets.symmetric(horizontal: 16)).color(textfieldGrey).make(),
                      
                      //color section
                      
                      20.heightBox,
                      Obx(
                        () => Column(
                          children: [                            
                            
                            //quantity  row
                             Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                  child: "Vacancy: ".text.color(textfieldGrey).make(),
                                ),
                               Row(
                                 children: [
                            
                            controller.quantity.value.text.size(16).color(darkFontGrey).fontFamily(bold).make(),
                            
                            10.widthBox,
                            "(${data['p_quantity']} available)".text.color(textfieldGrey).make(),
                          ],
                           ),                                
                              ],
                            ).box.padding(const EdgeInsets.all(8)).make(),                           
                          ],
                        ).box.white.shadowSm.make(),
                      ),
                      // description section
                      10.heightBox,
                      "Description".text.color(darkFontGrey).fontFamily(semibold).make(),
                      10.heightBox,
                      "${data['p_desc']}".text.color(darkFontGrey).make(),                     
                      20.heightBox,
                  ],
                ),
              ),
            )),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ourButton(color: const Color(0xFFEF9C66), 
              onPress: (){
                 int price = int.tryParse(data['pd_price']) ?? int.tryParse(data['p_price']) ?? 0;
                  controller.calculateTotalPrice(price);
                if(controller.quantity.value > 0){
                  controller.addToCart(                 
                  context: context,
                  vendorID: data['vendor_id'],
                  img:data['p_imgs'][0],
                  qty: controller.quantity.value,
                  sellername: data['p_seller'],
                  title: data['p_name'],
                  productId: data['p_id'],
                  tprice: controller.totalPrice.value);
                  VxToast.show(context, msg: "Confirm Your Process");
                  Get.to(() => ConfirmScreen(userId:userId,));
                } else{
                  VxToast.show(context, msg: "Restart App");
                }
              }, 
              textColor: whiteColor,
               title: "Next"),
            ),
          ],
        ),
      ),
    );
  }
}