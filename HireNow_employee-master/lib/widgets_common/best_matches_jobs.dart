import 'package:flutter/material.dart';
import 'package:flutter_application_1/reusable_widgets/job_card.dart';
import 'package:flutter_application_1/views/category/job_details.dart';


class BestMatchesJobs extends StatefulWidget {
  final String userId;
  const BestMatchesJobs({Key? key, required this.userId});

  @override
  State<BestMatchesJobs> createState() => _BestMatchesJobsState();
}

class _BestMatchesJobsState extends State<BestMatchesJobs> {
  bool isSavedJob = false;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 7,
      itemBuilder: (BuildContext context, int index) {
        return JobCardWidget(
          title:
              "Conversion Rate Expert needed for long term projects and Clients",
          budget: "Rs. 12,000/m",
          experience: "Intermediate",
          vacancy: "2",
          location: "Kapilvastu, Banganga-01, Bairiya",
          tags: const [
            "Flutter",
            "App",
            "IOS",
            "Android",
            "Hybrid",
            "Firebase",
            "Developer",
          ],
          isSavedJob: isSavedJob,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>  JobDetails(jobId: '', jobData: {}, userId:widget.userId,),
              ),
            );
          },
          onPressed: () {
            setState(() {
              isSavedJob = !isSavedJob;
            });
          },
        );
      },
    );
  }
}
