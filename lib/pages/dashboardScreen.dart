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
      floatingActionButton: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddProjectPage(),
              ));
        },
        child: CircleAvatar(
          radius: 40,
          backgroundColor: Color(0xFFA9C0FF),
          child: CircleAvatar(
            radius: 33,
            backgroundColor: primaryColor,
            child: Icon(Icons.add, size: 40, color: Colors.white),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        elevation: 7,
        shadowColor: Colors.grey,
        shape: CircularNotchedRectangle(),
        notchMargin: 5.0,
        color: Colors.white, // White background
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.business, "Projects", 0),
              SizedBox(width: 40), // Space for FAB
              _buildNavItem(Icons.description_outlined, "E-Tender", 1),
            ],
          ),
        ),
      ),
      extendBody: true,
      // bottomNavigationBar: BottomAppBar(
      //   color: Colors.white,
      //   shape: const AutomaticNotchedShape(
      //     RoundedRectangleBorder(
      //       borderRadius: BorderRadius.all(Radius.circular(12)),
      //     ),
      //   ),
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceAround,
      //     children: [
      //       IconButton(
      //         icon: const Icon(Icons.business),
      //         onPressed: () => _onItemTapped(0),
      //         tooltip: 'Projects',
      //       ),
      //       Container(
      //         height: 60,
      //         width: 50,
      //         decoration: const BoxDecoration(
      //           color: primaryColor,
      //           shape: BoxShape.circle,
      //         ),
      //         child: IconButton(
      //           icon: const Icon(Icons.add, color: Colors.white),
      //           onPressed: () {
      //             Navigator.push(
      //               context,
      //               MaterialPageRoute(
      //                 builder: (context) => const AddProjectPage(),
      //               ),
      //             );
      //           },
      //           tooltip: 'Add Project',
      //         ),
      //       ),
      //       IconButton(
      //         icon: const Icon(Icons.article),
      //         onPressed: () => _onItemTapped(1),
      //         tooltip: 'E-Tender',
      //       ),
      //     ],
      //   ),
      // ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    return InkWell(
      onTap: () => _onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: _selectedIndex == index ? primaryColor : Colors.grey,
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: _selectedIndex == index ? primaryColor : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
