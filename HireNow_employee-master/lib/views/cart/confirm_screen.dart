import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/consts/consts.dart';
import 'package:flutter_application_1/controllers/confirm&form_controller.dart';
import 'package:flutter_application_1/services/firestore_services.dart';
import 'package:flutter_application_1/views/cart/form_screen.dart';
import 'package:flutter_application_1/widgets_common/confirm_button.dart';
import 'package:flutter_application_1/widgets_common/loading_indicator.dart';
import 'package:flutter_application_1/widgets_common/our_button.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ConfirmScreen extends StatelessWidget {
  final bool fromItemDetails;
  final String userId;

  const ConfirmScreen({Key? key, required this.fromItemDetails, required this.userId});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CartController(userId: userId));

    return Scaffold(
      backgroundColor: whiteColor,
      bottomNavigationBar: SizedBox(
        height: 60,
        child: StreamBuilder<QuerySnapshot>(
          stream: FirestoreServices.getCart(userId),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return loadingIndicator();
            } else if (snapshot.data!.docs.isEmpty) {
              return ourButton(
                color: Colors.orange,
                onPress: () {
                  Get.back();
                }, // Disable the button when cart is empty
                textColor: whiteColor,
                title: "Get Back",
              );
            } else {
              var productId = snapshot.data!.docs.first['p_id'];
              var qty = snapshot.data!.docs.first['qty'];
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  confirmButton(
                    color: Colors.green,
                    onPress: () async {
                      if (snapshot.data!.docs.isNotEmpty) {
                        Get.to(() => FormScreeen(userId: userId, productId: productId, qty: qty));
                      }
                    },
                    textColor: whiteColor,
                    title: "Yes",
                  ),
                  confirmButton(
                    color: Colors.blue,
                    onPress: () async {
                      Get.back();
                      // Clear the cart
                      for (var doc in snapshot.data!.docs) {
                        await doc.reference.delete();
                      }
                       // Go back to the previous screen
                    },
                    textColor: whiteColor,
                    title: "No",
                  ),
                ],
              );
            }
          },
        ),
      ),
      appBar: AppBar(
        backgroundColor: const Color(0xFFDAD3BE),
        iconTheme: const IconThemeData(color: Colors.white),
        title: "Confirm".text.color(Colors.black).fontFamily(semibold).make(),
        automaticallyImplyLeading: false, // Show the back arrow only if opened from ItemDetails
        leading: fromItemDetails
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Get.back();
                },
              )
            : null,
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getCart(userId),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: loadingIndicator());
          } else if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: "You Cancled The Request".text.color(darkFontGrey).make(),
            );
          } else {
            var data = snapshot.data!.docs;
            controller.calculate(data);
            controller.productSnapshot = data;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        var timestamp = data[index]['timestamp'] as Timestamp?;
                        String formattedDate = '';
                        if (timestamp != null) {
                          var date = timestamp.toDate();
                          formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(date);
                        }
                        return ListTile(
                          leading: Image.network(
                            "${data[index]['img']}",
                            fit: BoxFit.cover,
                            width: 90,
                          ),
                          title: "${data[index]['title']}"
                              .text
                              .fontFamily(semibold)
                              .size(16)
                              .make(),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "Rs.${data[index]['tprice']}"
                                  .text
                                  .color(Colors.orange)
                                  .fontFamily(semibold)
                                  .make(),
                              if (formattedDate.isNotEmpty)
                                Text(
                                  'Added on: $formattedDate',
                                  style: const TextStyle(color: Colors.green),
                                ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  10.heightBox,
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
