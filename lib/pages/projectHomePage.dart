import 'package:flutter/material.dart';
import 'package:pragati/constants/consts.dart';
import 'package:pragati/models/project.dart';
import 'package:pragati/pages/assignScreen.dart';
import 'package:pragati/pages/dashboardScreen.dart';
import 'package:pragati/pages/materialPage.dart';

class ProjectHomePage extends StatefulWidget {
  final Project project;

  ProjectHomePage({super.key, required this.project});

  @override
  State<ProjectHomePage> createState() => _ProjectHomePageState();
}

class _ProjectHomePageState extends State<ProjectHomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      AssignScreen(
        project: widget.project,
      ),
      AssignScreen(
        project: widget.project,
      ),
      AssignScreen(
        project: widget.project,
      ),
      // ProgressScreen(),
      MaterialScreen(),
      AssignScreen(
        project: widget.project,
      ),
      // MaterialScreen(),
      // AccountScreen(),
    ];
    double w = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        leadingWidth: 40,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Image.asset(
                'assets/project.png',
                height: 25,
              ),
            ),
            Text(
              widget.project.projectName,
              style:
                  TextStyle(fontSize: w * 0.045, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey.withOpacity(0.3))),
              child: Icon(
                Icons.menu,
                size: 22,
              ),
            ),
          )
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        color: Colors.white,
        height: 80,
        child: BottomNavigationBar(
          elevation: 0,
          type: BottomNavigationBarType.fixed, // Ensures all labels are visible
          currentIndex: _selectedIndex,
          selectedItemColor: primaryColor,
          unselectedItemColor: Colors.black54,
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.assignment), label: 'Assign'),
            BottomNavigationBarItem(
                icon: Icon(Icons.timeline), label: 'Progress'),
            BottomNavigationBarItem(
                icon: Icon(Icons.dashboard), label: 'Dashboard'),
            BottomNavigationBarItem(
                icon: Icon(Icons.construction), label: 'Material'),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle), label: 'Account'),
          ],
        ),
      ),
    );
  }
}
