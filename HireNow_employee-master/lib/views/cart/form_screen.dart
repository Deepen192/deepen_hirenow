import 'package:flutter_application_1/consts/consts.dart';
import 'package:flutter_application_1/controllers/confirm&form_controller.dart';
import 'package:flutter_application_1/services/firestore_services.dart';
import 'package:flutter_application_1/views/cart/payment_method.dart';
import 'package:flutter_application_1/widgets_common/custom_textfield.dart';
import 'package:flutter_application_1/widgets_common/our_button.dart';
import 'package:get/get.dart';

class FormScreeen extends StatefulWidget {
  final String userId;
   final String productId;
   final int qty;
  const FormScreeen({Key? key, required this.userId, required this.productId, required this.qty});

  @override
  _FormScreeenState createState() => _FormScreeenState();
}

class _FormScreeenState extends State<FormScreeen> {
  late CartController controller;
  Map<String, dynamic>? existingData;

  @override
  void initState() {
    controller = Get.put(CartController(userId: widget.userId));
    super.initState();
    fetchExistingData();
  }

  Future<void> fetchExistingData() async {
    try {
      var querySnapshot = await FirestoreServices.getLatestOrder(widget.userId).first;
      if (querySnapshot.docs.isNotEmpty) {
        var doc = querySnapshot.docs.first;
        setState(() {
          existingData = doc.data() as Map<String, dynamic>;
        });
      }
    } catch (e) {
      print('Error fetching existing data: $e');
    }
  }

  void prefillForm() {
    if (existingData != null) {
      controller.addressController.text = existingData!['order_by_address'];
      controller.firstnameController.text = existingData!['order_by_firstname'];
      controller.lastnameController.text = existingData!['order_by_lastname'];
      // controller.postalcodeController.text = existingData!['order_by_postalcode'];
      controller.phoneController.text = existingData!['order_by_phone'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDAD3BE),
      appBar: AppBar(
        title: "Fill Form".text.fontFamily(semibold).color(Colors.black).make(),
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: ourButton(
          onPress: () async {
            if (controller.addressController.text.length >= 10 ||
                controller.firstnameController.text.length >= 3 ||
                controller.lastnameController.text.length >= 3 ||
                controller.postalcodeController.text.length >= 3 ||
                controller.phoneController.text.length >= 6) {
              await FirestoreServices.deleteAllDocumentsByUserId(widget.userId);
              Get.to(() => PaymentMethods(userId: widget.userId, productId:widget.productId,qty:widget.qty,));
            } else {
              VxToast.show(context, msg: "Please fill the form correctly");
            }
          },
          color: Colors.orange,
          textColor: whiteColor,
          title: "Continue",
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              // Show existing data box only if existingData is not null
             
              
              customTextField(hint: "First Name", isPass: false, title: "First Name", controller: controller.firstnameController),
              customTextField(hint: "Last Name", isPass: false, title: "Last Name", controller: controller.lastnameController),
              customTextField(hint: "Address", isPass: false, title: "Address", controller: controller.addressController),
              // customTextField(
              //   hint: "Postal Code",
              //   isPass: false,
              //   title: "Postal Code",
              //   controller: controller.postalcodeController,
              //   isNumericKeyboard: true,
              //   maxLength: 5,
              // ),
              customTextField(
                hint: "Phone",
                isPass: false,
                title: "Phone",
                controller: controller.phoneController,
                isNumericKeyboard: true,
                maxLength: 10,
              ),
               Row(
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      await controller.pickFile();
                    },
                    child: Text('Pick a File'),
                  ),
                  SizedBox(width: 10),
                  Obx(() => Text(
                        'Picked File: ${controller.pickedFileName.value}',
                        style: TextStyle(fontSize: 16),
                      )),
                ],
              ),
              const SizedBox(height: 20,),
               if (existingData != null)
                GestureDetector(
                  onTap: () {
                    prefillForm();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Tap For Autofill Your Details', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        Text('First Name: ${existingData!['order_by_firstname']}'),
                        Text('Last Name: ${existingData!['order_by_lastname']}'),
                        Text('Address: ${existingData!['order_by_address']}'),                        
                        // Text('Postal Code: ${existingData!['order_by_postalcode']}'),
                        Text('Phone: ${existingData!['order_by_phone']}'),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
