import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pragati/constants/consts.dart';
import 'package:pragati/models/item.dart';
import 'package:pragati/models/project.dart';
import 'package:pragati/pages/addWorkItemToPackage.dart';
import 'package:pragati/widgets/button.dart';
import 'package:pragati/widgets/formDropDown.dart';
import 'package:pragati/widgets/formTextField.dart';

class AssignVendorForm extends StatefulWidget {
  final Project project;
  AssignVendorForm({super.key, required this.project});

  @override
  State<AssignVendorForm> createState() => _AssignVendorFormState();
}

class _AssignVendorFormState extends State<AssignVendorForm> {
  bool _gstin = false;
  final TextEditingController _vendorNameController = TextEditingController();
  final TextEditingController _vendorMobileNumberController =
      TextEditingController();
  final TextEditingController _vendorEmailController = TextEditingController();
  final TextEditingController _gstNumberController = TextEditingController();
  String? _vendorType;
  List<Map<String?, List<Item>>> workOrders = [];

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.sizeOf(context).width;
    double h = MediaQuery.sizeOf(context).height;

    return Scaffold(
      backgroundColor: const Color.fromARGB(232, 242, 240, 252),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Assign Vendor',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  FormTextField(
                      hintText: 'Enter Vendor Name',
                      label: 'Vendor Name',
                      necessary: true,
                      controller: _vendorNameController),
                  FormTextField(
                      keyboardType: TextInputType.phone,
                      hintText: 'Enter Mobile Number',
                      label: 'Mobile Number',
                      necessary: true,
                      controller: _vendorMobileNumberController),
                  FormTextField(
                      keyboardType: TextInputType.emailAddress,
                      hintText: 'Enter Email',
                      label: 'Email',
                      controller: _vendorEmailController),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'GSTIN',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: w * 0.03),
                      ),
                      Transform.scale(
                        scale: 0.5,
                        child: Switch(
                          value: _gstin,
                          onChanged: (value) {
                            setState(() {
                              _gstin = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  _buildGSTField(),
                  SizedBox(height: 10),
                  FormDropdown(
                      necessary: true,
                      label: 'Vendor Type',
                      items: [
                        'Material Supplier',
                        'Manpower Supply',
                        'Petty Contractor',
                        'Asset Vendor'
                      ],
                      hintText: 'Select Vendor Type',
                      onChanged: (vendor) {
                        setState(() {
                          _vendorType = vendor;
                        });
                      }),
                ],
              ),
            ),
            SizedBox(height: 15),
            Container(
              constraints: BoxConstraints(minHeight: h * 0.4),
              color: Colors.white,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Work Order",
                        style: TextStyle(
                            fontSize: w * 0.04, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        '*',
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  workOrders.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          physics: AlwaysScrollableScrollPhysics(),
                          itemCount: workOrders.length,
                          itemBuilder: (context, index) {
                            var workOrder = workOrders[index];
                            String? workOrderTitle = workOrder.keys.first;
                            List<Item> items = workOrder.values.first;
                            int totalAmount =
                                items.fold(0, (sum, item) => sum + item.amount);
                            return Card(
                              elevation: 0,
                              margin: EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 0),
                              child: ExpansionTile(
                                trailing: Text(
                                  'Rs.${totalAmount.toString()}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14),
                                ),
                                backgroundColor: Colors.white,
                                collapsedBackgroundColor: Colors.white,
                                title: Row(
                                  children: [
                                    Image.asset(
                                      'assets/package.png',
                                      height: 25,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      workOrderTitle ?? "Unknown Work Order",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                children: items.map((item) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0, horizontal: 16.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              item.itemName,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Text(
                                              "Rs.${item.amount}",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 4),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "UOM\n${item.unit}",
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.grey[700]),
                                              textAlign: TextAlign.center,
                                            ),
                                            Text(
                                              "Quantity\n${item.quantity}",
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.grey[700]),
                                              textAlign: TextAlign.center,
                                            ),
                                            Text(
                                              "Rate\n₹${item.rate}",
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.grey[700]),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                        Divider(),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                            );
                          },
                        )
                      : Center(child: Text('No work orders added yet')),
                  SizedBox(height: 5),
                  // Update the onPressed callback for adding work orders
                  PragatiButton(
                      outlinedButton: true,
                      onPressed: () async {
                        if (_vendorType != null) {
                          final items = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddWorkItemToPackage(
                                    project: widget.project,
                                    vendorType: _vendorType!),
                              ));
                          if (items != null) {
                            print(items);
                            setState(() {
                              workOrders.add(items);
                            });
                          } else {
                            print('item is null');
                          }
                        } else {
                          Fluttertoast.showToast(
                              msg: 'Please select vendor type first',
                              backgroundColor: Colors.redAccent);
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Add Work',
                            style: TextStyle(
                                fontSize: w * 0.035,
                                color: Colors.grey.shade300),
                          ),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colors.grey.shade300,
                          )
                        ],
                      )),

// Update the ListView.builder to display the work order name correctly
                  // workOrders.isNotEmpty
                  //     ? SizedBox(
                  //         height: h * 0.3,
                  //         child: ListView.builder(
                  //           shrinkWrap: true,
                  //           physics: AlwaysScrollableScrollPhysics(),
                  //           itemCount: workOrders.length,
                  //           itemBuilder: (context, index) {
                  //             String workOrderName =
                  //                 workOrders[index].keys.first ??
                  //                     'Unnamed Work Order';
                  //             return PragatiButton(
                  //                 outlinedButton: true,
                  //                 outlinedBorderColor: Colors.grey.shade300,
                  //                 onPressed: () {},
                  //                 child: Row(
                  //                   mainAxisAlignment:
                  //                       MainAxisAlignment.spaceBetween,
                  //                   children: [
                  //                     Text(
                  //                       workOrderName,
                  //                       style: TextStyle(
                  //                           fontSize: w * 0.035,
                  //                           color: Colors.grey.shade700),
                  //                     ),
                  //                     Icon(
                  //                       Icons.arrow_forward_ios_rounded,
                  //                       color: Colors.grey.shade700,
                  //                     )
                  //                   ],
                  //                 ));
                  //           },
                  //         ),
                  //       )
                  //     : Text('No work orders added yet'),

                  /// **Fix: "Add Work" Button Stays Below List**
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: workOrders.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: PragatiButton(onPressed: () {}, child: Text('Save')),
            )
          : SizedBox(),
    );
  }

  Widget _buildGSTField() {
    if (_gstin) {
      return FormTextField(
        controller: _gstNumberController,
        hintText: 'Enter GST Number',
        label: 'GST Number',
        necessary: true,
      );
    }
    return SizedBox.shrink();
  }
}
