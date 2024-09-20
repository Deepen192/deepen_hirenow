import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/consts/consts.dart';
import 'package:flutter_application_1/models/category_model.dart';
import 'package:get/get.dart';

class JobController extends GetxController {
  final String userId;

  JobController(this.userId);
  var quantity =1.obs;
  var colorIndex = 0.obs;
  var totalPrice =0.obs;
  var subcat =[];
  var isFav = false.obs;

  getSubCategories(title) async {
    subcat.clear();
    var data = await rootBundle.loadString("lib/services/category_model.json");
    var decoded = categoryModelFromJson(data);
    var s = decoded.categories.where((element) => element.name ==title).toList();

    for (var e in s[0].subcategory) {
      subcat.add(e);
    }

  }
  changColorIndex(index){
     colorIndex.value = index;
  }

  increaseQuantity(totalQuantity){
    if(quantity.value<totalQuantity){
    quantity.value++;
    }

  }
  decreaseQuantity(){
    if(quantity.value >0){
       quantity.value--;
    }
   
  }

  calculateTotalPrice(price){
    totalPrice.value = price* 1;
  }
  
  addToCart({
    title, img, sellername, color, qty, tprice,context,vendorID,productId}) async {
    await firestore.collection(cartCollection).doc().set({
      'title': title,
      'img': img,
      'sellername': sellername,
      'color': color,
      'qty': qty,
      'tprice' : tprice,
      'vendor_id': vendorID,
      'added_by': userId,
      'p_id':productId,
      'timestamp': FieldValue.serverTimestamp(),

    }).catchError((error){
      VxToast.show(context, msg: error.toString());
    });
  }

  resetValues(){
    totalPrice.value = 0;
    quantity.value = 1 ;
    colorIndex.value = 0;
    isFav.value =false;
  }
  addToWishlist(docId,context) async{
    await firestore.collection(productsCollection).doc(docId).set({
      'p_wishlist':FieldValue.arrayUnion([userId])
    }, SetOptions(merge:true));
    isFav(true);  
     VxToast.show(context, msg: "Added to wishlist");   

  }

  removeFromWishlist(docId,context) async{
    await firestore.collection(productsCollection).doc(docId).set({
      'p_wishlist':FieldValue.arrayRemove([userId])
    }, SetOptions(merge:true));   
    isFav(false);
    VxToast.show(context, msg: "Remove from wishlist");
   
  }

  checkIfFav(data)async {
    if(data['p_wishlist'].contains(userId)){
      isFav(true);
    }else {
      isFav(false);
    }
  }
 Future<String> addRating(String productId, String userId, String rating, BuildContext context) async {
  try {
    var productDoc = firestore.collection(productsCollection).doc(productId);

    // Fetch the current ratings list from the document
    var productSnapshot = await productDoc.get();
    List<Map<String, dynamic>> ratings = List<Map<String, dynamic>>.from(productSnapshot.data()?['p_ratings'] ?? []);

    // Add the new rating to the list
    ratings.add({
      'id': userId,
      'rating': rating,
    });

    // Update the ratings list in the Firestore document
    await productDoc.update({
      'p_ratings': ratings,
    });

    return "Rating added successfully!";
  } catch (error) {
    // Handle the error and provide user feedback
    VxToast.show(context, msg: "Error adding rating: $error");
    return "An error occurred";
  }
}

}
