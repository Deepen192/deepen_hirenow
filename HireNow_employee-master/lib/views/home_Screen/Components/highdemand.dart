import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/consts/consts.dart';
import 'package:flutter_application_1/views/category/item_details.dart';
import 'package:get/get.dart';

class HighDemandJob extends StatelessWidget {
  final String userId;
  const HighDemandJob({Key? key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightGrey,
      appBar: AppBar(
        backgroundColor: const Color(0xFFDAD3BE),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "High Demand Jobs",
          textAlign: TextAlign.start,
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection(productsCollection)
                .where('flashsales', isEqualTo: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const CircularProgressIndicator();
              }

              var products = (snapshot.data!).docs;

              if (products.isNotEmpty) {
                return const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Tap on Images for details",
                    style: TextStyle(fontSize: 16, color: fontGrey),
                  ),
                );
              }

              return const SizedBox();
            },
          ),
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection(productsCollection)
                  .where('flashsales', isEqualTo: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                }

                var products = (snapshot.data!).docs;

                if (products.isEmpty) {
                  return const Center(
                    child: Text(
                      "No Job on Demand",
                      style: TextStyle(fontSize: 16),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    var productData = products[index].data();
                    var productName = productData['p_name'];
                    var productPrice = productData['pd_price'] != null && productData['pd_price'].isNotEmpty
                        ? double.tryParse(productData['pd_price']) ?? 0.0
                        : null;
                    var productImage = productData['p_imgs'][0];
                    var originalPrice = double.tryParse(productData['p_price']) ?? productPrice;

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
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ItemDetails(
                                      title: productName,
                                      data: productData, userId: userId,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
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
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              productName,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 4.0),
                            Row(
                              children: [
                                Text(
                                  "Rs.${originalPrice?.toStringAsFixed(2)}",
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
