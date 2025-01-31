import 'package:flutter/material.dart';
import 'package:pragati/constants/consts.dart';
import 'package:pragati/models/project.dart';
import 'package:pragati/widgets/cashFlowIndicator.dart';
import 'package:pragati/widgets/projectCard.dart';
import 'package:pragati/widgets/searchField.dart';

class ProjectDashboard extends StatefulWidget {
  const ProjectDashboard({super.key});

  @override
  _ProjectDashboardState createState() => _ProjectDashboardState();
}

class _ProjectDashboardState extends State<ProjectDashboard>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.sizeOf(context).width;

    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      appBar: AppBar(
        toolbarHeight: 80,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Icon(Icons.notifications_none_outlined),
          )
        ],
        title: Row(
          children: [
            const CircleAvatar(
              radius: 22,
              child: Image(image: AssetImage('assets/profile.png')),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Good Morning', style: TextStyle(fontSize: 14)),
                Text('Shubham!',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            )
          ],
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 15),
          Container(
            width: w,
            height: 170,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CashFlowIndicator(
                          label: 'Receivable',
                          amount: 1229000,
                          showCaption: true,
                          outflow: false),
                      CashFlowIndicator(
                          label: 'Payable',
                          amount: 1229000,
                          showCaption: true,
                          outflow: true),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CashFlowIndicator(amount: 24357, label: 'Cash Inflow'),
                      CashFlowIndicator(
                          amount: 76543, label: 'Cash Outflow', outflow: true),
                    ],
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 15),
          Container(
            color: Colors.white,
            width: w,
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  SearchField(),
                  const SizedBox(height: 10),
                  // TabBar
                  TabBar(
                    controller: _tabController,
                    indicatorColor: Colors.blue,
                    labelColor: Colors.blue,
                    unselectedLabelColor: Colors.grey,
                    tabs: const [
                      Tab(text: "Ongoing"),
                      Tab(text: "Completed"),
                    ],
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 300, // Adjust height as needed
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        // Ongoing Projects
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              ProjectCard(
                                project: Project.new(
                                    projectName: 'Project Pragati',
                                    projectLocation: 'Bald Street, Haripur',
                                    projectOwner: 'Jin Sakai'),
                              ),
                              ProjectCard(
                                project: Project.new(
                                    projectName: 'Project Zen',
                                    projectLocation: 'Maple Street, Kyoto',
                                    projectOwner: 'Samurai Jack'),
                              ),
                            ],
                          ),
                        ),
                        // Completed Projects
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              ProjectCard(
                                project: Project.new(
                                    projectName: 'Project Alpha',
                                    projectLocation: 'Sunset Blvd, Tokyo',
                                    projectOwner: 'Hideo Kojima'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
