import 'package:flutter/material.dart';
import 'package:pragati/widgets/button.dart';
import 'package:pragati/widgets/formTextField.dart';
import 'package:pragati/widgets/formDropDown.dart';

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
  final TextEditingController _startDateController =
      TextEditingController(); // Start Date Controller
  final TextEditingController _endDateController =
      TextEditingController(); // End Date Controller

  List<Map<String, dynamic>> workOrders = [];

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.sizeOf(context).width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Project'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FormTextField(
              controller: _projectNameController,
              hintText: 'Enter Project Name',
              label: 'Project Name',
              necessary: true,
              prefixImage: SizedBox(), // Passing an empty widget
            ),
            FormTextField(
              controller: _clientNameController,
              hintText: 'Enter Client Name',
              label: 'Client Name',
              necessary: true,
              prefixImage: SizedBox(), // Passing an empty widget
            ),
            FormTextField(
              controller: _locationController,
              hintText: 'Enter Project Location',
              label: 'Location',
              necessary: true,
              prefixImage: SizedBox(), // Passing an empty widget
            ),
            Row(
              children: [
                // Start Date
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
                          _startDateController.text =
                              pickedDate.toLocal().toString().split(' ')[0];
                        });
                      }
                    },
                    child: AbsorbPointer(
                      child: FormTextField(
                        controller: _startDateController,
                        hintText: 'Select Start Date',
                        label: 'Start Date',
                        necessary: true,
                        prefixImage: SizedBox(),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                // End Date
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
                          _endDateController.text =
                              pickedDate.toLocal().toString().split(' ')[0];
                        });
                      }
                    },
                    child: AbsorbPointer(
                      child: FormTextField(
                        controller: _endDateController,
                        hintText: 'Select End Date',
                        label: 'End Date',
                        necessary: true,
                        prefixImage: SizedBox(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text('Project Photos',
                style: TextStyle(fontWeight: FontWeight.w600)),
            ElevatedButton.icon(
              icon: Icon(Icons.upload),
              label: Text('Upload'),
              onPressed: () {},
            ),
            SizedBox(height: 16),
            Text('Work Orders', style: TextStyle(fontWeight: FontWeight.w600)),
            ...workOrders.map((order) => ListTile(
                  title: Text(order['name']),
                  subtitle: Text('Amount: Rs.${order['amount']}'),
                )),
            SizedBox(height: 8),
            ElevatedButton(
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
              child: Text('Add Work Package'),
            ),
            SizedBox(height: 16),
            FormTextField(
              controller: _retentionController,
              hintText: '% of Retention',
              label: 'Retention',
              necessary: true,
              prefixImage: SizedBox(), // Passing an empty widget
            ),
            SizedBox(height: 16),
            Center(
              child: SizedBox(
                width: MediaQuery.sizeOf(context).width *
                    0.4, // Adjust width for responsiveness
                child: PragatiButton(
                  onPressed: () {
                    // Finalize and submit project details
                    print('Project submitted with details and work orders.');
                  },
                  child: Text(
                    'Add project',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddWorkOrderPage extends StatefulWidget {
  const AddWorkOrderPage({super.key});

  @override
  State<AddWorkOrderPage> createState() => _AddWorkOrderPageState();
}

class _AddWorkOrderPageState extends State<AddWorkOrderPage> {
  final TextEditingController _packageNameController = TextEditingController();
  final TextEditingController _unitController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _rateController = TextEditingController();
  double _amount = 0.0; // Default value
  bool _isValid = true; // Validation flag

  void _calculateAmount() {
    double quantity = double.tryParse(_quantityController.text) ?? 0.0;
    double rate = double.tryParse(_rateController.text) ?? 0.0;
    setState(() {
      _amount = quantity * rate;
    });
  }

  void _saveWorkPackage() {
    // Validate required fields
    if (_packageNameController.text.isEmpty ||
        _unitController.text.isEmpty ||
        _quantityController.text.isEmpty ||
        _rateController.text.isEmpty ||
        _amount <= 0) {
      setState(() {
        _isValid = false;
      });
      return; // Exit if validation fails
    }

    // Pass back the work package data
    Navigator.pop(context, {
      'name': _packageNameController.text,
      'unit': _unitController.text,
      'quantity': _quantityController.text,
      'rate': _rateController.text,
      'amount': _amount,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Work Order'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FormTextField(
              controller: _packageNameController,
              hintText: 'Enter Package Name',
              label: 'Name of Work Package',
              necessary: true,
              prefixImage: SizedBox(), // Passing an empty widget
            ),
            FormTextField(
              controller: _unitController,
              hintText: 'Enter Unit of Measurement',
              label: 'Unit of Measurement',
              necessary: true,
              prefixImage: SizedBox(), // Passing an empty widget
            ),
            FormTextField(
              controller: _quantityController,
              hintText: 'Enter Quantity',
              label: 'Quantity',
              necessary: true,
              prefixImage: SizedBox(), // Passing an empty widget
              onChanged: (value) =>
                  _calculateAmount(), // Recalculate amount on change
            ),
            FormTextField(
              controller: _rateController,
              hintText: 'Enter Rate',
              label: 'Rate',
              necessary: true,
              prefixImage: SizedBox(), // Passing an empty widget
              onChanged: (value) =>
                  _calculateAmount(), // Recalculate amount on change
            ),
            SizedBox(height: 16),
            Text(
              'Expected Amount: Rs. $_amount',
              style:
                  TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
            ),
            if (!_isValid)
              Text(
                'Please fill all required fields correctly!',
                style: TextStyle(color: Colors.red),
              ),
            SizedBox(height: 16),
            Center(
              child: SizedBox(
                width: MediaQuery.sizeOf(context).width *
                    0.4, // Adjust width for responsiveness
                child: PragatiButton(
                  onPressed: () {
                    // Collect data and send back to Add Project
                    Navigator.pop(context, {
                      'name': _packageNameController.text,
                      'unit': _unitController.text,
                      'quantity': _quantityController.text,
                      'rate': _rateController.text,
                      'amount': _amount,
                    });
                  },
                  backgroundColor: Colors.grey,
                  child: Text(
                    'Save',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
