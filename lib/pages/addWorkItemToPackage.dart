import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pragati/constants/consts.dart';
import 'package:pragati/models/item.dart';
import 'package:pragati/models/project.dart';
import 'package:pragati/models/vendorType.dart';
import 'package:pragati/models/workPackage.dart';
import 'package:pragati/widgets/addItemDialog.dart';
import 'package:pragati/widgets/button.dart';
import 'package:pragati/widgets/formDropDown.dart';
import 'package:pragati/widgets/formTextField.dart';
import 'package:pragati/widgets/itemCard.dart';
import 'package:pragati/widgets/measurementUnitDropDown.dart';
import 'package:pragati/widgets/secondaryButton.dart';
import 'package:pragati/controllers/projectController.dart';
import 'package:pragati/controllers/tokeController.dart';

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
  String? selectedWorkOrderId; // To store the selected work order ID
  List<Item> items = [];
  List<Map<String, dynamic>> workOrders = []; // List to hold work orders

  int _totalAmount = 0;

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
        _totalAmount += newItem.amount;
      });
    }
  }

  // Function to fetch work orders for the selected project
  Future<void> _loadWorkOrders() async {
    try {
      print('Loading work orders for package: $selectedWorkPackage');
      ProjectController _projectController = ProjectController();
      final token = await getToken();
      if (token == null) {
        print('Token is null');
        Fluttertoast.showToast(msg: 'Authentication token not found');
        return;
      }

      setState(() {
        // Clear existing work orders while loading
        workOrders = [];
      });

      final workOrdersData = await _projectController.getAllWorkOrders(
          widget.project.projectId, token);

      print('Received work orders data: $workOrdersData');

      if (workOrdersData.isEmpty) {
        print('No work orders found in response');
        Fluttertoast.showToast(msg: 'No work orders found for this project');
        return;
      }

      setState(() {
        // Load all work orders
        workOrders = workOrdersData;

        print('Updated work orders state: $workOrders');

        if (workOrders.isEmpty) {
          print('No work orders found for selected package');
          Fluttertoast.showToast(
              msg: 'No work orders found for selected package');
        }
      });
    } catch (e) {
      print('Error loading work orders: $e'); // Debug print
      Fluttertoast.showToast(msg: 'Failed to load work orders: $e');
      setState(() {
        workOrders = [];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // Load work orders immediately when screen loads
    _loadWorkOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: items.isNotEmpty
          ? Container(
              height: 115,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Amount:',
                          style: TextStyle(fontSize: 12),
                        ),
                        Text(
                          'Rs. $_totalAmount',
                          style: TextStyle(fontSize: 12),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    PragatiButton(
                        onPressed: () {
                          // Print variables for debugging
                          print("Selected Work Package: $selectedWorkPackage");
                          print("Selected Work Order ID: $selectedWorkOrderId");
                          print("Items: $items");

                          if (selectedWorkPackage != null &&
                              selectedWorkOrderId != null &&
                              items.isNotEmpty) {
                            Navigator.pop(
                              context,
                              {
                                "workPackageName": selectedWorkPackage,
                                "workOrderId": selectedWorkOrderId,
                                "subCategories": items,
                              },
                            );
                          } else {
                            Fluttertoast.showToast(
                                msg:
                                    "Please select a work package and work order, and add at least one item",
                                backgroundColor: Colors.redAccent);
                          }
                        },
                        child: Text('Add to Package')),
                  ],
                ),
              ),
            )
          : SizedBox(),
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
                  // Fetch work orders immediately when screen loads
                  FormDropdown(
                    label: 'Work Order',
                    items: workOrders
                        .where((wo) =>
                            wo['name'] != null &&
                            wo['name'].toString().isNotEmpty)
                        .map((wo) => wo['name'].toString())
                        .toList(),
                    necessary: true,
                    hintText: 'Select Work Order',
                    onChanged: (orderName) {
                      if (orderName != null) {
                        setState(() {
                          try {
                            var selectedOrder = workOrders.firstWhere(
                              (wo) => wo['name'] == orderName,
                            );
                            if (selectedOrder['_id'] != null &&
                                selectedOrder['name'] != null) {
                              selectedWorkOrderId =
                                  selectedOrder['_id'].toString();
                              selectedWorkPackage =
                                  selectedOrder['name'].toString();
                            } else {
                              selectedWorkOrderId = null;
                              selectedWorkPackage = null;
                            }
                          } catch (e) {
                            // If no work order is found, reset the selection
                            selectedWorkOrderId = null;
                            selectedWorkPackage = null;
                          }
                        });
                      }
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
                    if (selectedWorkPackage != null &&
                        selectedWorkOrderId != null)
                      PragatiSecondaryButton(
                        label: 'Add Item',
                        onPressed: _showAddItemDialog,
                      )
                    else
                      Text(
                          'Please select a package and work order to continue'),
                    SizedBox(
                      height: 10,
                    ),
                    if (items.isNotEmpty)
                      Expanded(
                        child: ListView.builder(
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            return ItemCard(item: items[index]);
                          },
                        ),
                      )
                    else if (selectedWorkPackage != null)
                      Text('No items added yet'),

                    SizedBox(height: 100), // Space between list and button
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
