import 'package:flutter/material.dart';
import 'package:pragati/constants/consts.dart';
import 'package:pragati/widgets/button.dart';
import 'package:pragati/widgets/formTextField.dart';

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
        title: Text(
          'Work Order',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
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
              prefixImage: SizedBox(), // Passing an empty widget
              onChanged: (value) =>
                  _calculateAmount(), // Recalculate amount on change
            ),
            FormTextField(
              controller: _rateController,
              hintText: 'Enter Rate',
              label: 'Rate',
              prefixImage: SizedBox(), // Passing an empty widget
              onChanged: (value) =>
                  _calculateAmount(), // Recalculate amount on change
            ),
            FormTextField(
              controller: _rateController,
              hintText: 'Enter Amount',
              label: 'Amount',
              prefixImage: SizedBox(), // Passing an empty widget
              onChanged: (value) =>
                  _calculateAmount(), // Recalculate amount on change
            ),
            Text(
              'Expected Margin',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
            Container(
              height: 45,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border:
                      Border.all(color: Colors.grey.withValues(alpha: 0.5))),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  'Rs. $_amount',
                  style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.w500,
                      fontSize: 12),
                ),
              ),
            ),
            if (!_isValid)
              Text(
                'Please fill all required fields correctly!',
                style: TextStyle(color: Colors.red),
              ),
            SizedBox(height: 20),
            SizedBox(
              height: 45,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, {
                    'name': _packageNameController.text,
                    'unit': _unitController.text,
                    'quantity': _quantityController.text,
                    'rate': _rateController.text,
                    'amount': _amount,
                  });
                },
                style: ButtonStyle(
                    elevation: WidgetStatePropertyAll(0),
                    backgroundColor: WidgetStatePropertyAll(Color(0xFFF2F0FC)),
                    foregroundColor: WidgetStatePropertyAll(primaryColor),
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ))),
                child: Text(
                  'Save',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
