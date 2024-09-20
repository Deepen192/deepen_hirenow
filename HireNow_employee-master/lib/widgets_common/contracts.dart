
import 'package:flutter_application_1/consts/consts.dart';
import 'package:flutter_application_1/views/category/job_details.dart';


class Contracts extends StatelessWidget {
  final String userId;
  const Contracts({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 1, // Example item count
        itemBuilder: (BuildContext context, int index) {
          return  ContractCard(userId: userId,);
        },
      ),
    );
  }
}

class ContractCard extends StatelessWidget {
  final String userId;
  const ContractCard({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Card(
        margin: const EdgeInsets.all(0.0),
        elevation: 2,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side:
                BorderSide(width: 2, color: Colors.grey.shade700 //(0xFFFF00FF),
                    )),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Contract Details',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade800,
                  ),
                ),
              ),
              const Divider(thickness: 2, color: Color(0xFFff5f1f)),
              _buildSectionHeader('Job Information'),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  JobDetails(jobId: '', jobData: {}, userId:userId,)),
                  );
                },
                child: const Text(
                  "Conversion Rate Expert needed for long term projects and Clients",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Color(0xFF0095FF),
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Divider(thickness: 2),
              _buildSectionHeader('Employer Information'),
              _buildDetailRow('Name:', 'Xyz pvt. ltd.'),
              _buildDetailRow('Email:', 'xyz@gmail.com'),
              _buildDetailRow('Phone:', '9762838572'),
              _buildDetailRow('Location:', 'Butwal'),
              const Divider(thickness: 2),
              _buildSectionHeader('Employee Information'),
              _buildDetailRow('Name:', 'Shreya Acharya'),
              _buildDetailRow('Email:', 'shreya@gmail.com'),
              _buildDetailRow('Phone:', '9847184294'),
              _buildDetailRow('Location:', 'Butwal'),
              const Divider(thickness: 2),
              _buildSectionHeader('Contract Terms'),
              _buildDetailRow('Contract Duration:', '2080-03-01 to 2080-09-30'),
              _buildDetailRow('Position:', 'Full-time'),
              _buildDetailRow('Compensation:', 'NRs. 30,000 per month'),
              _buildDetailRow(
                  'Working Hours:', '9 AM to 5 PM, Monday to Friday'),
              _buildDetailRow('Termination:', '7 days notice required'),
              _buildDetailRow('Non-Competition:', '6 months post-employment'),
              _buildDetailRow(
                  'Benefits:', 'Basic injury and health treatment available'),
              _buildDetailRow('Vacation Time:', '2 days per month'),
              _buildDetailRow('Governing Law:', 'Labor Act, 2017, Nepal'),
              const Divider(thickness: 2),
              _buildSectionHeader('Other Information'),
              const Text(
                "50% of the first month's salary is transferred from the employer to our app.",
                style: TextStyle(fontSize: 16),
              ),
              const Divider(thickness: 2),
              _buildSectionHeader('Salary Terms *Important'),
              const Text(
                '''- 50% of the salary is transferred to our app.
- 25% of this amount is a service charge.
- 25% is held and paid after contract completion.
- If you leave early, this 25% is forfeited.
- The other 50% is paid directly by the employer.
- From the second month, 100% of the salary is paid directly by the employer without any charges.''',
                style: TextStyle(fontSize: 16),
              ),
              const Divider(thickness: 2),
              _buildSectionHeader('Agreement'),
              const Text(
                '''- This is the complete agreement.
- Both parties agree to follow all applicable laws.
- For unknown or unexpected events, mutual agreement on actions will be taken.''',
                style: TextStyle(fontSize: 16),
              ),
              const AgreementTerms(),
              const Divider(thickness: 2),
              _buildSectionHeader('Status'),
              _buildStatusChip('active'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.blue.shade800,
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color backgroundColor;
    Color textColor;
    IconData icon;
    String text;

    switch (status.toLowerCase()) {
      case 'active':
        backgroundColor = Colors.blue.shade100;
        textColor = Colors.blue.shade800;
        icon = Icons.access_time_rounded;
        text = 'Active';
        break;
      case 'completed':
        backgroundColor = Colors.green.shade100;
        textColor = Colors.green.shade800;
        icon = Icons.check_circle_outline;
        text = 'Completed';
        break;
      case 'terminated':
        backgroundColor = Colors.red.shade100;
        textColor = Colors.red.shade800;
        icon = Icons.cancel_outlined;
        text = 'Terminated';
        break;
      default:
        backgroundColor = Colors.blue.shade100;
        textColor = Colors.blue.shade800;
        icon = Icons.question_mark_rounded;
        text = 'Unknown';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 30,
            color: textColor,
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class AgreementTerms extends StatefulWidget {
  const AgreementTerms({super.key});

  @override
  _AgreementTermsState createState() => _AgreementTermsState();
}

class _AgreementTermsState extends State<AgreementTerms> {
  bool _isEmployerAgreed = false;
  bool _isEmployeeAgreed = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Checkbox(
              value: _isEmployerAgreed,
              onChanged: (bool? newValue) {
                setState(() {
                  _isEmployerAgreed = newValue!;
                });
              },
            ),
            const Expanded(
              child: Text(
                'Employer agrees to the terms and conditions.',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Checkbox(
              value: _isEmployeeAgreed,
              onChanged: (bool? newValue) {
                setState(() {
                  _isEmployeeAgreed = newValue!;
                });
              },
            ),
            const Expanded(
              child: Text(
                'Employee agrees to the terms and conditions.',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
        if (_isEmployerAgreed && _isEmployeeAgreed)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              'Both parties have agreed to the terms and conditions.',
              style: TextStyle(
                color: Colors.green.shade800,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
      ],
    );
  }
}
