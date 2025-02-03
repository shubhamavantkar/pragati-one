import 'package:flutter/material.dart';
import 'package:pragati/constants/consts.dart';
import 'package:pragati/controllers/projectController.dart';
import 'package:pragati/models/project.dart';
import 'package:pragati/widgets/cashFlowIndicator.dart';
import 'package:pragati/widgets/projectCard.dart';
import 'package:pragati/widgets/searchField.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProjectDashboard extends StatefulWidget {
  const ProjectDashboard({super.key});

  @override
  _ProjectDashboardState createState() => _ProjectDashboardState();
}

class _ProjectDashboardState extends State<ProjectDashboard>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<Project> ongoingProjects = [];
  List<Project> completedProjects = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _fetchProjects();
  }

  Future<void> _fetchProjects() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');

    ProjectController projectController = ProjectController();
    List<Map<String, dynamic>> projects =
        await projectController.getAllProjects(token!);

    setState(() {
      ongoingProjects = projects
          .map((p) => Project.fromJson(p))
          .toList(); // Ongoing projects populated here
      completedProjects = []; // No completed projects yet

      isLoading = false;
    });
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
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 15),
                  _buildCashFlowSection(w),
                  const SizedBox(height: 15),
                  _buildProjectSection(w),
                ],
              ),
            ),
    );
  }

  Widget _buildCashFlowSection(double w) {
    return Container(
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
                    amount: 76543, label: 'Cash Outflow', outflow: true),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildProjectSection(double w) {
    return Container(
      color: Colors.white,
      width: w,
      child: Padding(
        padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: Column(
          children: [
            SearchField(),
            const SizedBox(height: 10),
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
              height: 314,
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildProjectList(ongoingProjects),
                  _buildProjectList(completedProjects),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProjectList(List<Project> projects) {
    return SingleChildScrollView(
      child: Column(
        children:
            projects.reversed.map((project) => ProjectCard(project: project)).toList(),
      ),
    );
  }
}
