// import 'package:flutter_application_1/consts/consts.dart';
// import 'package:flutter_application_1/controllers/auth_controller.dart';
// import 'package:flutter_application_1/views/auth_screen/passwordreset.dart';
// import 'package:flutter_application_1/views/auth_screen/signup_screen.dart';
// import 'package:flutter_application_1/widgets_common/applogo_widget.dart';
// import 'package:flutter_application_1/widgets_common/bg_widget.dart';
// import 'package:flutter_application_1/widgets_common/custom_textfield.dart';
// import 'package:flutter_application_1/widgets_common/our_button.dart';
// import 'package:get/get.dart';
// import '../home_Screen/home.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   @override
//   Widget build(BuildContext context) {
//     var controller = Get.put(AuthController());

//     return bgWidget(
//       child: Scaffold(
//         resizeToAvoidBottomInset: false,
//         body: Center(
//           child: Column(
//             children: [
//               (context.screenHeight * 0.1).heightBox,
//               const SizedBox(height: 8),
//               applogoWidget(),
//               15.heightBox,
//               "Login to $appname".text
//                   .fontFamily(bold)
//                   .white
//                   .size(20)
//                   .make(),
//               15.heightBox,
//               Obx(
//                 () => Column(
//                   children: [
//                     customTextField(
//                         hint: emailHint,
//                         title: email,
//                         isPass: false,
//                         controller: controller.emailController),
//                     customTextField(
//                         hint: passwordHint,
//                         title: password,
//                         isPass: true,
//                         controller: controller.passwordController),
//                     Align(
//                       alignment: Alignment.centerRight,
//                       child: TextButton(
//                         onPressed: () {
//                           Get.to(() => ForgotPasswordScreen());
//                         },
//                         child: forgetPass.text.make(),
//                       ),
//                     ),
//                     5.heightBox,
//                     controller.isloading.value
//                         ? const CircularProgressIndicator(
//                             valueColor: AlwaysStoppedAnimation(Colors.yellow),
//                           )
//                         : ourButton(
//                             color: Colors.orange,
//                             title: login,
//                             textColor: whiteColor,
//                             onPress: () async {
//                               controller.isloading(true);
//                               await controller.loginMethod(
//                                 email: controller.emailController.text,
//                                 password: controller.passwordController.text,
//                                 context: context,
//                               ).then((value) {
//                                 if (value != null) {
//                                   VxToast.show(context, msg: loggedin);
//                                   Get.offAll(() => const Home());
//                                 } else {
//                                   controller.isloading(false);
//                                 }
//                               });
//                             },
//                           )
//                             .box
//                             .width(context.screenWidth - 50)
//                             .make(),
//                     5.heightBox,
//                     createNewAccount.text.color(fontGrey).make(),
//                     5.heightBox,
//                     ourButton(
//                       color: lightGolden,
//                       title: signup,
//                       textColor: redColor,
//                       onPress: () {
//                         Get.to(() => const SignupScreen());
//                       },
//                     )
//                         .box
//                         .width(context.screenWidth - 50)
//                         .make(),
//                     10.heightBox,
//                     loginWith.text.color(fontGrey).make(),
//                     5.heightBox,
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: List.generate(
//                         3,
//                         (index) => Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: CircleAvatar(
//                             backgroundColor: lightGrey,
//                             radius: 25,
//                             child: Image.asset(
//                               socialIconList[index],
//                               width: 30,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               )
//                   .box
//                   .white
//                   .rounded
//                   .padding(const EdgeInsets.all(16))
//                   .width(context.screenWidth - 70)
//                   .shadowSm
//                   .make(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
