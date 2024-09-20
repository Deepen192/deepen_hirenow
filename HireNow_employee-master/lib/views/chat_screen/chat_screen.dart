import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/consts/consts.dart';
import 'package:flutter_application_1/controllers/chats_controller.dart';
import 'package:flutter_application_1/services/firestore_services.dart';
import 'package:flutter_application_1/views/chat_screen/components/sender_bubble.dart';
import 'package:flutter_application_1/widgets_common/loading_indicator.dart';
import 'package:get/get.dart';

class ChatScreen extends StatelessWidget {
  final String userId;

  const ChatScreen({Key? key, required this.userId});

  @override
  Widget build(BuildContext context) {
  
    var controller = Get.put(ChatsController(userId: userId));
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
  backgroundColor: const Color(0xFFDAD3BE),
  title: "${controller.friendName}".text.fontFamily(semibold).color(Colors.black).make(),
  iconTheme: const IconThemeData(color: Colors.white),
),


      body:Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Obx(
              ()=> controller.isLoading.value
            ?   Center(
                child: loadingIndicator(),
                 )
             : Expanded(
               child: StreamBuilder(
               stream: FirestoreServices.getChatMessages(controller.chatDocId.toString(),userId),
               builder: (BuildContext context,AsyncSnapshot<QuerySnapshot>snapshot){
               if(!snapshot.hasData){
                return Center(
                child: loadingIndicator(),
                 );
                    }
                    else if(snapshot.data!.docs.isEmpty){
                      return Center(
                        child: "Send a message".text.color(darkFontGrey).make(),
                      );
                    }else {
                      return ListView(
               children: snapshot.data!.docs.mapIndexed((currentValue, index) {
                var data = snapshot.data!.docs[index];
                return Align(
                  alignment: 
                  data['uid'] ==userId? Alignment.centerRight: Alignment.centerLeft,
                  child: senderBubble(data));
               }).toList(),
              );
                    }
                  },
                ),
              ),
            ),
            10.heightBox,
            Row(
              children: [
                Expanded(child: TextFormField(
                  controller: controller.msgController,
                  decoration:const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: textfieldGrey,
                      )),
                      focusedBorder:  OutlineInputBorder(
                      borderSide: BorderSide(
                        color: textfieldGrey,
                      )),
                    hintText: "Type a message...",
                  ),
                )),
              IconButton(onPressed: (){
                controller.sendMsg(controller.msgController.text);
                controller.msgController.clear();
              }, icon: const Icon(Icons.send, color: Colors.orange,)),              
              ],
            ).box.height(80).padding(const EdgeInsets.all( 12)).margin(const EdgeInsets.only(bottom: 8)).make(),
          ],
        ),
      ),
    );
  }
}