import 'package:flutter/material.dart';
import 'package:flutter_application_1/reusable_widgets/proposal_card.dart';
import 'package:flutter_application_1/widgets_common/proposal_details.dart';


class Proposals extends StatefulWidget {
  final String userId;
  const Proposals({super.key, required this.userId});

  @override
  State<Proposals> createState() => _ProposalsState();
}

class _ProposalsState extends State<Proposals> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
    
      shrinkWrap: true,
      itemCount: 20,
      itemBuilder: (BuildContext context, int index) {
        return ProposalCard(
          title:
              "Conversion Rate Expert needed for long term projects and Clients",
          submittedDate: "2080-03-12",
          // 'applied', 'hired', 'rejected', 'interview', 'closed', 'completed'
          status: "hired",
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>  ProposalDetails(userId: widget.userId,),
              ),
            );
          },
        );
      },
    );
  }
}
