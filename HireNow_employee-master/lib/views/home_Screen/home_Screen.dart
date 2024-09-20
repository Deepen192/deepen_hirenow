import 'package:flutter_application_1/consts/consts.dart';
import 'package:flutter_application_1/widgets_common/all_jobs.dart';
import 'package:flutter_application_1/widgets_common/best_matches_jobs.dart';
import 'package:flutter_application_1/widgets_common/category_job.dart';
import 'package:flutter_application_1/widgets_common/saved_jobs.dart';

class HomeScreen extends StatefulWidget {
  final String userId;
  const HomeScreen({super.key, required this.userId});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> mainBox = [
    {"title": "Graphics & Design", "screen": "/category_jobs"},
    {"title": "Programming & Tech", "screen": "/category_jobs"},
    {"title": "Digital Marketing", "screen": "/category_jobs"},
    {"title": "Video & Animation", "screen": "/category_jobs"},
    {"title": "Sales & Accounting", "screen": "/category_jobs"},
    {"title": "Writing & Translations", "screen": "/category_jobs"},
    {"title": "Music & Audio", "screen": "/category_jobs"},
    {"title": "Business", "screen": "/category_jobs"},
    {"title": "Consulting", "screen": "/category_jobs"},
    {"title": "AI Services", "screen": "/category_jobs"},
    {"title": "Personal Growth", "screen": "/category_jobs"},
    {"title": "Others", "screen": "/category_jobs"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "HireNow",
                    style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 27,
                        color: Color(0xFFFA4701),
                        fontWeight: FontWeight.bold),
                  ),
                  CircleAvatar(
                    radius: 16,
                    backgroundColor: Color(0xFFD3D1D1),
                    child: Icon(
                      Icons.notifications_rounded,
                      size: 24,
                      color: Colors.blueGrey,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                color: Colors.white,
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search here...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      padding: EdgeInsets.zero,
                      icon: const Icon(Icons.filter_list_rounded),
                      color: Colors.blue,
                      iconSize: 30,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 70,
                child: GridView.builder(
                    scrollDirection: Axis.horizontal,
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      childAspectRatio: 4.5 / 10,
                      maxCrossAxisExtent: 400,
                    ),
                    itemCount: mainBox.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final item = mainBox[index];
                      return Padding(
                        padding: const EdgeInsets.only(top: 4, bottom: 4, left: 3, right: 3),
                        child: GestureDetector(
                          onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CategoryJobsScreen(
          userId: widget.userId,
          category: item["title"],// Pass the selected category here
        ),
      ),
    );
  },
                          child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.15),
                                border: Border.all(
                                  color: Colors.purple.shade400,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    item["title"].toString(),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      );
                    }),
              ),
              DefaultTabController(
                length: 3,
                child: Expanded(
                  child: Column(
                    children: [
                      TabBar(
                          isScrollable: true,
                          splashBorderRadius: BorderRadius.circular(50),
                          indicatorColor: const Color(0xFFFF5000),
                          indicatorWeight: 5,
                          labelPadding: const EdgeInsets.symmetric(horizontal: 25),
                          tabs: const [
                            RepeatedTab(label: 'Recommended'),
                            RepeatedTab(label: 'All Jobs'),
                            RepeatedTab(label: 'Saved Jobs'),
                          ]),
                      const SizedBox(height: 4),
                      Expanded(
                        child: TabBarView(
                          children: [
                            BestMatchesJobs(userId: widget.userId,),
                            AllJobs(userId: widget.userId,),
                            SavedJobs(userId: widget.userId,),
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
