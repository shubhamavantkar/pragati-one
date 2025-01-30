import 'package:flutter/material.dart';
import 'package:pragati/constants/consts.dart';
import 'package:pragati/pages/addProject.dart';
import 'package:pragati/pages/eTenderScreen.dart';
import 'package:pragati/pages/projectDashboard.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const ProjectDashboard(),
    const ETenderScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      body: _screens[_selectedIndex],
      floatingActionButton: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              spreadRadius: 1,
            ),
          ],
        ),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddProjectPage(),
                ));
          },
          backgroundColor: primaryColor,
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 10, spreadRadius: 1),
          ],
        ),
        child: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 10,
          child: BottomNavigationBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.business,
                    color: _selectedIndex == 0 ? primaryColor : Colors.grey),
                label: 'Projects',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.article,
                    color: _selectedIndex == 1 ? primaryColor : Colors.grey),
                label: 'E-Tender',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: primaryColor,
            unselectedItemColor: Colors.grey,
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}
