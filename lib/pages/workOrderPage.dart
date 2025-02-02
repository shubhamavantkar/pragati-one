import 'package:flutter/material.dart';
import 'package:pragati/constants/consts.dart';
import 'package:pragati/models/workPackage.dart';
import 'package:pragati/widgets/button.dart';
import 'package:pragati/widgets/formTextField.dart';
import 'package:pragati/widgets/measurementUnitDropDown.dart';

class AddWorkOrderPage extends StatefulWidget {
  const AddWorkOrderPage({super.key});

  @override
  State<AddWorkOrderPage> createState() => _AddWorkOrderPageState();
}

class _AddWorkOrderPageState extends State<AddWorkOrderPage> {
  final TextEditingController _packageNameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _rateController = TextEditingController();
  TextEditingController _expectedMarginController = TextEditingController();

  final TextEditingController _unitController = TextEditingController();
  double _amount = 0.0; // Default value
  double _expectedProfit = 0.0;
  bool _isValid = true; // Validation flag

  void _calculateAmount() {
    double quantity = double.tryParse(_quantityController.text) ?? 0.0;
    double rate = double.tryParse(_rateController.text) ?? 0.0;

    setState(() {
      _amount = quantity * rate;
    });
  }

  void _calculateMargin() {
    int margin = int.tryParse(_expectedMarginController.text) ?? 0;

    if (margin > 100) {
      _expectedMarginController.text = '100';
      margin = 100;
    }
    setState(() {
      _expectedProfit = _amount * (margin / 100);
    });
  }

  void _saveWorkPackage() {
    // Validate required fields
    if (_packageNameController.text.isEmpty ||
        _unitController.text.isEmpty ||
        _quantityController.text.isEmpty ||
        _rateController.text.isEmpty ||
        _expectedMarginController.text.isEmpty ||
        _amount <= 0) {
      setState(() {
        _isValid = false;
      });
      return; // Exit if validation fails
    }
    WorkPackage workPackage = WorkPackage(
      packageName: _packageNameController.text,
      measurementUnit: _unitController.text,
      quantity: int.parse(_quantityController.text),
      rate: int.parse(_rateController.text),
      margin: int.parse(_expectedMarginController.text),
      amount: _amount.toInt(),
      profit: _expectedProfit.toInt(),
    );
    // Pass back the work package data
    Navigator.pop(context, workPackage);
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
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
              necessary: true,
              prefixImage: SizedBox(), // Passing an empty widget
            ),
            // FormTextField(
            //   keyboardType: TextInputType.numberWithOptions(),
            //   controller: _unitController,
            //   hintText: 'Enter Unit of Measurement',
            //   label: 'Unit of Measurement',
            //   necessary: true,
            //   prefixImage: SizedBox(), // Passing an empty widget
            // ),

            UnitSearchField(
              unitController: _unitController,
            ),
            FormTextField(
              keyboardType: TextInputType.numberWithOptions(),
              controller: _quantityController,
              hintText: 'Enter Quantity',
              label: 'Quantity',
              prefixImage: SizedBox(), // Passing an empty widget
              necessary: true,
              onChanged: (value) =>
                  _calculateAmount(), // Recalculate amount on change
            ),
            FormTextField(
              keyboardType: TextInputType.numberWithOptions(),
              controller: _rateController,
              hintText: 'Enter Rate',
              label: 'Rate',
              necessary: true,
              prefixImage: SizedBox(), // Passing an empty widget
              onChanged: (value) =>
                  _calculateAmount(), // Recalculate amount on change
            ),
            FormTextField(
              suffix: Icon(
                Icons.percent,
                color: Colors.grey.shade300,
                size: 20,
              ),
              keyboardType: TextInputType.numberWithOptions(),
              controller: _expectedMarginController,
              hintText: 'Enter Expected Margin',
              label: 'Expected Margin',
              necessary: true,
              prefixImage: SizedBox(), // Passing an empty widget
              onChanged: (value) =>
                  _calculateMargin(), // Recalculate amount on change
            ),
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
                  'Rs. $_expectedProfit',
                  style: TextStyle(fontSize: 10),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            if (!_isValid)
              Text(
                'Please fill all required fields correctly!',
                style: TextStyle(color: Colors.red, fontSize: 12),
              ),
            SizedBox(height: 10),
            SizedBox(
              height: 45,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  _saveWorkPackage();
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
