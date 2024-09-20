import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/consts/consts.dart';
import 'package:flutter_application_1/services/firestore_services.dart';
import 'package:flutter_application_1/views/orders_screen/orders_details.dart';
import 'package:flutter_application_1/widgets_common/loading_indicator.dart';
import 'package:get/get.dart';

class OrdersScreen extends StatelessWidget {
  final String userId;

  const OrdersScreen({Key? key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: const Color(0xFFDAD3BE),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "My Orders",
          style: TextStyle(color: Colors.black, fontFamily: 'semibold'),
        ),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getAllOrders(userId),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: loadingIndicator(),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                "No orders yet!",
                style: TextStyle(color: darkFontGrey),
              ),
            );
          } else {
            var data = snapshot.data!.docs;

            return Container(
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  List<dynamic> ordersArray = data[index]['orders'];
                  if (ordersArray.isNotEmpty) {
                    Map<String, dynamic> firstOrder = ordersArray[0];
                    String title = firstOrder['title'];
                    String imageUrl = firstOrder['img']; // Assuming the image URL is stored under 'img'
                    return GestureDetector(
                      onTap: () {
                        Get.to(() => OrdersDetails(data: data[index]));
                      },
                      child: Container(
                        margin: const EdgeInsets.all(8.0),
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color:(const Color(0xFFDAD3BE)),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Row(
                          children: [
                            Image.network(
                              imageUrl,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    title,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'semibold',
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "Rs.${data[index]['total_amount']}",
                                    style: const TextStyle(
                                      fontFamily: 'bold',
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: darkFontGrey,
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            );
          }
        },
      ),
    );
  }
}

