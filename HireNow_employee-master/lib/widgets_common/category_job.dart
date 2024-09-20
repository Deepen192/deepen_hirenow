import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/consts/consts.dart';
import 'package:flutter_application_1/services/firestore_services.dart';
import 'package:flutter_application_1/reusable_widgets/job_card.dart';
import 'package:flutter_application_1/views/category/job_details.dart';

class CategoryJobsScreen extends StatefulWidget {
  final String userId;
  final String category;
 

  const CategoryJobsScreen({
    super.key,
    required this.userId,
    required this.category,
    
  });

  @override
  State<CategoryJobsScreen> createState() => _CategoryJobsScreenState();
}

class _CategoryJobsScreenState extends State<CategoryJobsScreen> {
  bool isSavedJob = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: Text('${widget.category} Jobs'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirestoreServices.jobsByCategoryAndTitle(widget.category),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text("Error loading jobs"));
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("No jobs found for the selected category."),
                 
                ],
              ),
            );
          } else {
            final jobs = snapshot.data!.docs;

            return ListView.builder(
              itemCount: jobs.length,
              itemBuilder: (BuildContext context, int index) {
                final job = jobs[index];
                final List<dynamic> wishlist = job['p_wishlist'] ?? [];
                final String keywords = job['keywords'] ?? '';
                final List<String> tags = keywords.split(',').map((tag) => tag.trim()).toList();

                bool isJobSaved = wishlist.contains(widget.userId);

                return JobCardWidget(
                  title: job['p_name'],
                  budget: '\Rs.${job['p_price']}',
                  experience: job['p_subcategory'],
                  vacancy: job['p_quantity'],
                  location: job['p_jobaddress'],
                  tags: tags,
                  isSavedJob: isJobSaved,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => JobDetails(
                          jobId: job.id,
                          jobData: job.data() as Map<String, dynamic>,
                          userId: widget.userId,
                        ),
                      ),
                    );
                  },
                  onPressed: () async {
                    setState(() {
                      isJobSaved = !isJobSaved;
                    });

                    if (isJobSaved) {
                      await job.reference.update({
                        'p_wishlist': FieldValue.arrayUnion([widget.userId])
                      });
                    } else {
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
      ),
    );
  }
}
