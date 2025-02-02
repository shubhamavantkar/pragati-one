import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pragati/constants/consts.dart';
import 'package:pragati/models/project.dart';
import 'package:pragati/models/vendorType.dart';
import 'package:pragati/models/workPackage.dart';
import 'package:pragati/widgets/formDropDown.dart';
import 'package:pragati/widgets/formTextField.dart';
import 'package:pragati/widgets/measurementUnitDropDown.dart';

class AddWorkItemToPackage extends StatelessWidget {
  Project project;
  String vendorType;
  AddWorkItemToPackage(
      {super.key, required this.project, required this.vendorType});

  final TextEditingController _unitController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _rateController = TextEditingController();
  TextEditingController _amountController = TextEditingController();

  void _calculateAmount() {
    _amountController.text =
        'Rs. ${int.parse(_quantityController.text) * int.parse(_rateController.text)}';
  }

  void _saveWorkPackage(BuildContext context) {
    if (_unitController.text.isNotEmpty &&
        _quantityController.text.isNotEmpty &&
        _rateController.text.isNotEmpty) {
      Navigator.pop(context);
    } else {
      Fluttertoast.showToast(
          msg: 'Please fill all the fields', backgroundColor: Colors.redAccent);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      child: Container(
        padding: EdgeInsets.all(16),
        height: 550,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/Group 70.png',
                    height: 50,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Image.asset(
                      'assets/x-close.png',
                      height: 25,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Add Work/Items to Package',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              FormDropdown(
                label: 'Work Package',
                items:
                    project.workpackages.map((wp) => wp.packageName).toList(),
                necessary: true,
                hintText: 'Select Work Package',
                onChanged: (s) {},
              ),
              FormDropdown(
                  label: 'Item Name',
                  items: VendorType().vendorType[vendorType],
                  hintText: 'Select Item/Work',
                  onChanged: (s) {}),
              UnitSearchField(unitController: _unitController),
              FormTextField(
                  hintText: 'Enter Quantity',
                  label: 'Quantity',
                  keyboardType: TextInputType.numberWithOptions(),
                  onChanged: (qty) {
                    _calculateAmount();
                  },
                  controller: _quantityController),
              FormTextField(
                  hintText: 'Enter Rate',
                  label: 'Rate',
                  keyboardType: TextInputType.numberWithOptions(),
                  onChanged: (p0) {
                    _calculateAmount();
                  },
                  controller: _rateController),
              FormTextField(
                  hintText: 'Amount',
                  label: 'Amount',
                  controller: _amountController),
              SizedBox(
                height: 45,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    _saveWorkPackage(context);
                  },
                  style: ButtonStyle(
                      elevation: WidgetStatePropertyAll(0),
                      backgroundColor:
                          WidgetStatePropertyAll(Color(0xFFF2F0FC)),
                      foregroundColor: WidgetStatePropertyAll(primaryColor),
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ))),
                  child: Text(
                    'Save',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
