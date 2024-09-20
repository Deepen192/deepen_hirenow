import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/consts/consts.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

import 'auth_controller.dart';

class ProfileController extends GetxController {
  final String userId;

  ProfileController({required this.userId});

  var profileImgPath = ''.obs;
  var profileImageLink = '';
  var isloading = false.obs;

  // Text fields
  var nameController = TextEditingController();
  var oldpasswordController = TextEditingController();
  var newpasswordController = TextEditingController();
  var descriptionController = TextEditingController();
  var skillsController = TextEditingController();
  var languagesController = TextEditingController();
  var educationController = TextEditingController();

  changeImage(context) async {
    try {
      final imageSource = await showDialog<ImageSource>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Select Image Source"),
          actions: [
            IconButton(
              alignment: Alignment.bottomLeft,
              icon: const Icon(Icons.camera),
              onPressed: () => Navigator.pop(context, ImageSource.camera),
            ),
            IconButton(
              alignment: Alignment.bottomRight,
              icon: const Icon(Icons.image),
              onPressed: () => Navigator.pop(context, ImageSource.gallery),
            ),
          ],
        ),
      );

      if (imageSource == null) return;

      final img = await ImagePicker().pickImage(
        source: imageSource,
        imageQuality: 70,
      );

      if (img == null) return;

      profileImgPath.value = img.path;
    } on PlatformException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }

  uploadProfileImage() async {
    var filename = basename(profileImgPath.value);
    var destination = 'images/${currentUser!.uid}/$filename';
    Reference ref = FirebaseStorage.instance.ref().child(destination);
    await ref.putFile(File(profileImgPath.value));
    profileImageLink = await ref.getDownloadURL();
  }

  Future<Map<String, dynamic>?> getUserData(String userId) async {
    var store = firestore.collection(usersCollection);
    var docSnapshot = await store.where('id', isEqualTo: userId).get();

    if (docSnapshot.docs.isNotEmpty) {
      return docSnapshot.docs.first.data();
    } else {
      print("No user found with the given userId");
      return null;
    }
  }

  updateProfile({String? name, String? password, String? imgUrl}) async {
    var store = firestore.collection(usersCollection);
    var docSnapshot = await store.where('id', isEqualTo: userId).get();

    if (docSnapshot.docs.isNotEmpty) {
      var docId = docSnapshot.docs.first.id;
      var dataToUpdate = <String, dynamic>{};

      if (name != null) {
        dataToUpdate['name'] = name;
      }

      if (password != null) {
        dataToUpdate['password'] = password;
      }

      if (imgUrl != null) {
        dataToUpdate['imageUrl'] = imgUrl;
      }

      await store.doc(docId).update(dataToUpdate);
      isloading(false);
    } else {
      print("No user found with the given userId");
    }
  }

  changeAuthPassword({String? email, String? oldPassword, String? newPassword}) async {
    final cred = EmailAuthProvider.credential(email: email!, password: oldPassword!);

    try {
      await currentUser!.reauthenticateWithCredential(cred);
      await currentUser!.updatePassword(newPassword!);
      await updateProfile(password: newPassword);
      await Get.find<AuthController>().updatePassword(newPassword);

      print("Password updated successfully!");
    } catch (error) {
      print("Password update error: $error");
    }
  }

  updatePassword(String newPassword) async {
    try {
      await currentUser!.updatePassword(newPassword);
      print("Password updated in AuthController.");
    } catch (error) {
      print("Password update error in AuthController: $error");
    }
  }

  void updateProfileImage(BuildContext context) async {
    if (profileImgPath.value.isNotEmpty) {
      isloading(true);
      await uploadProfileImage();
      await updateProfile(imgUrl: profileImageLink);
      VxToast.show(context, msg: "Profile image updated");
      isloading(false);
    } else {
      VxToast.show(context, msg: "Please select an image");
    }
  }

  void saveProfile(BuildContext context, dynamic data) async {
    isloading(true);

    if (profileImgPath.value.isNotEmpty) {
      await uploadProfileImage();
    } else {
      profileImageLink = data['imageUrl'];
    }

    if (oldpasswordController.text.isNotEmpty && newpasswordController.text.isNotEmpty) {
      if (data['password'] == oldpasswordController.text) {
        if (oldpasswordController.text != newpasswordController.text) {
          await changeAuthPassword(
            email: data['email'],
            oldPassword: oldpasswordController.text,
            newPassword: newpasswordController.text,
          );
          await updateProfile(
            imgUrl: profileImageLink,
            name: nameController.text,
            password: newpasswordController.text,
          );
          VxToast.show(context, msg: "Profile updated successfully");
        } else {
          VxToast.show(context, msg: "Old and new passwords cannot be the same");
        }
      } else {
        VxToast.show(context, msg: "Old password is incorrect");
      }
    } else {
      await updateProfile(
        imgUrl: profileImageLink,
        name: nameController.text,
      );
      VxToast.show(context, msg: "Profile updated successfully");
    }

    isloading(false);
  }
}
