import 'package:flutter/material.dart';
import 'package:pragati/constants/consts.dart';
import 'package:pragati/models/vendor.dart';
import 'package:pragati/widgets/button.dart';

class VendorCard extends StatelessWidget {
  final Vendor vendor;
  VendorCard({super.key, required this.vendor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        padding: EdgeInsets.all(8),
        height: 130,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left column with vendor details
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/vendorFull.png',
                  height: 40,
                ),
                SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      vendor.vendorName,
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Text(
                      vendor.vendorType,
                      style: TextStyle(fontSize: 12),
                    ),
                    Text(
                      vendor.mobileNumber,
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(width: 8),
            VerticalDivider(
              thickness: 0.7,
              width: 0.3,
              color: Colors.grey.shade300,
            ),
            SizedBox(width: 15),
            // Right side: Work packages and total order value
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (vendor.assignedWorkPackages.isNotEmpty) ...[
                    Text(
                      'Package:', // Display "Package:" only once
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 2),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: vendor.assignedWorkPackages.length,
                      itemBuilder: (context, index) {
                        final package = vendor.assignedWorkPackages[index];
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 8, bottom: 2), // Indent names
                          child: Text(
                            '- ${package.workPackageName}', // Display only workPackageName
                            style: TextStyle(fontSize: 12),
                          ),
                        );
                      },
                    ),
                  ],
                  SizedBox(height: 5),
                  Text(
                    'Order Value: ₹${vendor.totalOrderValue}',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            // "Add More" button
            Align(
              alignment: Alignment.bottomRight,
              child: SizedBox(
                height: 25,
                width: 90,
                child: PragatiButton(
                  onPressed: () {},
                  outlinedButton: true,
                  child: Text(
                    'Add More',
                    style: TextStyle(color: primaryColor, fontSize: 8),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
