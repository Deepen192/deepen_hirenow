import 'package:flutter/material.dart';
import 'package:flutter_application_1/consts/colors.dart';
import 'package:flutter_application_1/widgets_common/archived.dart';
import 'package:flutter_application_1/widgets_common/contracts.dart';
import 'package:flutter_application_1/widgets_common/proposals.dart';

class ActivityScreen extends StatefulWidget {
  final String userId;
  const ActivityScreen({super.key, required this.userId});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: const Center(
          child: Text(
            "All Activities",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DefaultTabController(
                length: 3,
                child: Expanded(
                  child: Column(
                    children: [
                      TabBar(
                        isScrollable: true,
                        padding: EdgeInsets.zero,
                        splashBorderRadius: BorderRadius.circular(50),
                        indicatorColor: const Color(0xFFFF5000),
                        indicatorWeight: 5,
                        labelPadding:
                            const EdgeInsets.only(left: 30, right: 30),
                        tabs: const [
                          RepeatedTab(label: 'Proposals'),
                          RepeatedTab(label: 'Contracts'),
                          RepeatedTab(label: 'Archived'),
                        ],
                      ),
                      const SizedBox(height: 4),
                       Expanded(
                        child: TabBarView(
                          children: [
                            Proposals(userId: widget.userId,),
                            Contracts(userId: widget.userId,),
                            Archived(userId: widget.userId,),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
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
