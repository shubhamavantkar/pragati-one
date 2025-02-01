import 'package:flutter/material.dart';
import 'package:pragati/constants/consts.dart';
import 'package:pragati/widgets/button.dart';
import 'package:pragati/widgets/formDropDown.dart';
import 'package:pragati/widgets/formTextField.dart';

class AssignVendorForm extends StatefulWidget {
  AssignVendorForm({super.key});

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
          SizedBox(
            height: 10,
          ),
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
                  // GST Number field
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
          SizedBox(
            height: 15,
          ),
          Container(
            color: Colors.white,
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Work Order",
                          style: TextStyle(
                              fontSize: w * 0.03, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          '*',
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    PragatiButton(
                        outlinedButton: true,
                        outlinedBorderColor: Colors.grey.shade300,
                        onPressed: () {},
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
                  ],
                )),
          )
        ],
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
