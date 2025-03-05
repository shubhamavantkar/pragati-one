import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pragati/constants/consts.dart';
import 'package:pragati/controllers/materialController.dart'
    as materialController;
import 'package:pragati/models/item.dart';
import 'package:pragati/models/project.dart';
import 'package:pragati/pages/itemSearchPage.dart';
import 'package:pragati/widgets/button.dart';
import 'package:pragati/widgets/formDropDown.dart';
import 'package:pragati/widgets/formTextField.dart';
import 'package:pragati/widgets/itemCard.dart';
import 'package:pragati/widgets/pragatiDottedButton.dart';
import 'package:pragati/widgets/secondaryButton.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReceivedForm extends StatefulWidget {
  final Project project;
  ReceivedForm({super.key, required this.project});

  @override
  State<ReceivedForm> createState() => _ReceivedFormState();
}

class _ReceivedFormState extends State<ReceivedForm> {
  final TextEditingController _vendorNameController = TextEditingController();
  final TextEditingController _remarkController = TextEditingController();

  int _totalAmount = 0;
  List<Item> items = [];
  final List<String> month = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];

  bool _formValid = false;
  List<Map<String, dynamic>> additionalFields = [];

  // List to hold the vendor data fetched from the new API call.
  // Each vendor has a vendorName, mobileNumber, and nested workPackages.
  List<Map<String, dynamic>> _vendors = [];
  // List of work packages for the currently selected vendor.
  List<Map<String, dynamic>> _workPackages = [];

  Map<String, dynamic>? _selectedVendor;
  String? _selectedPackage;

  @override
  void initState() {
    super.initState();
    _fetchVendors();
  }

  // New API call to fetch vendor data (assuming the API returns a List)
  Future<void> _fetchVendors() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('authToken');

      // Here, the API returns a List<Map<String, dynamic>>
      final jsonResponse = await materialController.getMaterialsByProjectId(
          widget.project.projectId, token!);

      if (jsonResponse is List) {
        // Update the vendors list
        setState(() {
          _vendors =
              jsonResponse.map((e) => e as Map<String, dynamic>).toList();
        });

        // Initialize items using a function that accepts a list.
        _initializeItemsFromApiDataFromList(jsonResponse);
      }
    } catch (e) {
      print('Error fetching vendors: $e');
    }
  }

  void _initializeItemsFromApiDataFromList(List<dynamic> jsonList) {
    List<Item> fetchedItems = [];
    for (var vendor in jsonList) {
      List<dynamic> workPackages = vendor['workPackages'] ?? [];
      for (var wp in workPackages) {
        List<dynamic> subCategories = wp['subCategories'] ?? [];
        for (var sub in subCategories) {
          final item = Item(
            itemName: sub['name'],
            unit: sub['unitOfMeasurement'],
            quantity: sub['quantity'],
            rate: sub['rate'],
            amount: sub['amount'],
          );
          fetchedItems.add(item);
        }
      }
    }
    print(fetchedItems);
    setState(() {
      items = fetchedItems;
      _totalAmount = items.fold(0, (sum, item) => sum + item.amount);
    });
  }

  // Filter vendors based on typed vendor name (case-insensitive)
  List<Map<String, dynamic>> _getVendorSuggestions(String query) {
    return _vendors.where((vendor) {
      final name = vendor['vendorName']?.toString().toLowerCase() ?? '';
      return name.contains(query.toLowerCase());
    }).toList();
  }

  // Called when a vendor is selected from suggestions.
  void _onVendorSelected(Map<String, dynamic> vendor) {
    setState(() {
      _selectedVendor = vendor;
      _vendorNameController.text = vendor['vendorName'];
      // Update work packages dropdown list from selected vendor.
      _workPackages =
          List<Map<String, dynamic>>.from(vendor['workPackages'] ?? []);
      _selectedPackage = null;
    });
  }

  // UI: vendor autocomplete suggestion overlay.
  Widget _buildVendorAutoComplete() {
    return Column(
      children: _getVendorSuggestions(_vendorNameController.text).map((vendor) {
        return ListTile(
          title: Text(vendor['vendorName']),
          subtitle: Text('Mobile: ${vendor['mobileNumber']}'),
          onTap: () {
            _onVendorSelected(vendor);
          },
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.sizeOf(context).width;

    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Received',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10),
            // Purchase Order Section (static for demo)
            Container(
              padding: EdgeInsets.all(16),
              height: 100,
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Purchase Order #543',
                          style: TextStyle(color: primaryColor, fontSize: 12)),
                      SizedBox(height: 5),
                      Text('Original Invoice # -',
                          style: TextStyle(fontSize: 12)),
                      SizedBox(height: 5),
                      Text(
                          '${DateTime.now().day}${month[DateTime.now().month - 1]} ${DateTime.now().year}',
                          style: TextStyle(fontSize: 12)),
                    ],
                  ),
                  Text('Edit',
                      style: TextStyle(
                          color: primaryColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w500))
                ],
              ),
            ),
            SizedBox(height: 10),
            // Form Section
            Container(
              padding: EdgeInsets.all(16),
              color: Colors.white,
              child: Column(
                children: [
                  // Vendor Text Field with Autocomplete
                  FormTextField(
                    prefixImage: Image.asset('assets/person.png', height: 15),
                    necessary: true,
                    hintText: 'Add Vendor',
                    label: 'Vendor',
                    controller: _vendorNameController,
                    onChanged: (value) {
                      // Reset selected vendor if text changes.
                      setState(() {
                        _selectedVendor = null;
                        _workPackages = [];
                        _selectedPackage = null;
                      });
                    },
                  ),
                  // Show suggestions if user has typed text and no vendor is selected
                  if (_vendorNameController.text.isNotEmpty &&
                      _selectedVendor == null)
                    _buildVendorAutoComplete(),
                  // Package Dropdown – only populated if vendor is selected
                  if (_workPackages.isNotEmpty)
                    FormDropdown(
                      necessary: true,
                      label: 'Package',
                      items: _workPackages
                          .map((wp) => wp['workPackageName'] as String)
                          .toList(),
                      hintText: 'Select Package',
                      onChanged: (value) {
                        setState(() {
                          _selectedPackage = value;
                        });
                      },
                    ),
                  // Additional Fields, Items list, etc. (remains the same)
                  ...additionalFields.map((field) => FormTextField(
                        hintText: 'Enter ${field['label']}',
                        label: field['label'],
                        controller: field['controller'],
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text('Items',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12)),
                          Text('*',
                              style:
                                  TextStyle(color: Colors.red, fontSize: 12)),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                        width: 110,
                        child: PragatiButton(
                          outlinedBorderColor: Colors.grey.shade300,
                          outlinedButton: true,
                          borderRadius: 30,
                          onPressed: () {
                            _showAddFieldDialog();
                          },
                          child: Text(
                            'Add New Field',
                            style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 8,
                                fontWeight: FontWeight.w200),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Container(
                  //   height: items.length * 85,
                  //   child: ListView.builder(
                  //     itemCount: items.length,
                  //     itemBuilder: (context, index) {
                  //       return ItemCard(item: items[index]);
                  //     },
                  //   ),
                  // ),

                  SizedBox(height: 20),
                  PragatiSecondaryButton(
                    label: 'Add Item',
                    onPressed: () async {
                      // Pass the current list of items to the search page.
                      final selectedItem = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ItemSearchPage(items: items),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
            SizedBox(height: 10),
            // Remarks & Attachments Section
            Container(
              padding: EdgeInsets.all(16),
              color: Colors.white,
              child: Column(
                children: [
                  FormTextField(
                    keyboardType: TextInputType.multiline,
                    hintText: 'Add remarks...',
                    label: 'Remark',
                    controller: _remarkController,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Attachments',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: w * 0.03,
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  PragatiDottedButton(
                    label: 'Upload',
                    onTap: () {},
                    backgroundColor: Colors.white,
                    height: 45,
                    icon: Icons.photo_library_outlined,
                    labelColor: Colors.grey,
                    labelSize: 12,
                  ),
                ],
              ),
            ),
            SizedBox(height: 120),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        height: 110,
        color: Colors.white,
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Amount:',
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
                ),
                Text(
                  'Rs. $_totalAmount',
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
                )
              ],
            ),
            SizedBox(height: 10),
            PragatiButton(
              onPressed: () {
                // Add your submit logic here.
              },
              child: Text('Submit'),
              enabled: _formValid,
            )
          ],
        ),
      ),
    );
  }

  void _showAddFieldDialog() {
    TextEditingController fieldController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        double w = MediaQuery.sizeOf(context).width;
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset('assets/newField.png', height: 40),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Image.asset('assets/x-close.png', height: 25),
              )
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FormTextField(
                label: 'Field Name',
                hintText: 'Enter Field Name',
                controller: fieldController,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 40,
                    width: w * 0.29,
                    child: PragatiButton(
                      outlinedButton: true,
                      outlinedBorderColor: Colors.grey.shade300,
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                    width: w * 0.29,
                    child: PragatiButton(
                      onPressed: () {
                        setState(() {
                          additionalFields.add({
                            'label': fieldController.text,
                            'controller': TextEditingController()
                          });
                        });
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Confirm',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
