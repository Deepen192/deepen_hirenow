import 'package:flutter_application_1/consts/consts.dart';
import 'package:flutter_application_1/views/category/apply_job.dart';
import 'package:flutter_application_1/views/chat_screen/chat_screen.dart';
import 'package:get/get.dart';


class JobDetails extends StatefulWidget {
  final String jobId;
  final Map<String, dynamic> jobData;
  final String userId;
  const JobDetails({super.key, required this.jobId, required this.jobData, required this.userId});

  @override
  State<JobDetails> createState() => _JobDetailsState();
}

class _JobDetailsState extends State<JobDetails> {
  bool isSavedJob = false;
    List<String> skillsTags = [];
  List<String> benefitsTags = [];
   @override
  void initState() {
    super.initState();
    // Extract and split tags from jobData for each section
    final String skillsKeywords = widget.jobData['keywords'] ?? ''; // Retrieve the skills tags string
    skillsTags = skillsKeywords.split(',').map((tag) => tag.trim()).toList(); // Split into a list

    final String benefitsKeywords = widget.jobData['keywords'] ?? ''; // Retrieve the benefits tags string
    benefitsTags = benefitsKeywords.split(',').map((tag) => tag.trim()).toList(); // Split into a list
    // Print vendor_id to check its value
  print("Vendor ID: ${widget.jobData['vendor_id']}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar:AppBar(
  centerTitle: true,
  title: const Text(
    "Job Details",
    style: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w500,
    ),
  ),
  actions: [
    CircleAvatar(
      backgroundColor: Color(0xFFEF9C66),
      child: Icon(Icons.message_rounded, color: Colors.white),
    ).onTap(() {
      Get.to(
        () => ChatScreen(userId: widget.userId),
        arguments: [widget.jobData['p_seller'], widget.jobData['vendor_id']],
      );
    }),
  ],
),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Text(
                widget.jobData['p_name'] ?? "Job Title Not Available",
                style: const TextStyle(
                  color: Color(0xFF0095FF),
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                "Job Posted: 2081-03-23",
                style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
              const Divider(
                thickness: 2,
                height: 30,
              ),
              const Text(
                " Basic Information",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
               SizedBox(
                width: double.infinity,
                child: Card(
                  elevation: 2,
                  shadowColor: const Color(0xFF000000),
                  color: const Color(0xFFffffff),
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.place,
                                size: 24,
                                color: Color(0xFFff5f1f),
                              ),
                              const SizedBox(
                                width: 6,
                              ),
                              Expanded(
                                child: Text(
                                  widget.jobData['p_jobaddress'] ?? "Address Not Available",
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFFff5f1f),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Salary ",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Color(0xFF000000),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    "Rs.${widget.jobData['p_price']}",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Color(0xFF000000),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Experience",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Color(0xFF000000),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    widget.jobData['p_subcategory'] ?? "Not Available",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Color(0xFF000000),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Job Type",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Color(0xFF000000),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                     widget.jobData['p_jobtype'] ?? "Not Available",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Color(0xFF000000),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Job Time   ",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Color(0xFF000000),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                     widget.jobData['p_jobtime'] ?? "Not Available",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Color(0xFF000000),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Gender",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Color(0xFF000000),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                     widget.jobData['p_gender'] ?? "Not Available",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Color(0xFF000000),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Vacancy",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Color(0xFF000000),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                     widget.jobData['p_quantity'] ?? "Not Available",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Color(0xFF000000),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      )),
                ),
              ),
              const Divider(
                thickness: 2,
                height: 30,
              ),
              const Text(
                " Job Description",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
               SizedBox(
                width: double.infinity,
                child: Card(
                  elevation: 2,
                  shadowColor: const Color(0xFF000000),
                  //   color: Color(0xFFF9F6F6),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                    widget.jobData['p_desc'] ?? "Not Available",
                      textAlign: TextAlign.justify,
                      style: const TextStyle(
                        color: Color(0xFF000000),
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
              const Divider(
                thickness: 2,
                height: 30,
              ),
              const Text(
                " Requirements",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
               SizedBox(
                width: double.infinity,
                child: Card(
                  elevation: 2,
                  shadowColor: const Color(0xFF000000),
                  //   color: Color(0xFFF9F6F6),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                  widget.jobData['p_requirement'] ?? "Not Available", 
                     textAlign: TextAlign.justify,
                      style: const TextStyle(
                        color: Color(0xFF000000),
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
              const Divider(
                thickness: 2,
                height: 30,
              ),
              const Text(
                " Roles & Responsibilities",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
               SizedBox(
                width: double.infinity,
                child: Card(
                  elevation: 2,
                  shadowColor: const Color(0xFF000000),
                  //   color: Color(0xFFF9F6F6),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                    widget.jobData['p_role&responsible'] ?? "Not Available", 
                      textAlign: TextAlign.justify,
                      style: const TextStyle(
                        color: Color(0xFF000000),
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
              const Divider(
                thickness: 2,
                height: 30,
              ),
              const Text(
  " Skills and Expertise",
  style: TextStyle(
    color: Colors.black,
    fontSize: 20,
    fontWeight: FontWeight.w500,
  ),
),
SizedBox(
  width: double.infinity,
  child: Card(
    elevation: 2,
    shadowColor: const Color(0xFF000000),
    color: const Color(0xFFffffff),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        spacing: 8.0, // Space between each chip
        runSpacing: 0.0, // Space between lines
        children: skillsTags.map((String tag) {
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
                color: Color(0xFF000000),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          );
        }).toList(),
      ),
    ),
  ),
),

              const Divider(
                thickness: 2,
                height: 30,
              ),
              const Text(
  " Benefits",
  style: TextStyle(
    color: Colors.black,
    fontSize: 20,
    fontWeight: FontWeight.w500,
  ),
),
SizedBox(
  width: double.infinity,
  child: Card(
    elevation: 2,
    shadowColor: const Color(0xFF000000),
    color: const Color(0xFFffffff),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        spacing: 8.0, // Space between each chip
        runSpacing: 0.0, // Space between lines
        children: benefitsTags.map((String tag) {
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
                color: Color(0xFF000000),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          );
        }).toList(),
      ),
    ),
  ),
),

              const SizedBox(
                height: 8,
              ),
              const Divider(
                thickness: 2,
              ),
              const SizedBox(
                height: 8,
              ),
              const Text(
                " About the Employer",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
               SizedBox(
                width: double.infinity,
                child: Card(
                  elevation: 2,
                  shadowColor: Color(0xFF000000),
                  color: Color(0xFFffffff),
                  child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Text(
                              //   "Total Jobs Posted: ",
                              //   style: TextStyle(
                              //     fontSize: 16,
                              //     fontWeight: FontWeight.w500,
                              //   ),
                              // ),
                              Text(
                                "Open Jobs: ",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "Hire Rate: ",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "Company Type: ",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "Company Size in people: ",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Text(
                              //   "8",
                              //   style: TextStyle(
                              //     fontSize: 16,
                              //     fontWeight: FontWeight.w500,
                              //   ),
                              // ),
                              Text(
                                widget.jobData['p_quantity'] ?? "Not Available",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "86%",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                widget.jobData['p_category'] ?? "Not Available",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "2-9",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      )),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                //   IconButton(
                //      onPressed: () async {
                //   setState(() {
                //     isJobSaved = !isJobSaved;
                //   });

                //   if (isJobSaved) {
                //     // Add userId to p_wishlist
                //     await job.reference.update({
                //       'p_wishlist': FieldValue.arrayUnion([widget.userId])
                //     });
                //   } else {
                //     // Remove userId from p_wishlist
                //     await job.reference.update({
                //       'p_wishlist': FieldValue.arrayRemove([widget.userId])
                //     });
                //   }
                // },
                //     icon: Icon(
                //       isSavedJob
                //           ? Icons.favorite_rounded
                //           : Icons.favorite_border_rounded,
                //       color: const Color(0xFF0095FF),
                //       size: 35,
                //     ),
                //   ),
                  const SizedBox(
                      width:
                          10), // Add some spacing between the avatar and button
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>  ApplyJobScreen(
                                 jobId: widget.jobId,
                                jobData: widget.jobData,
                                userId:widget. userId,),
                            ));
                      },
                      style: ButtonStyle(
                        padding: WidgetStateProperty.all(
                          const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 24.0),
                        ), // Padding
                        backgroundColor: WidgetStateProperty.all(
                          const Color(0xFF0095FF),
                        ),
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(50.0), // Rounded corners
                            side: const BorderSide(
                              color: Color(0xFF0095FF),
                              width: 3.0, // Border width
                            ),
                          ),
                        ),
                      ),
                      child: const Text(
                        "Apply Now",
                        style: TextStyle(
                          color: Color(0xFFffffff),
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
