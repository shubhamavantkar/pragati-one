import 'package:flutter/material.dart';
import 'package:pragati/models/project.dart';
import 'package:pragati/pages/projectHomePage.dart';
import 'package:pragati/widgets/radialBar.dart';

class ProjectCard extends StatelessWidget {
  final Project project;
  const ProjectCard({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.sizeOf(context).width;

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProjectHomePage(
                project: project,
              ),
            ));
      },
      child: Container(
        height: 260,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.withValues(alpha: 0.2))),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Image.asset('assets/defaultProject.png'),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'assets/projectNameBold.png',
                            height: w * 0.03,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            project.projectName,
                            style: TextStyle(
                                fontSize: w * 0.03,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Image.asset(
                            'assets/projectOwner.png',
                            height: w * 0.03,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            project.projectOwner,
                            style: TextStyle(
                                fontSize: w * 0.03,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Image.asset(
                            'assets/projectLocation.png',
                            height: w * 0.03,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            project.projectLocation,
                            style: TextStyle(
                                fontSize: w * 0.03,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SemiRadialGraph(value: 50, label: 'Invoice'),
                      SizedBox(
                        width: 10,
                      ),
                      SemiRadialGraph(value: 60, label: 'Cost'),
                      SizedBox(
                        width: 10,
                      ),
                      SemiRadialGraph(value: 80, label: 'Time'),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
