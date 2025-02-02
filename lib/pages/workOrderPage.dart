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
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _rateController = TextEditingController();
  TextEditingController _expectedMarginController = TextEditingController();
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

    // Pass back the work package data
    Navigator.pop(context, {
      'name': _packageNameController.text,
      'unit': _unitController.text,
      'quantity': _quantityController.text,
      'rate': _rateController.text,
      'amount': _amount,
      'margin': _expectedMarginController.text,
      'profit': _expectedProfit
    });
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

            UnitSearchField(),
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

final TextEditingController _unitController = TextEditingController();

class UnitSearchField extends StatefulWidget {
  @override
  _UnitSearchFieldState createState() => _UnitSearchFieldState();
}

class _UnitSearchFieldState extends State<UnitSearchField> {
  final List<String> units = [
    // Weight
    "Kilogram (kg)", "Gram (g)", "Ton (t)",
    // Length
    "Meter (m)", "Centimeter (cm)", "Millimeter (mm)", "Kilometer (km)",
    "Inch (in)", "Foot (ft)", "Yard (yd)", "Mile (mi)",
    // Area
    "Square Meter (m²)", "Square Centimeter (cm²)", "Square Millimeter (mm²)",
    "Square Kilometer (km²)", "Acre (ac)", "Hectare (ha)", "Square Inch (in²)",
    "Square Foot (ft²)", "Square Yard (yd²)",
    // Volume
    "Liter (L)", "Milliliter (mL)", "Cubic Meter (m³)",
    "Cubic Centimeter (cm³)",
    "Cubic Millimeter (mm³)", "Cubic Foot (ft³)", "Cubic Yard (yd³)",
    // Quantity
    "Piece (pcs)", "Number (nos)", "Pack (pkt)", "Dozen (doz)", "Pair (pr)",
    // Time
    "Hour (hr)", "Minute (min)", "Second (sec)", "Day", "Week", "Month",
    "Year", "Manday",
    // Others
    "Roll", "Bundle", "Set", "Box", "Container", "Sheet"
  ];

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.sizeOf(context).width;

    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return const Iterable<String>.empty();
        }
        return units.where((unit) =>
            unit.toLowerCase().contains(textEditingValue.text.toLowerCase()));
      },
      onSelected: (String selection) {
        _unitController.text = selection;
      },
      fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
        _unitController.text = controller.text;
        return Column(
          children: [
            Row(
              children: [
                Text(
                  'Units of Measuremetn',
                  style: TextStyle(
                      fontWeight: FontWeight.w600, fontSize: w * 0.03),
                ),
                Text(
                  '*',
                  style:
                      TextStyle(fontWeight: FontWeight.w500, color: Colors.red),
                )
              ],
            ),
            SizedBox(
              height: 5,
            ),
            TextFormField(
              controller: controller,
              focusNode: focusNode,
              onFieldSubmitted: (value) => onFieldSubmitted(),
              decoration: InputDecoration(
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.grey.withOpacity(0.2)), // Lighter border
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.grey.withOpacity(0.2)), // Lighter border
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.grey
                          .withOpacity(0.4)), // Slightly darker on focus
                ),
                constraints: BoxConstraints(maxHeight: 50),
                contentPadding: EdgeInsets.all(16),
                prefixIconConstraints: BoxConstraints(maxHeight: 20),
                hintText: 'Enter Unit of Measurement',
                hintStyle: TextStyle(
                  fontSize: w * 0.03,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.withOpacity(0.5),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: Colors.grey.withOpacity(0.2), // Lighter border
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
          ],
        );
      },
    );
  }
}
