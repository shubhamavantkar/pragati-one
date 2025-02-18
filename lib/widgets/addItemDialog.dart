import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pragati/constants/consts.dart';
import 'package:pragati/models/item.dart';
import 'package:pragati/models/vendorType.dart';
import 'package:pragati/widgets/button.dart';
import 'package:pragati/widgets/formDropDown.dart';
import 'package:pragati/widgets/formTextField.dart';
import 'package:pragati/widgets/itemNameDropDown.dart';
import 'package:pragati/widgets/measurementUnitDropDown.dart';
import 'package:pragati/widgets/secondaryButton.dart';

class AddItemDialog extends StatefulWidget {
  String vendorType;
  AddItemDialog({super.key, required this.vendorType});

  @override
  State<AddItemDialog> createState() => _AddItemDialogState();
}

class _AddItemDialogState extends State<AddItemDialog> {
  final TextEditingController _unitController = TextEditingController();
  final TextEditingController _itemNameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  final TextEditingController _rateController = TextEditingController();

  int _amount = 0;

  String? _itemName;

  void _calculateAmount() {
    setState(() {
      _amount =
          int.parse(_quantityController.text) * int.parse(_rateController.text);
    });
  }

  void _saveWorkPackage(BuildContext context) {
    if (_unitController.text.isNotEmpty &&
        _quantityController.text.isNotEmpty &&
        _rateController.text.isNotEmpty &&
        _itemName != null) {
      Item item = Item(
          itemName: _itemName!,
          unit: _unitController.text,
          rate: int.parse(_rateController.text),
          amount: _amount,
          quantity: int.parse(_quantityController.text));
      Navigator.pop(context, item);
    } else {
      Fluttertoast.showToast(
          msg: 'Please fill all the fields', backgroundColor: Colors.redAccent);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      backgroundColor: Colors.white,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Restricts height to content size
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Image.asset(
                        'assets/addItem.png',
                        height: 35,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Item',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Image.asset(
                        'assets/x-close.png',
                        height: 30,
                      ))
                ],
              ),
              SizedBox(
                height: 20,
              ),
              itemNameDropDown(unitController: _itemNameController),
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
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Amount:',
                      style: TextStyle(fontSize: 12),
                    ),
                    Text(
                      'Rs. $_amount',
                      style: TextStyle(fontSize: 12),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              PragatiButton(
                  onPressed: () {
                    _saveWorkPackage(context);
                  },
                  child: Text('Save')),
            ],
          ),
        ),
      ),
    );
  }
}
