import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/consts/consts.dart';
import 'package:flutter_application_1/services/firestore_services.dart';
import 'package:flutter_application_1/widgets_common/loading_indicator.dart';

class WishlistScreen extends StatelessWidget {
  final String userId;
  const WishlistScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: whiteColor,
      appBar: AppBar(
           backgroundColor: const Color(0xFFDAD3BE),
           iconTheme: const IconThemeData(color: Colors.white),
        title: "My Wishlist".text.color(Colors.black).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getWishlists(userId),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if(!snapshot.hasData){
            return Center(
              child: loadingIndicator(),
            );
          }else if(snapshot.data!.docs.isEmpty){
            return"No wishlist yet!".text.color(darkFontGrey).makeCentered();
          }else{
            var data =snapshot.data!.docs;
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index){
                      return ListTile(
                          leading : Image.network(
                            "${data[index]['p_imgs'][0]}",
                            fit: BoxFit.cover,
                            width: 90,
                            ),
                          title: "${data[index]['p_name']}"
                          .text
                          .fontFamily(semibold)
                          .size(16)
                          .make(),
                          subtitle:"${data[index]['p_price']}"
                          .numCurrency
                          .text
                          .color(Colors.orange)
                          .fontFamily(semibold)
                          .make(),
                        trailing: const Icon(
                          Icons.favorite,
                          color:Colors.orange,
                          ).onTap(() async {
                           await firestore.collection(productsCollection).doc(data[index].id).set({
                            'p_wishlist':FieldValue.arrayRemove([currentUser!.uid])
                           }, SetOptions(merge: true));
                          }),
                
                          ) ;
                    },
                       
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}