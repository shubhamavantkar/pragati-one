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
  num _amount = 0;
  num _profit = 0;
  void _calculateTotal() {
    _amount = 0;
    _profit = 0;
    for (var order in workOrders) {
      _amount += order['amount'];
      _profit += order['profit'];
    }
  }

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
    _calculateTotal();
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
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: w * 0.03)),
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Work Orders',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        ...workOrders.map(
                          (order) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                      color:
                                          Colors.grey.withValues(alpha: 0.3))),
                              child: ExpansionTile(
                                backgroundColor: Colors.white,
                                collapsedBackgroundColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12)),
                                    side: BorderSide(
                                        color:
                                            Colors.grey.withValues(alpha: 0))),
                                title: Text(
                                  order['name'],
                                  style: TextStyle(fontSize: w * 0.04),
                                ),
                                subtitle: Text(
                                  'Rs.${order['amount']}',
                                  style: TextStyle(fontSize: w * 0.025),
                                ),
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Unit of Measurement',
                                              style:
                                                  TextStyle(fontSize: w * 0.03),
                                            ),
                                            Text(
                                              order['unit'],
                                              style: TextStyle(
                                                  fontSize: w * 0.03,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Quantity',
                                              style:
                                                  TextStyle(fontSize: w * 0.03),
                                            ),
                                            Text(
                                              order['quantity'],
                                              style: TextStyle(
                                                  fontSize: w * 0.03,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Rate',
                                              style:
                                                  TextStyle(fontSize: w * 0.03),
                                            ),
                                            Text(
                                              order['rate'],
                                              style: TextStyle(
                                                  fontSize: w * 0.03,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Amount',
                                              style:
                                                  TextStyle(fontSize: w * 0.03),
                                            ),
                                            Text(
                                              order['amount'].toString(),
                                              style: TextStyle(
                                                  fontSize: w * 0.03,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Expected Margin',
                                              style:
                                                  TextStyle(fontSize: w * 0.03),
                                            ),
                                            Text(
                                              '${order['margin']}% ${order['profit']}',
                                              style: TextStyle(
                                                  color: Colors.green,
                                                  fontSize: w * 0.03,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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
            SizedBox(height: 150),
          ],
        ),
      ),
      floatingActionButton: workOrders.isNotEmpty
          ? Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              height: 110,
              color: Colors.white,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Amount:',
                        style: TextStyle(fontSize: 10),
                      ),
                      Text(
                        'Rs. $_amount',
                        style: TextStyle(fontSize: 10),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Expected Profit:',
                        style: TextStyle(fontSize: 10),
                      ),
                      Text(
                        'Rs. $_profit',
                        style: TextStyle(fontSize: 10),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  PragatiButton(
                      onPressed: _createProject, child: Text('Add Project')),
                ],
              ),
            )
          : SizedBox(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
