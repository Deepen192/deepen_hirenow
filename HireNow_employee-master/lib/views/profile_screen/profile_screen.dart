import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/consts/consts.dart';
import 'package:flutter_application_1/controllers/auth_controller.dart';
import 'package:flutter_application_1/controllers/profile_controller.dart';
import 'package:flutter_application_1/views/auth_screen/welcome_screen.dart';
import 'package:flutter_application_1/views/profile_screen/edit_profile_screen.dart';
import 'package:get/get.dart';
import '../../../services/firestore_services.dart';
import '../../widgets_common/bg_widget.dart';

class ProfileScreen extends StatefulWidget {
  final String userId;

  const ProfileScreen({Key? key, required this.userId});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isExpanded = false;

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  // List<String> tags = [
  //   "SEO",
  //   "Digital Marketing",
  //   "Tech",
  //   "Programming",
  //   "On-page SEO",
  //   "Off-page SEO",
  //   "Backlinks",
  //   "Ranking",
  //   "Traffic",
  //   "Adsense",
  // ];

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController(userId: widget.userId));

    return bgWidget(
      child: Scaffold(
        body: StreamBuilder(
          stream: FirestoreServices.getUser(widget.userId),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(redColor),
                ),
              );
            } else {
              var data = snapshot.data!.docs[0];
              return SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Edit profile button
                      Padding(
                        padding:  EdgeInsets.all(8.0),
                        child: const Align(
                          alignment: Alignment.topRight,
                          child: Icon(Icons.edit, color: whiteColor),
                        ).onTap(() {
                          controller.nameController.text = data['name'];
                          Get.to(() => EditProfileScreen(
                              userId: widget.userId, imageUrl: data['imageUrl']));
                        }),
                      ),

                      // User details section
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          children: [
                            data['imageUrl'] == ''
                                ? Image.asset(imgProfile2, width: 100, fit: BoxFit.cover)
                                    .box
                                    .roundedFull
                                    .clip(Clip.antiAlias)
                                    .make()
                                : Image.network(data['imageUrl'],
                                        width: 100, fit: BoxFit.cover)
                                    .box
                                    .roundedFull
                                    .clip(Clip.antiAlias)
                                    .make(),
                            10.widthBox,
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  "${data['name']}".text.fontFamily(semibold).white.make(),
                                  "${data['email']}".text.white.make(),
                                ],
                              ),
                            ),
                            OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                  side: const BorderSide(
                                color: whiteColor,
                              )),
                              onPressed: () async {
                                await Get.put(AuthController()).signoutMethod(context);
                                Get.offAll(() =>  WelcomeScreen(userId: widget.userId,));
                              },
                              child: logout.text.fontFamily(semibold).white.make(),
                            )
                          ],
                        ),
                      ),
                      40.heightBox,

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 16,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 6),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Description",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  TextButton.icon(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.edit,
                                      color: Color(0xFF0095FF),
                                      
                                      size: 24,
                                    ),
                                    label: const Text(
                                      "Edit",
                                      style: TextStyle(
                                        color: Color(0xFF0095FF),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 2,
                              color: const Color(0xFFFFFFFF),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                    "${data['description']}",
                                      maxLines: _isExpanded ? null : 2,
                                      overflow: _isExpanded
                                          ? TextOverflow.visible
                                          : TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: _toggleExpanded,
                                      child: Text(
                                        _isExpanded ? 'Show Less' : 'Show More',
                                        style: const TextStyle(
                                          color: Colors.blue,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 6),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Skills",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  // TextButton.icon(
                                  //   onPressed: () {},
                                  //   icon: const Icon(
                                  //     Icons.edit,
                                  //     color: Color(0xFF0095FF),
                                  //     size: 24,
                                  //   ),
                                  //   label: const Text(
                                  //     "Edit",
                                  //     style: TextStyle(
                                  //       color: Color(0xFF0095FF),
                                  //       fontSize: 16,
                                  //       fontWeight: FontWeight.w500,
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: double.infinity,
                              
                              child: Card(
                                elevation: 2,
                                color: const Color(0xFFFFFFFF),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Wrap(
                                    spacing: 8.0, // Space between each chip
                                    runSpacing: 0.0, // Space between lines
                                    children: (() {
                                      // Retrieve the skills list, ensure it's a List<String>
                                      final List<dynamic> skills = data['skills'] ?? [];
                                      
                                      // Ensure all items are strings and trim them
                                      final List<String> tags = skills.map((dynamic skill) {
                                        if (skill is String) {
                                          return skill.trim();
                                        }
                                        return ''; // Return an empty string if the item is not a string
                                      }).toList();

                                      // Map the tags to Chips
                                      return tags.map((String tag) {
                                        return Chip(
                                          elevation: 2,
                                          backgroundColor: const Color(0xFFFFFFFF),
                                          shadowColor: const Color(0xFF000000),
                                          side: const BorderSide(
                                            width: 1,
                                            color: Color(0xFFFFFFFF),
                                          ),
                                          padding: const EdgeInsets.symmetric(horizontal: 20),
                                          labelPadding: const EdgeInsets.all(0),
                                          label: Text(
                                            tag,
                                            style: const TextStyle(
                                              color: Color(0xFF28282B),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(50),
                                          ),
                                        );
                                      }).toList();
                                    })(),
                                  ),
                                ),
                              )

                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 6),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Languages",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  // TextButton.icon(
                                  //   onPressed: () {},
                                  //   icon: const Icon(
                                  //     Icons.edit,
                                  //     color: Color(0xFF0095FF),
                                  //     size: 24,
                                  //   ),
                                  //   label: const Text(
                                  //     "Edit",
                                  //     style: TextStyle(
                                  //       color: Color(0xFF0095FF),
                                  //       fontSize: 16,
                                  //       fontWeight: FontWeight.w500,
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                            Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            color: const Color(0xFFFFFFFF),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: List.generate(data['languages'].length, (index) {
                                  // Split the language and proficiency
                                  List<String> langData = data['languages'][index].split(' - ');

                                  // Determine the proficiency level based on index
                                  String proficiency = (index == 0) ? "Native" : "Fluent";

                                  return Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "${langData[0]} ",
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text(
                                            "- $proficiency",
                                            style: const TextStyle(
                                              color: Colors.black54,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                      if (index < data['languages'].length - 1) // Divider for all but last item
                                        const Divider(
                                          thickness: 2,
                                          color: Color(0xFFff5f1f),
                                        ),
                                    ],
                                  );
                                }),
                              ),
                            ),
                          ),
                            SizedBox(height: 15,),
                            const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Education",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            // TextButton.icon(
                            //   onPressed: () {},
                            //   icon: const Icon(
                            //     Icons.edit,
                            //     color: Color(0xFF0095FF),
                            //     size: 24,
                            //   ),
                            //   label: const Text(
                            //     "Edit",
                            //     style: TextStyle(
                            //       color: Color(0xFF0095FF),
                            //       fontSize: 16,
                            //       fontWeight: FontWeight.w500,
                            //     ),
                            //   ),
                            // )
                          ],
                        ),
                      ),
                      Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            color: const Color(0xFFFFFFFF),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: List.generate(data['education'].length, (index) {
                                  // Split the education and level
                                  List<String> eduData = data['education'][index].split(' - ');

                                  // Determine the level based on index
                                  String level = (index == 0) ? "Completed" :  "Highest";

                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "${eduData[0]} ",
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text(
                                            "- $level",
                                            style: const TextStyle(
                                              color: Colors.black54,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                      if (index < data['education'].length - 1) // Divider for all but last item
                                        const Divider(
                                          thickness: 2,
                                          color: Color(0xFFff5f1f),
                                        ),
                                    ],
                                  );
                                }),
                              ),
                            ),
                          )

                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
