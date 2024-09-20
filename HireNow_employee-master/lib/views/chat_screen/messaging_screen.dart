import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/consts/consts.dart';
import 'package:flutter_application_1/services/firestore_services.dart';
import 'package:flutter_application_1/views/chat_screen/chat_screen.dart';
import 'package:flutter_application_1/widgets_common/loading_indicator.dart';
import 'package:get/get.dart';


class MessagesScreen extends StatelessWidget {
  final String userId;
   const MessagesScreen({Key? key, required this.userId});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
      backgroundColor: const Color(0xFFDAD3BE), 
      iconTheme: const IconThemeData(color: Colors.white),
        title: "Message".text.color(Colors.black).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getAllMessages(userId),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if(!snapshot.hasData){
            return Center(
              child: loadingIndicator(),
            );
          }else if(snapshot.data!.docs.isEmpty){
            return"No messages yet!".text.color(darkFontGrey).makeCentered();
          }else{
            var data = snapshot.data!.docs;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index){
                      return Card(
                        child: ListTile(
                          onTap: (){
                            Get.to(() =>   ChatScreen(userId: userId,),
                            arguments:[
                            data[index]['friend_name'],
                            data[index]['toId']
                            ],
                            );
                          },
                          leading: const CircleAvatar(
                            backgroundColor: Colors.orange,
                            child: Icon(Icons.person,
                            color: whiteColor),
                          ),
                          title: "${data[index]['friend_name']}".text.fontFamily(semibold).color(darkFontGrey).make(),
                          subtitle: "${data[index]['last_msg']}".text.make(),
                        ),
                      );
                    },
                  ))
                ],
              ),
            );
          }
        },
      ),
    );
  }
}