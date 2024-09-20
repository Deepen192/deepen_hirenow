import 'dart:io';
import 'package:flutter_application_1/consts/consts.dart';
import 'package:flutter_application_1/controllers/profile_controller.dart';
import 'package:flutter_application_1/widgets_common/bg_widget.dart';
import 'package:flutter_application_1/widgets_common/custom_textfield.dart';
import 'package:flutter_application_1/widgets_common/our_button.dart';
import 'package:get/get.dart';

class EditProfileScreen extends StatelessWidget {
  final dynamic data;
  final String userId;
  final String imageUrl;

  const EditProfileScreen({Key? key, this.data, required this.userId, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController(userId: userId)); // Initialize ProfileController with userId

    return bgWidget(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: const Color(0xFFDAD3BE),
          iconTheme: const IconThemeData(color: Colors.white),
          title:"Edit Profile".text.fontFamily(semibold).color(Colors.black).make(),
        ),
        body: Obx(
          () => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Profile Image
              controller.profileImgPath.isNotEmpty
                  ? Image.file(
                      File(controller.profileImgPath.value),
                      width: 100,
                      fit: BoxFit.cover,
                    ).box.roundedFull.clip(Clip.antiAlias).make()
                  : (data != null && data['imageUrl'] != '')
                      ? Image.network(data['imageUrl'], width: 100, fit: BoxFit.cover)
                          .box.roundedFull.clip(Clip.antiAlias).make()
                      : Image.network(imageUrl, width: 100, fit: BoxFit.cover)
                          .box.roundedFull.clip(Clip.antiAlias).make(),
              10.heightBox,
              ourButton(
                color: golden,
                onPress: () {
                  controller.changeImage(context);
                },
                textColor: whiteColor,
                title: "Change",
              ),
              const Divider(),
              20.heightBox,
              customTextField(
                controller: controller.nameController,
                hint: nameHint,
                title: name,
                isPass: false,
              ),
              10.heightBox,
              customTextField(
                controller: controller.oldpasswordController,
                hint: passwordHint,
                title: oldpass,
                isPass: true,
              ),
              10.heightBox,
              customTextField(
                controller: controller.newpasswordController,
                hint: passwordHint,
                title: newpass,
                isPass: true,
              ),
              20.heightBox,
              controller.isloading.value
                  ? const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(redColor),
                    )
                  : SizedBox(
                      width: context.screenWidth - 60,
                      child: ourButton(
                        color: golden,
                        onPress: () async {
                          // Fetch user data before saving profile
                          var userData = await controller.getUserData(userId);
                          if (userData != null) {
                            controller.saveProfile(context, userData);
                          } else {
                            VxToast.show(context, msg: "User data not found");
                          }
                        },
                        textColor: whiteColor,
                        title: "Save",
                      ),
                    ),
            ],
          )
              .box
              .white
              .shadowSm
              .padding(const EdgeInsets.all(16))
              .margin(const EdgeInsets.only(top: 50, left: 12, right: 12))
              .rounded
              .make(),
        ),
      ),
    );
  }
}
