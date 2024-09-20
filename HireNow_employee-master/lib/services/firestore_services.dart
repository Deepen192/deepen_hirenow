import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/consts/consts.dart';
import 'package:flutter_application_1/consts/firebase_consts.dart';

class FirestoreServices{
  //get user data
   static Stream<QuerySnapshot> getUser(String userId) {
  return FirebaseFirestore.instance
    .collection(usersCollection) // Replace with your collection name
    .where('id', isEqualTo: userId) // Use userId passed from another screen
    .snapshots();
}


 static Stream<QuerySnapshot> jobsByCategoryAndTitle(String category) {
    return FirebaseFirestore.instance
        .collection('jobs') // Replace with your Firestore collection name
        .where('p_category', isEqualTo: category)
        .snapshots();
  }

  //get user data
   static Stream<QuerySnapshot> getProductId(String productId) {
  return FirebaseFirestore.instance
    .collection(productsCollection) // Replace with your collection name
    .where('p_id', isEqualTo: productId) // Use userId passed from another screen
    .snapshots();
}


  // static getUser(uid){
  //   return firestore.collection(usersCollection).where('id', isEqualTo: uid).snapshots();

  // }

   static Stream<QuerySnapshot> getVendors() {
    return FirebaseFirestore.instance.collection(vendorcollection).snapshots();
  }
static Stream<QuerySnapshot> getVendorId(String vendorId) {
  return FirebaseFirestore.instance
    .collection(vendorcollection) // Replace with your collection name
    .where('id', isEqualTo: vendorId) // Use userId passed from another screen
    .snapshots();
}

  //get products according to category
  static getJobs(category){
  return firestore.collection(productsCollection).where('p_category',isEqualTo:category).snapshots();

  }

  static getSubCategoryJobs(title){
     return firestore.collection(productsCollection).where('p_subcategory',isEqualTo: title).snapshots();

  }




  //add product in cart collection of firebase database with the given parameters and returns a future object which
  static Stream<QuerySnapshot> getCart(String userId) {
  return FirebaseFirestore.instance
    .collection(cartCollection) // Replace with your collection name
    .where('added_by', isEqualTo: userId) // Use userId passed from another screen
    .snapshots();
}

// Delete a document from the cart collection by docId
  static Future<void> deleteDocument(String docId) {
    return FirebaseFirestore.instance
        .collection(cartCollection)
        .doc(docId)
        .delete();
  }

  // Delete all documents from the cart collection by userId
  static Future<void> deleteAllDocumentsByUserId(String userId) async {
    var batch = FirebaseFirestore.instance.batch();
    var snapshot = await FirebaseFirestore.instance
        .collection(cartCollection)
        .where('added_by', isEqualTo: userId)
        .get();

    for (var doc in snapshot.docs) {
      batch.delete(doc.reference);
    }

    await batch.commit();
  }

  // //delet cart document
  // static deleteDocument(docId){
  //   return firestore.collection(cartCollection).doc(docId).delete();

  // }
  // get all chat message
  static Stream<QuerySnapshot> getChatMessages(String docId, String userId) {
    return FirebaseFirestore.instance
        .collection(chatsCollection)
        .doc(docId)
        .collection(messageCollection)
        // .where('fromId', isEqualTo: userId) // Filter messages where uid equals userId
        .orderBy('created_on', descending: false)
        .snapshots();
  }
 static Stream<QuerySnapshot> getAllOrders(String userId) {
    return FirebaseFirestore.instance
      .collection(ordersCollection) // Ensure this is correctly imported and matches your Firestore
      .where('order_by', isEqualTo: userId) // Ensure this field name matches your Firestore
      .snapshots();
  }
  
  static Stream<QuerySnapshot> getLatestOrder(String userId) {
    return FirebaseFirestore.instance
      .collection('orders') // Ensure this is correctly imported and matches your Firestore
      .where('order_by', isEqualTo: userId) // Ensure this field name matches your Firestore
      .orderBy('order_date', descending: true) // Sort by order_date in descending order
      .limit(1) // Limit the result to 1 document
      .snapshots();
  }
  


static Stream<QuerySnapshot> getWishlists(String userId) {
  return FirebaseFirestore.instance
    .collection(productsCollection) // Use your products collection name
    .where('p_wishlist', arrayContains: userId) // Use userId passed from another screen
    .snapshots();
}

static Stream<QuerySnapshot> alljobId(String productId) {
  return FirebaseFirestore.instance
    .collection(productsCollection) 
    .where('p_id', isEqualTo: productId) 
    .snapshots();
}


  // static getWishlists(){
  //   return firestore.collection(productsCollection).where('p_wishlist',arrayContains: currentUser!.uid).snapshots();
  // }

  static Stream<QuerySnapshot> getAllMessages(String userId) {
  return FirebaseFirestore.instance
    .collection(chatsCollection) // Use your products collection name
    .where('fromId', isEqualTo: userId) // Use userId passed from another screen
    .snapshots();
}

  // static getAllMessages(){
  //    return firestore.collection(chatsCollection).where('fromId', isEqualTo: currentUser!.uid).snapshots();
  // }

  static Future<List<int>> getCounts(String userId) async {
  var res = await Future.wait([
    firestore.collection(chatsCollection).where('fromId', isEqualTo: userId).get().then((value) {
      return value.docs.length;
    }),

    firestore.collection(productsCollection).where('p_wishlist', arrayContains: userId).get().then((value) {
      return value.docs.length;
    }),

    firestore.collection(ordersCollection).where('order_by', isEqualTo: userId).get().then((value) {
      return value.docs.length;
    })
  ]);
  return res;
}


  static alljobs(){
    return firestore.collection(productsCollection).snapshots();
  }

  // get featured products method
  static getFeaturedJobs(){
    return firestore.collection(productsCollection).where('is_featured',isEqualTo: true).get();
  }
  static searchJobs(title){
    return firestore.collection(productsCollection).get();
  }

    

}