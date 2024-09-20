import 'package:flutter/material.dart';

class ProposalJobCardWidget extends StatelessWidget {
  final String title;
  final String budget;
  final String experience;
  final String vacancy;
  final String location;
  final VoidCallback onPressed;

  const ProposalJobCardWidget({
    Key? key,
    required this.title,
    required this.budget,
    required this.experience,
    required this.vacancy,
    required this.location,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(0),
      elevation: 2,
      shadowColor: const Color(0xFF000000),
      color: const Color(0xFFFFFFFF),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "About Job",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextButton(
                  onPressed: onPressed,
                  style: ButtonStyle(
                    padding: WidgetStateProperty.all<EdgeInsets>(
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 6)),
                    minimumSize: WidgetStateProperty.all<Size>(
                        const Size.fromRadius(0)),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: const Text(
                    'View Details',
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const Divider(
              thickness: 2,
            ),
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Color(0xFF0095FF),
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      "Budget",
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF28282B),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      budget,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xFF576F86),
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Experience",
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF28282B),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      experience,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xFF576F86),
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Vacancy",
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF28282B),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      vacancy,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xFF576F86),
                        fontWeight: FontWeight.w500,
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
              children: [
                const Icon(
                  Icons.place,
                  size: 24,
                  color: Color(0xFF28282B),
                ),
                Expanded(
                  child: Text(
                    location,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFF28282B),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
