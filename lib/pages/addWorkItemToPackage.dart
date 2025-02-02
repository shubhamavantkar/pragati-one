import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pragati/constants/consts.dart';
import 'package:pragati/models/item.dart';
import 'package:pragati/models/project.dart';
import 'package:pragati/models/vendorType.dart';
import 'package:pragati/models/workPackage.dart';
import 'package:pragati/widgets/addItemDialog.dart';
import 'package:pragati/widgets/formDropDown.dart';
import 'package:pragati/widgets/formTextField.dart';
import 'package:pragati/widgets/itemCard.dart';
import 'package:pragati/widgets/measurementUnitDropDown.dart';
import 'package:pragati/widgets/secondaryButton.dart';

class AddWorkItemToPackage extends StatefulWidget {
  Project project;
  String vendorType;
  AddWorkItemToPackage(
      {super.key, required this.project, required this.vendorType});

  @override
  State<AddWorkItemToPackage> createState() => _AddWorkItemToPackageState();
}

class _AddWorkItemToPackageState extends State<AddWorkItemToPackage> {
  String? selectedWorkPackage;

  List<Item> items = [];

  Future<void> _showAddItemDialog() async {
    final Item? newItem = await showDialog<Item>(
      context: context,
      builder: (context) {
        return AddItemDialog(vendorType: widget.vendorType);
      },
    );

    if (newItem != null) {
      setState(() {
        items.add(newItem);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      body: Container(
        child: Column(
          children: [
            Container(
              height: 150,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
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
                        'Add Items to Package',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.all(16),
              color: Colors.white,
              child: Column(
                children: [
                  FormDropdown(
                    label: 'Work Package',
                    items: widget.project.workpackages
                        .map((wp) => wp.packageName)
                        .toList(),
                    necessary: true,
                    hintText: 'Select Work Package',
                    onChanged: (package) {
                      setState(() {
                        selectedWorkPackage = package;
                      });
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                color: Colors.white,
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    items.isNotEmpty
                        ? SizedBox(
                            height:
                                items.length * 120, // Adjust height as needed
                            child: ListView.builder(
                              itemCount: items.length,
                              itemBuilder: (context, index) {
                                return ItemCard(item: items[index]);
                              },
                            ),
                          )
                        : selectedWorkPackage != null
                            ? Text('No items added yet')
                            : SizedBox(),
                    SizedBox(height: 10),
                    selectedWorkPackage != null
                        ? PragatiSecondaryButton(
                            label: 'Add Item',
                            onPressed: _showAddItemDialog,
                          )
                        : Text('Please select a package to continue'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
