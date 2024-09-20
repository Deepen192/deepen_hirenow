import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_application_1/consts/consts.dart';
import 'package:flutter_application_1/controllers/home_controller.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  final String userId;

  CartController({required this.userId});

  var totalP = 0.obs;
  // text controller for shipping details
  var addressController = TextEditingController();
  var firstnameController = TextEditingController();
  var lastnameController = TextEditingController();
  var postalcodeController = TextEditingController();
  var phoneController = TextEditingController();

  var paymentIndex = 0.obs;
  late dynamic productSnapshot;
  var products = [];
  var vendors = [];
  var placingOrder = false.obs;
   var pickedFileName = ''.obs;
  File? selectedFile; // For storing the selected file

  // Method to pick a file using FilePicker
  Future<void> pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {
        // Update the picked file name
        pickedFileName.value = result.files.single.name;
        selectedFile = File(result.files.single.path!); // Save the selected file
      } else {
        // User canceled the picker
      }
    } catch (e) {
      print('Error picking file: $e');
    }
  }

  Future<String?> uploadFileToStorage(File file) async {
    try {
      // Create a reference to the location you want to upload the file
      final storageRef = FirebaseStorage.instance.ref().child('order_files/${DateTime.now().millisecondsSinceEpoch}_${file.path.split('/').last}');
      
      // Upload the file to Firebase Storage
      final uploadTask = storageRef.putFile(file);
      await uploadTask;
      
      // Get the download URL of the uploaded file
      final downloadURL = await storageRef.getDownloadURL();
      return downloadURL;
    } catch (e) {
      print('Error uploading file: $e');
      return null;
    }
  }

  calculate(data) {
    totalP.value = 0;
    for (var i = 0; i < data.length; i++) {
      totalP.value = totalP.value + int.parse(data[i]['tprice'].toString());
    }
  }

  Future<List<DocumentSnapshot>> getCart() async {
    var querySnapshot = await FirebaseFirestore.instance
        .collection(cartCollection)
        .where('added_by', isEqualTo: userId)
        .get();
    return querySnapshot.docs;
  }

  changePaymentIndex(index) {
    paymentIndex.value = index;
  }

  placeMyOrder({required orderPaymentMethod, required totalAmount}) async {
    placingOrder(true);
    await getProductsDetails();
    String? fileUrl;
    if (selectedFile != null) {
      fileUrl = await uploadFileToStorage(selectedFile!);
    }

    var orderData = {
      'order_code': "233981237",
      'order_date': FieldValue.serverTimestamp(),
      'order_by': currentUser!.uid,
      'order_by_name': Get.find<HomeController>().username,
      'order_by_email': currentUser!.email,
      'order_by_address': addressController.text,
      'order_by_lastname': lastnameController.text,
      'order_by_firstname': firstnameController.text,
      'order_by_phone': phoneController.text,
      // "order_by_postalcode": postalcodeController.text,
      'shipping_method': "Home Delivery",
      'payment_method': orderPaymentMethod,
      'order_placed': true,
      'order_confirmed': false,
      'order_delivered': false,
      'order_on_delivery': false,
      'total_amount': totalAmount,
      'vendor_id': vendors.join(','), // Store vendors as comma-separated string
      'payment_status': false,
      'file_url': fileUrl, 
    };

    // Add products to the 'orders' field as an array
    orderData['orders'] = products.map((product) {
      return {
        
        'img': product['img'],
        'vendor_id': product['vendor_id'],
        'tprice': product['tprice'],
        'qty': product['qty'],
        'title': product['title'],
        'p_id':product['p_id'],
        
      };
    }).toList();

    await firestore.collection(ordersCollection).doc().set(orderData);
    placingOrder(false);
  }
   Future<void> placeKhaltiOrder() async {
    placingOrder(true);
    await getProductsDetails();
    String? fileUrl;
    if (selectedFile != null) {
      fileUrl = await uploadFileToStorage(selectedFile!);
    }

    var orderData = {
      'order_code': "233981237",
      'order_date': FieldValue.serverTimestamp(),
      'order_by': currentUser!.uid,
      'order_by_name': Get.find<HomeController>().username,
      'order_by_email': currentUser!.email,
      'order_by_address': addressController.text,
      'order_by_lastname': lastnameController.text,
      'order_by_firstname': firstnameController.text,
      'order_by_phone': phoneController.text,
      // "order_by_postalcode": postalcodeController.text,
      'shipping_method': "Home Delivery",
      'payment_method': "Khalti",
      'order_placed': true,
      'order_confirmed': false,
      'order_delivered': false,
      'order_on_delivery': false,
      'total_amount': totalP.value,
      'vendor_id': vendors.join(','), // Store vendors as comma-separated string
      'payment_status': false,
      'file_url': fileUrl, 
    };

   // Add products to the 'orders' field as an array
    orderData['orders'] = products.map((product) {
      return {
        
        'img': product['img'],
        'vendor_id': product['vendor_id'],
        'tprice': product['tprice'],
        'qty': product['qty'],
        'title': product['title'],
        'p_id':product['p_id'],
        
      };
    }).toList();

    await firestore.collection(ordersCollection).doc().set(orderData);
    placingOrder(false);
  }

  getProductsDetails() {
    products.clear();
    vendors.clear();
    for (var i = 0; i < productSnapshot.length; i++) {
      products.add({
        'img': productSnapshot[i]['img'],
        'vendor_id': productSnapshot[i]['vendor_id'],
        'tprice': productSnapshot[i]['tprice'],
        'qty': productSnapshot[i]['qty'],
        'title': productSnapshot[i]['title'],
        'p_id':productSnapshot[i]['p_id']
      });
      vendors.add(productSnapshot[i]['vendor_id']);
    }
  }

  clearCart() {
    for (var i = 0; i < productSnapshot.length; i++) {
      firestore.collection(cartCollection).doc(productSnapshot[i].id).delete();
    }
  }
}