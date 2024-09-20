import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/consts/consts.dart';
import 'package:flutter_application_1/services/firestore_services.dart';
import 'package:flutter_application_1/views/category/item_details.dart';
import 'package:get/get.dart';

class WeeklyDeal extends StatelessWidget {
  final String userId;
  const WeeklyDeal({Key? key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: const Color(0xFFDAD3BE),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Weekly Deal",
          style: TextStyle(color:Colors.black),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Tap on images for details",
              style: TextStyle(fontSize: 16, color: fontGrey),
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: FirestoreServices.alljobs(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                }

                var filteredProducts = (snapshot.data! as QuerySnapshot).docs.where((productDoc) {
                  var productData = productDoc.data() as Map<String, dynamic>;
                  var pdPrice = productData['pd_price'];
                  var pdPercentage = productData['pd_percentage'];

                  return pdPrice != null && pdPrice.isNotEmpty && pdPercentage != null && pdPercentage.isNotEmpty;
                }).toList();

                if (filteredProducts.isEmpty) {
                  return const Center(
                    child: Text(
                      "No deals available today.",
                      style: TextStyle(fontSize: 16),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: filteredProducts.length,
                  itemBuilder: (context, index) {
                    var productData = filteredProducts[index].data() as Map<String, dynamic>;
                    var productName = productData['p_name'];
                    var productPrice = productData['pd_price'] != null && productData['pd_price'].isNotEmpty
                        ? double.tryParse(productData['pd_price']) ?? 0.0
                        : null;
                    var productImage = productData['p_imgs'][0];
                    var originalPrice = double.tryParse(productData['p_price']) ?? (productPrice ?? 0.0);

                    return GestureDetector(
                      onTap: () {
                        Get.to(() => ItemDetails(
                          title: productName,
                          data: productData, userId: userId,
                        ));
                      },
                      child: Container(
                        margin: const EdgeInsets.all(5.0),
                        padding: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          color:(const Color(0xFFDAD3BE)), // Set background color here
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: double.infinity,
                              height: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                image: DecorationImage(
                                  image: NetworkImage(productImage),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              productName,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.start,
                            ),
                            const SizedBox(height: 4.0),
                            Row(
                              children: [
                                Text(
                                  "Rs.${originalPrice.toStringAsFixed(2)}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    // Apply strikethrough only when pd_price is present
                                    decoration: productPrice != null
                                        ? TextDecoration.lineThrough
                                        : TextDecoration.none,
                                  ),
                                ),
                                if (productPrice != null) ...[
                                  const SizedBox(width: 10),
                                  Text(
                                    "Rs.${productPrice.toStringAsFixed(2)}",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                            const SizedBox(height: 8.0),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
