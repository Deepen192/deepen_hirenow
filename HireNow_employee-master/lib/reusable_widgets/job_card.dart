import 'package:flutter/material.dart';


class JobCardWidget extends StatelessWidget {
  final String title;
  final String budget;
  final String experience;
  final String vacancy;
  final String location;
  final List<String> tags; 
  final bool isSavedJob;
  final VoidCallback onTap;
  final VoidCallback onPressed;

  const JobCardWidget({
    Key? key,
    required this.title,
    required this.budget,
    required this.experience,
    required this.vacancy,
    required this.location,
    required this.tags,
    required this.isSavedJob,
    required this.onTap,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.only(bottom: 12),
        elevation: 2,
        shadowColor: const Color(0xFF000000),
        color: const Color(0xFFFFFFFF),
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Color(0xFF0095FF),
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  IconButton(
                    onPressed: onPressed,
                    icon: Icon(
                      isSavedJob
                          ? Icons.favorite_rounded
                          : Icons.favorite_border_rounded,
                      color: const Color(0xFF0095FF),
                    ),
                  ),
                ],
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
              const SizedBox(
                height: 4,
              ),
              SizedBox(
                height: 40,
                child: Row(
                   children: [
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: tags.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: Chip(
                              elevation: 2,
                              backgroundColor: const Color(0xFFFFFFFF),
                              shadowColor: const Color(0xFF000000),
                              side: const BorderSide(
                                width: 1,
                                color: Color(0xFFFFFFFF),
                              ),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              labelPadding: const EdgeInsets.all(0),
                              label: Text(
                                tags[index],
                                style: const TextStyle(
                                  color: Color(0xFF28282B),
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
            ],
          ),
        ),
      ),
    );
  }
}
