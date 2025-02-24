import 'package:flutter/material.dart';
import 'package:pragati/constants/consts.dart';
import 'package:pragati/models/project.dart';
import 'package:pragati/models/supervisor.dart';
import 'package:pragati/pages/assignSupervisorForm.dart';
import 'package:pragati/widgets/searchField.dart';
import 'package:pragati/widgets/supervisorCard.dart';
import 'package:pragati/controllers/projectController.dart'; // Import the API function

class AssignSupervisor extends StatefulWidget {
  final Project project;
  AssignSupervisor({super.key, required this.project});

  @override
  State<AssignSupervisor> createState() => _AssignSupervisorState();
}

class _AssignSupervisorState extends State<AssignSupervisor> {
  List<Supervisor> _supervisors = [];
  bool _isLoading = true; // Loading indicator

  @override
  void initState() {
    super.initState();
    _loadSupervisors(); // Fetch supervisors when the page loads
  }

  Future<void> _loadSupervisors() async {
    try {
      ProjectController projectController = ProjectController();
      List<Supervisor> fetchedSupervisors =
          await projectController.fetchSupervisors(widget.project.projectId);
      setState(() {
        _supervisors = fetchedSupervisors;
        _isLoading = false;
      });
      print(fetchedSupervisors);
    } catch (e) {
      print("Error fetching supervisors: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        backgroundColor: primaryColor,
        onPressed: () async {
          final supervisor = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AssignSupervisorForm(
                project: widget.project,
              ),
            ),
          );
          if (supervisor != null) {
            setState(() {
              _supervisors.add(supervisor);
            });
          }
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SearchField(hintText: 'Search Supervisor'),
          SizedBox(height: 20),
          Expanded(
            child: _isLoading
                ? Center(
                    child: CircularProgressIndicator()) // Show loading spinner
                : _supervisors.isNotEmpty
                    ? ListView.builder(
                        itemCount: _supervisors.length,
                        itemBuilder: (context, index) {
                          return SupervisorCard(
                              supervisor: _supervisors[index]);
                        },
                      )
                    : Column(
                        children: [
                          SizedBox(height: 150),
                          Center(
                            child: Image.asset(
                              'assets/supervisor.png',
                              height: 150,
                            ),
                          ),
                        ],
                      ),
          ),
        ],
      ),
    );
  }
}
