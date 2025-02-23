import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pragati/models/project.dart';
import 'package:pragati/widgets/button.dart';
import 'package:pragati/widgets/formDropDown.dart';
import 'package:pragati/widgets/formTextField.dart';
import 'package:pragati/controllers/projectController.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Assumed helper to get token

class AssignSupervisorForm extends StatefulWidget {
  final Project project;
  const AssignSupervisorForm({super.key, required this.project});

  @override
  State<AssignSupervisorForm> createState() => _AssignSupervisorFormState();
}

class _AssignSupervisorFormState extends State<AssignSupervisorForm> {
  final TextEditingController _supervisorNameController =
      TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _salaryController = TextEditingController();

  // List to hold work orders loaded from API.
  List<dynamic> workOrders = [];
  String? selectedWorkPackage;

  @override
  void initState() {
    super.initState();
    _loadWorkOrders();
  }

  Future<void> _loadWorkOrders() async {
    try {
      print('Loading work orders for project: ${widget.project.projectId}');
// Retrieve the stored token
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('authToken');
      if (token == null) {
        print('Token is null');
        Fluttertoast.showToast(msg: 'Authentication token not found');
        return;
      }

      setState(() {
        workOrders = [];
      });

      final projectController = ProjectController();
      final workOrdersData = await projectController.getAllWorkOrders(
          widget.project.projectId, token);

      print('Work orders API response: $workOrdersData');

      if (workOrdersData.isEmpty) {
        Fluttertoast.showToast(msg: 'No work orders found for this project');
        return;
      }

      setState(() {
        workOrders = workOrdersData;
      });

      print('Updated work orders state: $workOrders');
    } catch (e) {
      print('Error loading work orders: $e');
      Fluttertoast.showToast(msg: 'Failed to load work orders: $e');
      setState(() {
        workOrders = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(232, 242, 240, 252),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Assign Supervisor',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(16.0),
        child: PragatiButton(
          onPressed: () async {
            if (_supervisorNameController.text.isNotEmpty &&
                _mobileNumberController.text.isNotEmpty &&
                _salaryController.text.isNotEmpty &&
                selectedWorkPackage != null) {
              // Find the selected work order using indexWhere.
              final selectedIndex = workOrders.indexWhere(
                (order) => order['name'] == selectedWorkPackage,
              );
              if (selectedIndex == -1) {
                Fluttertoast.showToast(
                  msg: 'Selected work package not found',
                  backgroundColor: Colors.redAccent,
                );
                return;
              }
              final selectedOrder = workOrders[selectedIndex];

              // Build the assigned work packages list.
              final List<Map<String, dynamic>> assignedWorkPackages = [
                {
                  "projectId": widget.project.projectId,
                  "workOrderId": selectedOrder['_id'],
                  "workPackageName": selectedOrder['name'],
                }
              ];

              // Call API to assign the supervisor.
              final projectController = ProjectController();
              bool success = await projectController.assignSupervisor(
                name: _supervisorNameController.text,
                mobileNumber: _mobileNumberController.text,
                salary: double.parse(_salaryController.text),
                assignedWorkPackages: assignedWorkPackages,
              );

              if (success) {
                Fluttertoast.showToast(
                  msg: "Supervisor assigned successfully!",
                  backgroundColor: Colors.green,
                );
                // Navigate to dashboard or previous screen.
                Navigator.pop(context);
              } else {
                Fluttertoast.showToast(
                  msg: "Failed to assign supervisor",
                  backgroundColor: Colors.redAccent,
                );
              }
            } else {
              Fluttertoast.showToast(
                msg: 'Please enter all details',
                backgroundColor: Colors.redAccent,
              );
            }
          },
          child: const Text('Assign'),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              color: Colors.white,
              child: Column(
                children: [
                  FormTextField(
                    hintText: 'Enter Name',
                    necessary: true,
                    label: 'Supervisor Name',
                    controller: _supervisorNameController,
                  ),
                  FormTextField(
                    keyboardType: TextInputType.phone,
                    hintText: 'Enter Mobile Number',
                    necessary: true,
                    label: 'Mobile Number',
                    controller: _mobileNumberController,
                  ),
                  FormDropdown(
                    label: 'Work Package',
                    items: workOrders.isNotEmpty
                        ? workOrders
                            .map((order) => order['name'].toString())
                            .toList()
                        : [],
                    necessary: true,
                    hintText: 'Select Work Package',
                    onChanged: (package) {
                      setState(() {
                        selectedWorkPackage = package;
                      });
                    },
                  ),
                  FormTextField(
                    keyboardType: TextInputType.number,
                    hintText: 'Enter Salary',
                    label: 'Salary (monthly)',
                    controller: _salaryController,
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
