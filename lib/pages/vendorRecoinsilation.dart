import 'package:flutter/material.dart';

class VendroRecoinsilationPage extends StatelessWidget {
  const VendroRecoinsilationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Vendor',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(
                      'assets/vendor.png',
                      height: 25,
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    Text(
                      'Vendor A',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    )
                  ],
                ),
                Text(
                  'Rs. 1,24,464',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
            Divider(
              height: 30,
              color: Colors.grey.shade300,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(
                      'assets/vendor.png',
                      height: 25,
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    Text(
                      'Vendor B',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    )
                  ],
                ),
                Text(
                  'Rs. 1,24,464',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
            Divider(
              height: 30,
              color: Colors.grey.shade300,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(
                      'assets/vendor.png',
                      height: 25,
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    Text(
                      'Vendor C',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    )
                  ],
                ),
                Text(
                  'Rs. 1,24,464',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
            Divider(
              height: 30,
              color: Colors.grey.shade300,
            ),
          ],
        ),
      ),
    );
  }
}
