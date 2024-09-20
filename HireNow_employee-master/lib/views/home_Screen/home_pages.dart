import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/chat_screen/messaging_screen.dart';
import 'package:flutter_application_1/views/home_Screen/activity_screen/activity_screen.dart';
import 'package:flutter_application_1/views/home_Screen/home_Screen.dart';
import 'package:flutter_application_1/views/profile_screen/profile_screen.dart';

class HomePagesScreen extends StatefulWidget {
  final String userId;
  const HomePagesScreen({Key? key, required this.userId});

  @override
  State<HomePagesScreen> createState() => _HomePagesScreenState();
}

class _HomePagesScreenState extends State<HomePagesScreen> {
  late List<Widget> pages;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    currentPage = 0;
    pages = [
      HomeScreen(userId: widget.userId),
      ActivityScreen(userId: widget.userId),
      MessagesScreen(userId: widget.userId),
      ProfileScreen(userId: widget.userId),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentPage],
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        child: Theme(
          data: Theme.of(context).copyWith(
            splashColor: const Color(0x00000000),
            highlightColor: const Color(0xff00FFFF).withOpacity(0.20),
          ),
          child: BottomNavigationBar(
            elevation: 5,
            backgroundColor: const Color(0xFF333333),
            type: BottomNavigationBarType.fixed,
            selectedLabelStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
            unselectedLabelStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            selectedItemColor: const Color(0xFF00FFFF),
            unselectedItemColor: const Color(0xFFffffff),
            selectedIconTheme: const IconThemeData(color: Color(0xFF00FFFF)),
            unselectedIconTheme: const IconThemeData(color: Color(0xFFFFFFFF)),
            currentIndex: currentPage,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.manage_search_rounded,
                ),
                label: 'Jobs',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.event_note_rounded,
                ),
                label: 'Activity',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.chat_rounded,
                ),
                label: 'Message',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                ),
                label: 'Profile',
              ),
            ],
            onTap: (index) {
              setState(() {
                currentPage = index;
              });
            },
          ),
        ),
      ),
    );
  }
}

class RepeatedTab extends StatelessWidget {
  final String label;
  const RepeatedTab({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Text(
        label,
        style: const TextStyle(
          color: Color(0xFF000000),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
