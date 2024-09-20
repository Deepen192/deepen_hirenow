import 'package:flutter_application_1/consts/consts.dart'; // Adjust the import based on your project structure

class UserAgreementScreen extends StatelessWidget {
  const UserAgreementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: const Color(0xFFDAD3BE),
        title: const Text(
          'User Agreement',
          style: TextStyle(
            color: Colors.black,
            fontFamily: semibold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'User Agreement',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              // Text(
              //   'Last Updated: [Date]',
              //   style: TextStyle(
              //     fontSize: 16,
              //     color: Colors.grey,
              //   ),
              // ),
              SizedBox(height: 24),
              Text(
                'Welcome to [App Name]. This User Agreement ("Agreement") governs your use of our mobile application ("App") and the services provided through the App. By downloading, accessing, or using the App, you agree to be bound by this Agreement.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 24),
              Text(
                '1. Introduction',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Text(
                '1.1 About the App',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                '[App Name] is a branch of the [Brand Name] brand. The app is managed by [Company Name], which is a branch of [Parent Company Name]. This app provides users with [brief description of services or products offered by the app].',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 24),
              Text(
                '1.2 Management and Responsibility',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'The branch of [Company Name] managing the App is led by [Branch Manager\'s Name], who is responsible for the day-to-day operations, management of services, and compliance with legal and regulatory requirements. Users can contact the branch manager at [contact information] for any inquiries or support.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 24),
              Text(
                '2. Acceptance of Terms',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'By accessing or using the App, you agree to comply with and be bound by the terms and conditions of this Agreement. If you do not agree to these terms, you should not use the App.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 24),
              Text(
                '3. Responsibilities of the Branch Manager',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Text(
                '3.1 The branch manager is responsible for ensuring that the App operates smoothly and efficiently, providing users with a high-quality experience.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(
                '3.2 The branch manager is accountable for maintaining the privacy and security of user data in compliance with applicable laws and regulations.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(
                '3.3 Any disputes or issues that arise from the use of the App will be handled by the branch manager, who will work to resolve them promptly and fairly.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 24),
              Text(
                '4. User Responsibilities',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Text(
                '4.1 Users must provide accurate and truthful information when creating an account and using the App.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(
                '4.2 Users are responsible for maintaining the confidentiality of their account information and passwords.',
                style: TextStyle(fontSize: 16),
              ),
              // Add more sections as needed
            ],
          ),
        ),
      ),
    );
  }
}
