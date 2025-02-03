import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pragati/constants/consts.dart';
import 'package:pragati/widgets/button.dart';
import 'package:pragati/widgets/formDropDown.dart';
import 'package:pragati/widgets/formTextField.dart';

class AssignVendorForm extends StatefulWidget {
  final String projectId;
  
  AssignVendorForm({super.key, required this.projectId});

  @override
  State<AssignVendorForm> createState() => _AssignVendorFormState();
}

class _AssignVendorFormState extends State<AssignVendorForm> {
  bool _gstin = false;
  final TextEditingController _vendorNameController = TextEditingController();
  final TextEditingController _vendorMobileNumberController = TextEditingController();
  final TextEditingController _vendorEmailController = TextEditingController();
  final TextEditingController _gstNumberController = TextEditingController();

  List<dynamic> _workOrders = [];
  String? _selectedWorkOrder;

  @override
  void initState() {
    super.initState();
    _fetchWorkOrders();
  }

  Future<void> _fetchWorkOrders() async {
    final url = Uri.parse('http://api.pragatione.com/project/679d01c837b7caf40d44f232/work-orders');
    
    try {
      final response = await http.get(url);
      print(response.body);
      if (response.statusCode == 200) {
        setState(() {
          _workOrders = json.decode(response.body);
          print(_workOrders);
        });
      } else {
        print('Failed to load work orders: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching work orders: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.sizeOf(context).width;

    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Assign Vendor',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 10),
          Container(
            color: Colors.white,
            child: Padding(
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
                      necessary: true,
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
                      onChanged: (string) {})
                ],
              ),
            ),
          ),
          SizedBox(height: 15),
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Work Order",
                      style: TextStyle(fontSize: w * 0.03, fontWeight: FontWeight.w600)),
                  SizedBox(height: 5),
                  _buildWorkOrderDropdown(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWorkOrderDropdown() {
    return DropdownButtonFormField(
      value: _selectedWorkOrder,
      items: _workOrders.map<DropdownMenuItem<String>>((order) {
        return DropdownMenuItem<String>(
          value: order['_id'], 
          child: Text(order['name']), // Adjust based on API response structure
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          _selectedWorkOrder = newValue;
        });
      },
      decoration: InputDecoration(
        hintText: 'Select Work Order',
        border: OutlineInputBorder(),
      ),
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
