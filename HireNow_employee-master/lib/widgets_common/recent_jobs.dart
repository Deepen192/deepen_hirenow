import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/category/job_details.dart';

class RecentJobs extends StatefulWidget {
  final String jobId;
  final Map<String, dynamic> jobData;
  final String userId;
  const RecentJobs({super.key, required this.userId, required this.jobId, required this.jobData});

  @override
  State<RecentJobs> createState() => _RecentJobsState();
}

class _RecentJobsState extends State<RecentJobs> {
  bool isSavedJob = false;
  List<String> tags = [
    "SEO",
    "Digital Merketing",
    "Tech",
    "Programming",
    "On page SEO",
    "Off page SEO",
    "Backlinks",
    "Ranking",
    "Traffic",
    "Adsense",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              //   physics: const AlwaysScrollableScrollPhysics(),
              itemCount: 20,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>  JobDetails(
                          jobId: widget.jobId,
                        jobData: widget.jobData,
                          userId:widget.userId,),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 2,
                    shadowColor: const Color(0xFF000000),
                    color: const Color(0xFFFfffff),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Expanded(
                                child: Text(
                                  "Conversion Rate Expert needed for long term projects and Clients",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Color(0xFF14a800),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 6,
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    isSavedJob = !isSavedJob;
                                  });
                                },
                                icon: Icon(
                                  isSavedJob
                                      ? Icons.favorite_rounded
                                      : Icons.favorite_border_rounded,
                                  color: const Color(0xFF14a800),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Budget",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xFF000000),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "Rs. 12,000/m",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xFF000000),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Experience",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xFF000000),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "Intermediate",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xFF000000),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Job Type",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xFF000000),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "Remote",
                                    style: TextStyle(
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
                          const Row(
                            children: [
                              Text(
                                "Vacancy: ",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF000000),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "2",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF000000),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Icon(
                                Icons.place,
                                size: 24,
                                color: Color(0xFF000000),
                              ),
                              Expanded(
                                child: Text(
                                  "Kapilvastu, Banganga-01, Bairiya",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFF000000),
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          SizedBox(
                            height: 40,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: tags.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: Chip(
                                    elevation: 3,
                                    backgroundColor: const Color(0xFFF6F5F3),
                                    shadowColor: const Color(0xFF000000),
                                    side: const BorderSide(
                                      width: 1,
                                      color: Color(0xFFE5E4E2),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    labelPadding: const EdgeInsets.all(0),
                                    label: Text(
                                      tags[index],
                                      style: const TextStyle(
                                        color: Color(0xFF000000),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
