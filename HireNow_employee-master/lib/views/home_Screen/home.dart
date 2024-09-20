import 'package:flutter_application_1/views/home_Screen/activity_screen/activity_screen.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/consts/consts.dart';
import 'package:flutter_application_1/controllers/home_controller.dart';
import 'package:flutter_application_1/views/chat_screen/messaging_screen.dart';
import 'package:flutter_application_1/views/home_Screen/home_Screen.dart';
import 'package:flutter_application_1/views/profile_screen/profile_screen.dart';
import 'package:flutter_application_1/widgets_common/exit_dailog.dart';

class Home extends StatelessWidget {
  final String userId;
  const Home({Key? key, required this.userId});

  @override
  Widget build(BuildContext context) {
    // Initialize home controller
    var controller = Get.put(HomeController());

    // Define navigation items
    var navbarItem = [
      BottomNavigationBarItem(
        icon: Image.asset(icHome, width: 26, color: Colors.black),
        label: home,
      ),
      BottomNavigationBarItem(
        icon: Image.asset(icCategories, width: 26, color: Colors.black),
        label: categories,
      ),
      BottomNavigationBarItem(
        icon: Image.asset(icMessages, width: 26, color: Colors.black),
        label: message,
      ),
      BottomNavigationBarItem(
        icon: Image.asset(icProfile, width: 26, color: Colors.black),
        label: account,
      ),
    ];

    // Define navigation body items
    var navBody = [
      HomeScreen(userId: controller.userId),
      ActivityScreen(userId: controller.userId,),
      MessagesScreen(userId: controller.userId), // Pass userId to MessagesScreen
      ProfileScreen(userId: controller.userId), // Pass userId to ProfileScreen
    ];

    return WillPopScope(
      onWillPop: () async {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => exitDailog(context),
        );
        return false;
      },
      child: Scaffold(
        body: Obx(() => navBody[controller.currentNavIndex.value]),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            currentIndex: controller.currentNavIndex.value,
            selectedItemColor: Colors.orange,
            selectedLabelStyle: const TextStyle(fontFamily: semibold),
            type: BottomNavigationBarType.fixed,
            backgroundColor: whiteColor,
            items: navbarItem,
            onTap: (value) {
              controller.currentNavIndex.value = value;
            },
          ),
        ),
      ),
    );
  }
}
