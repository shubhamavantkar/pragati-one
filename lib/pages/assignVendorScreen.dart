import 'package:flutter/material.dart';
import 'package:pragati/constants/consts.dart';
import 'package:pragati/controllers/vendorController.dart'; // Import VendorController
import 'package:pragati/models/project.dart';
import 'package:pragati/models/vendor.dart';
import 'package:pragati/pages/assignVendorForm.dart';
import 'package:pragati/widgets/searchField.dart';

class AssignVendorScreen extends StatelessWidget {
  Project project;
  AssignVendorScreen({super.key, required this.project});

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
                  project: project,
                ),
              ));
        },
        child: Icon(Icons.add, color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SearchField(
              hintText: 'Search Vendor',
            ),
            SizedBox(
              height: 150,
            ),
            Center(
              child: Image.asset(
                'assets/vendor.png',
                height: 150,
              ),
            )
          ],
        ),
      ),
    );
  }
}
