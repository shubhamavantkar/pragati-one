import 'package:flutter/material.dart';
import 'package:pragati/constants/consts.dart';
import 'package:pragati/models/workPackage.dart';
import 'package:pragati/pages/workOrderPage.dart';
import 'package:pragati/widgets/button.dart';
import 'package:pragati/widgets/expandableWorkPackage.dart';
import 'package:pragati/widgets/formTextField.dart';
import 'package:pragati/widgets/pragatiDottedButton.dart';
import 'package:pragati/controllers/projectController.dart';
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

  List<WorkPackage> workOrders = [];
  num _amount = 0;
  num _profit = 0;

  // Reference to your project controller
  final ProjectController projectController = ProjectController();

  /// Calculates the total amount and profit from the workOrders list.
  void _calculateTotal() {
    _amount = 0;
    _profit = 0;
    for (var order in workOrders) {
      _amount += order.amount;
      _profit += order.profit;
    }
  }

  /// Helper to pick a date and update the corresponding controller.
  Future<void> _pickDate(TextEditingController controller) async {
    try {
      final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
      );
      if (pickedDate != null) {
        setState(() {
          controller.text = pickedDate.toLocal().toString().split(' ')[0];
        });
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error selecting date: $error')));
    }
  }

  /// Validates required fields before project creation.
  bool _validateForm() {
    if (_projectNameController.text.isEmpty ||
        _clientNameController.text.isEmpty ||
        _locationController.text.isEmpty ||
        _retentionController.text.isEmpty ||
        _startDateController.text.isEmpty ||
        _endDateController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please fill in all required fields')));
      return false;
    }
    return true;
  }

  /// Creates the project after validating inputs, token and then calling the API.
  Future<void> _createProject() async {
    if (!_validateForm()) return;

    final projectData = {
      'projectName': _projectNameController.text.trim(),
      'clientName': _clientNameController.text.trim(),
      'location': _locationController.text.trim(),
      'retention': _retentionController.text.trim(),
      'startDate': _startDateController.text.trim(),
      'endDate': _endDateController.text.trim(),
      'workOrders': workOrders.map((wo) => wo.toSaveJson()).toList(),
    };

    try {
      // Retrieve token and check its validity.
      String? token = await getToken();
      if (token == null || token.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Token not found. Please log in again.')));
        return;
      }

      final response = await projectController.createProject(projectData, token);
      if (response['success'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Project Created Successfully')));
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to create project')));
      }
    } catch (error) {
      // Handle any errors from the API call.
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
        title: const Text(
          'Add Project',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Container(
              color: Colors.white,
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
                            await _pickDate(_startDateController);
                          },
                          child: AbsorbPointer(
                            child: FormTextField(
                              suffix: Icon(
                                Icons.calendar_month,
                                color: Colors.grey.shade300,
                              ),
                              controller: _startDateController,
                              hintText: 'Start Date',
                              label: 'Start Date',
                              prefixImage: const SizedBox(),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            await _pickDate(_endDateController);
                          },
                          child: AbsorbPointer(
                            child: FormTextField(
                              suffix: Icon(
                                Icons.calendar_month,
                                color: Colors.grey.shade300,
                              ),
                              controller: _endDateController,
                              hintText: 'End Date',
                              label: 'End Date',
                              prefixImage: const SizedBox(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Project Photos',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: w * 0.03,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  PragatiDottedButton(
                    label: 'Upload',
                    onTap: () {
                      // TODO: Implement photo upload logic here.
                    },
                    backgroundColor: Colors.white,
                    height: 45,
                    icon: Icons.photo_library_outlined,
                    labelColor: Colors.grey,
                    labelSize: 12,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Work Orders list
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Work Orders',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                      const SizedBox(height: 5),
                      ...workOrders.map(
                        (order) => ExpandableWorkPackage(order: order),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 45,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        try {
                          final newWorkOrder = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AddWorkOrderPage(),
                            ),
                          );
                          if (newWorkOrder != null && newWorkOrder is WorkPackage) {
                            setState(() {
                              workOrders.add(newWorkOrder);
                            });
                          }
                        } catch (error) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Error adding work order: $error')));
                        }
                      },
                      style: ButtonStyle(
                        elevation: WidgetStatePropertyAll(0),
                        backgroundColor: WidgetStatePropertyAll(const Color(0xFFF2F0FC)),
                        foregroundColor: WidgetStatePropertyAll(primaryColor),
                        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                      child: const Text(
                        'Add Work Package',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  FormTextField(
                    suffix: Icon(
                      Icons.percent,
                      color: Colors.grey.shade300,
                      size: 20,
                    ),
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
            const SizedBox(height: 150),
          ],
        ),
      ),
      floatingActionButton: workOrders.isNotEmpty
          ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              height: 110,
              color: Colors.white,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total Amount:',
                        style: TextStyle(fontSize: 10),
                      ),
                      Text(
                        'Rs. $_amount',
                        style: const TextStyle(fontSize: 10),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Expected Profit:',
                        style: TextStyle(fontSize: 10),
                      ),
                      Text(
                        'Rs. $_profit',
                        style: const TextStyle(fontSize: 10),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  PragatiButton(
                    onPressed: _createProject,
                    child: const Text('Add Project'),
                  ),
                ],
              ),
            )
          : const SizedBox(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  @override
  void dispose() {
    _projectNameController.dispose();
    _clientNameController.dispose();
    _locationController.dispose();
    _retentionController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    super.dispose();
  }
}
