import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/reusable_widgets/job_card.dart';
import 'package:flutter_application_1/services/firestore_services.dart';
import 'package:flutter_application_1/views/category/job_details.dart';


class SavedJobs extends StatefulWidget {
  final String userId;
  const SavedJobs({super.key, required this.userId});

  @override
  State<SavedJobs> createState() => _SavedJobsState();
}

class _SavedJobsState extends State<SavedJobs> {
  bool isSavedJob = true;

  @override
   Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirestoreServices.getWishlists(widget.userId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text("Error loading jobs"));
        } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text("No jobs available"));
        } else {
          final jobs = snapshot.data!.docs;

          return ListView.builder(
            itemCount: jobs.length,
            itemBuilder: (BuildContext context, int index) {
              final job = jobs[index];
              final List<dynamic> wishlist = job['p_wishlist'] ?? [];
               final String keywords = job['keywords'] ?? ''; // Retrieve the keywords string
              final List<String> tags = keywords.split(',').map((tag) => tag.trim()).toList(); // Split into a list

              bool isJobSaved = wishlist.contains(widget.userId);

              return JobCardWidget(
                title: job['p_name'], // Displaying p_name as title
                budget: '\Rs.${job['p_price']}', // Displaying p_price as budget
                experience: job['p_subcategory'], // Displaying p_subcategory as experience
                vacancy: job['p_quantity'], // Displaying p_quantity as vacancy
                location: job['p_jobaddress'], // Displaying p_jobaddress as location
                tags:tags,
                isSavedJob: isJobSaved,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>  JobDetails(
                         jobId: job.id, // Pass the job ID
                        jobData: job.data() as Map<String, dynamic>,
                       userId:widget. userId,),
                    ),
                  );
                },
                onPressed: () async {
                  setState(() {
                    isJobSaved = !isJobSaved;
                  });

                  if (isJobSaved) {
                    // Add userId to p_wishlist
                    await job.reference.update({
                      'p_wishlist': FieldValue.arrayUnion([widget.userId])
                    });
                  } else {
                    // Remove userId from p_wishlist
                    await job.reference.update({
                      'p_wishlist': FieldValue.arrayRemove([widget.userId])
                    });
                  }
                },
              );
            },
          );
        }
      },
    );
  }
}
