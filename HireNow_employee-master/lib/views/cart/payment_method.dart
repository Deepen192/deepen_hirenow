import 'package:flutter_application_1/consts/consts.dart';
import 'package:flutter_application_1/controllers/confirm&form_controller.dart';
import 'package:flutter_application_1/views/cart/khalti.dart';
import 'package:flutter_application_1/views/home_Screen/home_pages.dart';
import 'package:flutter_application_1/widgets_common/loading_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class PaymentMethods extends StatelessWidget {
  final String userId;
  final String productId;
  final int qty;
  const PaymentMethods({Key? key, required this.userId, required this.productId, required this.qty});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();

    // Function to update product quantity in Firestore
    Future<void> updateProductQuantity(String productId, int qty) async {
      try {
        
        // Get a reference to the product document
        DocumentReference productRef = FirebaseFirestore.instance.collection(productsCollection).doc(productId);

        // Get the current p_quantity
        DocumentSnapshot productSnapshot = await productRef.get();
        if (productSnapshot.exists) {
          String currentQuantityStr = productSnapshot['p_quantity'];
          int currentQuantity = int.parse(currentQuantityStr);

          // Calculate the new quantity after subtracting qty
          int newQuantity = currentQuantity - qty;
          String newQuantityStr = newQuantity.toString();

          // Update p_quantity in Firestore
          await productRef.update({'p_quantity': newQuantityStr});

          print('Product quantity updated successfully');
        } else {
          print('Product document does not exist');
        }
      } catch (e) {
        print('Error updating product quantity: $e');
      }
    }

    return Obx(
      () => Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: SizedBox(
          height: 60,
          child: controller.placingOrder.value
              ? Center(child: loadingIndicator())
              : const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Add bottom navigation bar buttons if needed
                  ],
                ),
        ),
        appBar: AppBar(
          title: const Text(
            "Choose Payment Method",
            style: TextStyle(fontFamily: 'semibold', color: Colors.black),
          ),
          backgroundColor: const Color(0xFFDAD3BE),
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              const SizedBox(height: 200),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // First Payment Method: Khalti
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        await controller.placeKhaltiOrder();
                        await updateProductQuantity(productId, qty);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => KhaltiPaymentPage(userId: userId, jobId: '', jobData: {},),
                          ),
                        );
                      },
                      child: Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.transparent,
                            width: 4,
                          ),
                        ),
                        margin: const EdgeInsets.only(bottom: 8),
                        child: Column(
                          children: [
                            Image.asset(
                              paymentMethodsImg[0], // First payment method image
                              width: double.infinity,
                              height: 140,
                              fit: BoxFit.cover,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                await controller.placeKhaltiOrder();
                                await updateProductQuantity(productId, qty);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => KhaltiPaymentPage(userId: userId, jobId: '', jobData: {},),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange,
                                textStyle: const TextStyle(color: Colors.white),
                              ),
                              child: const Text("Pay with Khalti"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  // Second Payment Method: Cash on Delivery
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        String selectedPaymentMethod = "Cash on Delivery";
                        await controller.placeMyOrder(
                          orderPaymentMethod: selectedPaymentMethod,
                          totalAmount: controller.totalP.value,
                        );
                        await updateProductQuantity(productId, qty);
                        await controller.clearCart();
                        Get.offAll(() =>  HomePagesScreen(userId: userId,));

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Order placed successfully'),
                          ),
                        );
                      },
                      child: Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.transparent,
                            width: 4,
                          ),
                        ),
                        margin: const EdgeInsets.only(bottom: 8),
                        child: Column(
                          children: [
                            Image.asset(
                              paymentMethodsImg[1], // Second payment method image
                              width: double.infinity,
                              height: 140,
                              fit: BoxFit.cover,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                String selectedPaymentMethod = "Cash on Delivery";
                                await controller.placeMyOrder(
                                  orderPaymentMethod: selectedPaymentMethod,
                                  totalAmount: controller.totalP.value,
                                );
                                await updateProductQuantity(productId, qty);
                                await controller.clearCart();
                                Get.offAll(() =>  HomePagesScreen(userId:userId,));

                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Order placed successfully'),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange,
                                textStyle: const TextStyle(color: Colors.white),
                              ),
                              child: const Text("Cash on Delivery"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
