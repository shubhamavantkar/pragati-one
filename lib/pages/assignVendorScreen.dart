import 'package:flutter/material.dart';
import 'package:pragati/constants/consts.dart';
import 'package:pragati/controllers/vendorController.dart'; // Import VendorController
import 'package:pragati/models/project.dart';
import 'package:pragati/models/vendor.dart';
import 'package:pragati/pages/assignVendorForm.dart';
import 'package:pragati/widgets/searchField.dart';
import 'package:pragati/widgets/vendorCard.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AssignVendorScreen extends StatefulWidget {
  final Project project;

  AssignVendorScreen({super.key, required this.project});

  @override
  State<AssignVendorScreen> createState() => _AssignVendorScreenState();
}

class _AssignVendorScreenState extends State<AssignVendorScreen> {
  List<Vendor> vendors = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchVendors();
  }

  Future<void> fetchVendors() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('authToken');
      List<Vendor>? vendor = await VendorController.fetchVendorData(
          widget.project.projectId, token!);
      print(vendor);
      if (vendor != null) {
        setState(() {
          vendors = vendor; // Assign the fetched vendors directly
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error fetching vendors: $e');
      setState(() {
        isLoading = false;
      });
    }
    print(vendors);
  }

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
              builder: (context) => AssignVendorForm(project: widget.project),
            ),
          );
        },
        child: Icon(Icons.add, color: Colors.white),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator()) // Show loading indicator
          : SingleChildScrollView(
              child: Column(
                children: [
                  SearchField(hintText: 'Search Vendor'),
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
                              child:
                                  Image.asset('assets/vendor.png', height: 150),
                            ),
                          ],
                        ),
                ],
              ),
            ),
    );
  }
}
