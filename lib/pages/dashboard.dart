import 'package:flutter/material.dart';
import 'package:pragati/constants/consts.dart';
import 'package:pragati/controllers/projectController.dart';
import 'package:pragati/controllers/tokeController.dart';
import 'package:pragati/models/project.dart';
import 'package:pragati/models/workPackage.dart';
import 'package:pragati/widgets/cashFlowIndicator.dart';
import 'package:pragati/widgets/projectCard.dart';
import 'package:pragati/widgets/searchField.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late Future<List<Project>> _projectsFuture;
  List<Project> _ongoingProjects = [];
  List<Project> _completedProjects = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadProjects();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadProjects() async {
    try {
      final token = await getToken(); // Fetch token from UserController
      ProjectController _projectController = ProjectController();

      final data = await _projectController.getAllProjects(token!);
      print(data);
      setState(() {
        _ongoingProjects = data
            .map((data) => Project.fromJson(data))
            .toList()
            .reversed
            .toList();

        _completedProjects = [];
        print(_ongoingProjects[0].clientName);
      });
    } catch (e) {
      print('Error loading projects: $e');
    }
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 15),
            Container(
              width: w,
              height: 186,
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
                            amount: 76543,
                            label: 'Cash Outflow',
                            outflow: true),
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
                padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: Column(
                  children: [
                    SearchField(),
                    const SizedBox(height: 10),
                    // TabBar
                    TabBar(
                      controller: _tabController,
                      indicatorColor: primaryColor,
                      labelColor: primaryColor,
                      unselectedLabelColor: Colors.grey,
                      tabs: const [
                        Tab(text: "Ongoing"),
                        Tab(text: "Completed"),
                      ],
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 314, // Adjust height as needed
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          // Ongoing Projects
                          SingleChildScrollView(
                            child: Column(
                              children: _ongoingProjects
                                  .map((project) => ProjectCard(
                                        project: Project(
                                          projectId: project.projectId,
                                          projectName: project.projectName,
                                          location: project.location,
                                          clientName: project.clientName,
                                          workpackages:
                                              project.workpackages.isNotEmpty
                                                  ? project.workpackages
                                                  : [
                                                      WorkPackage(
                                                        packageName:
                                                            'Default Package',
                                                        measurementUnit: 'Unit',
                                                        quantity: 0,
                                                        rate: 0,
                                                        margin: 0,
                                                      ),
                                                    ],
                                        ),
                                      ))
                                  .toList(),
                            ),
                          ),
                          SizedBox(height: 10),

                          // Completed Projects
                          SingleChildScrollView(
                            child: Column(
                              children: _completedProjects
                                  .map((project) => ProjectCard(
                                        project: Project(
                                          projectId: project.projectId,
                                          projectName: project.projectName,
                                          location: project.location,
                                          clientName: project.clientName,
                                          workpackages:
                                              project.workpackages.isNotEmpty
                                                  ? project.workpackages
                                                  : [
                                                      WorkPackage(
                                                        packageName:
                                                            'Default Package',
                                                        measurementUnit: 'Unit',
                                                        quantity: 0,
                                                        rate: 0,
                                                        margin: 0,
                                                      ),
                                                    ],
                                        ),
                                      ))
                                  .toList(),
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
      ),
    );
  }
}
