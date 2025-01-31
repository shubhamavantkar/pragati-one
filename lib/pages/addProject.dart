import 'package:flutter/material.dart';
import 'package:pragati/constants/consts.dart';
import 'package:pragati/pages/workOrderPage.dart';
import 'package:pragati/widgets/button.dart';
import 'package:pragati/widgets/formTextField.dart';
import 'package:pragati/widgets/pragatiDottedButton.dart';
import 'package:pragati/controllers/projectController.dart'; // Import the controller
import 'package:pragati/controllers/tokeController.dart';

class AddProjectPage extends StatefulWidget {
  const AddProjectPage({super.key});

  @override
  State<AddProjectPage> createState() => _AddProjectPageState();
}

class _AddProjectPageState extends State<AddProjectPage> {
  final TextEditingController _projectNameController = TextEditingController();
  final TextEditingController _clientNameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _retentionController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();

  List<Map<String, dynamic>> workOrders = [];

  // Reference to your project controller
  final ProjectController projectController = ProjectController();

  void _createProject() async {
    final projectData = {
      'projectName': _projectNameController.text,
      'clientName': _clientNameController.text,
      'location': _locationController.text,
      'retention': _retentionController.text,
      'startDate': _startDateController.text,
      'endDate': _endDateController.text,
      'workOrders': workOrders, // Add the work orders here
    };

    try {
      // Retrieve token
      String? token = await getToken();
      print(token); // Check if the token is null
      if (token == null || token.isEmpty) {
        // Handle case where token is not found (e.g., show an error or redirect to login)
        print("Token not found. Please log in again.");
        return;
      }

      final response =
          await projectController.createProject(projectData, token);
      print(response);
      if (response['success']) {
        // Handle success (e.g., navigate to the project list or show success message)
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Project Created Successfully')));
        Navigator.pop(context);
      } else {
        // Handle error (e.g., show an error message)
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Failed to create project')));
      }
    } catch (error) {
      // Handle API error
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: $error')));
    }
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.sizeOf(context).width;

    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Add Project',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    FormTextField(
                      controller: _projectNameController,
                      hintText: 'Enter Project Name',
                      label: 'Project Name',
                      necessary: true,
                      prefixImage: Image.asset(
                        'assets/projectName.png',
                        height: 15,
                      ),
                    ),
                    FormTextField(
                      controller: _clientNameController,
                      hintText: 'Enter Client Name',
                      label: 'Client Name',
                      necessary: true,
                      prefixImage: Image.asset(
                        'assets/clientName.png',
                        height: 15,
                      ),
                    ),
                    FormTextField(
                      controller: _locationController,
                      hintText: 'Enter Project Location',
                      label: 'Location',
                      necessary: true,
                      prefixImage: Image.asset(
                        'assets/location.png',
                        height: 15,
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              final DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2100),
                              );
                              if (pickedDate != null) {
                                setState(() {
                                  _startDateController.text = pickedDate
                                      .toLocal()
                                      .toString()
                                      .split(' ')[0];
                                });
                              }
                            },
                            child: AbsorbPointer(
                              child: FormTextField(
                                controller: _startDateController,
                                hintText: 'Select Start Date',
                                label: 'Start Date',
                                prefixImage: SizedBox(),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              final DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2100),
                              );
                              if (pickedDate != null) {
                                setState(() {
                                  _endDateController.text = pickedDate
                                      .toLocal()
                                      .toString()
                                      .split(' ')[0];
                                });
                              }
                            },
                            child: AbsorbPointer(
                              child: FormTextField(
                                controller: _endDateController,
                                hintText: 'Select End Date',
                                label: 'End Date',
                                prefixImage: SizedBox(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Project Photos',
                          style: TextStyle(fontWeight: FontWeight.w600)),
                    ),
                    SizedBox(height: 5),
                    PragatiDottedButton(
                      label: 'Upload',
                      onTap: () {},
                      backgroundColor: Colors.white,
                      height: 45,
                      icon: Icons.photo_library_outlined,
                      labelColor: Colors.grey,
                      labelSize: 12,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Work Orders',
                          style: TextStyle(fontWeight: FontWeight.w600)),
                    ),
                    ...workOrders.map((order) => ListTile(
                          title: Text(order['name']),
                          subtitle: Text('Amount: Rs.${order['amount']}'),
                        )),
                    SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          final newWorkOrder = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AddWorkOrderPage()),
                          );
                          if (newWorkOrder != null) {
                            setState(() {
                              workOrders.add(newWorkOrder);
                            });
                          }
                        },
                        style: ButtonStyle(
                            elevation: WidgetStatePropertyAll(0),
                            backgroundColor:
                                WidgetStatePropertyAll(Color(0xFFF2F0FC)),
                            foregroundColor:
                                WidgetStatePropertyAll(primaryColor),
                            shape:
                                WidgetStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ))),
                        child: Text(
                          'Add Work Package',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    FormTextField(
                      controller: _retentionController,
                      hintText: '% of Retention',
                      label: 'Retention',
                      prefixImage: Image.asset(
                        'assets/retention.png',
                        height: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
      floatingActionButton: workOrders.isNotEmpty
          ? Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
              child: PragatiButton(
                  onPressed: _createProject, child: Text('Add Project')),
            )
          : SizedBox(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
