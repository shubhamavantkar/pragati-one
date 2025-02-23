import 'package:flutter/material.dart';
import 'package:pragati/constants/consts.dart';
import 'package:pragati/models/project.dart';
import 'package:pragati/models/vendor.dart';
import 'package:pragati/models/vendorType.dart';
import 'package:pragati/pages/assignVendorForm.dart';
import 'package:pragati/widgets/searchField.dart';
import 'package:pragati/widgets/vendorCard.dart';

class AssignVendorScreen extends StatefulWidget {
  Project project;
  AssignVendorScreen({super.key, required this.project});

  @override
  State<AssignVendorScreen> createState() => _AssignVendorScreenState();
}

class _AssignVendorScreenState extends State<AssignVendorScreen> {
  List<Vendor> vendors = []; // This will be populated with vendors

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        backgroundColor: primaryColor,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AssignVendorForm(
                  project: widget.project,
                ),
              ));
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SearchField(
              hintText: 'Search Vendor',
            ),
            // Check if there are any vendors
            vendors.isNotEmpty
                ? ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: vendors.length,
                    itemBuilder: (context, index) {
                      return VendorCard(vendor: vendors[index]);
                    },
                  )
                : Column(
                    children: [
                      SizedBox(height: 150),
                      Center(
                        child: Image.asset(
                          'assets/vendor.png',
                          height: 150,
                        ),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
