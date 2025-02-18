import 'package:flutter/material.dart';

class PackageRecoinsilationPage extends StatelessWidget {
  const PackageRecoinsilationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Package',
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
                      'assets/package.png',
                      height: 25,
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    Text(
                      'Building A',
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
                      'assets/package.png',
                      height: 25,
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    Text(
                      'Building B',
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
                      'assets/package.png',
                      height: 25,
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    Text(
                      'Building C',
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
