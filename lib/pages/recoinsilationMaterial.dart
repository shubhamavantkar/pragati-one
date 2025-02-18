import 'package:flutter/material.dart';
import 'package:pragati/pages/materialRecoinsilationPage.dart';
import 'package:pragati/pages/packageRecoinsilationPage.dart';
import 'package:pragati/pages/vendorRecoinsilation.dart';

class RecoinsilationMaterial extends StatelessWidget {
  const RecoinsilationMaterial({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/stock.png',
                    height: 40,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Stock',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Total Value',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Rs. 39,87,587',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22),
              )
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/store.png',
                        height: 30,
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Text(
                        'Store',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 14),
                      ),
                    ],
                  ),
                  Text(
                    'Rs. 19,000 ',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Issued',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                  ),
                  Text(
                    'Rs. 17,000 ',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PackageRecoinsilationPage(),
                      ));
                },
                child: Row(
                  children: [
                    Image.asset(
                      'assets/package.png',
                      height: 25,
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    Text(
                      'Package',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
              Divider(
                height: 30,
                color: Colors.grey.shade300,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MaterialRecoinsilationPage(),
                      ));
                },
                child: Row(
                  children: [
                    Image.asset(
                      'assets/material.png',
                      height: 25,
                    ),
                    SizedBox(
                      width: 18,
                    ),
                    Text(
                      'Material',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
              Divider(
                height: 30,
                color: Colors.grey.shade300,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VendroRecoinsilationPage(),
                      ));
                },
                child: Row(
                  children: [
                    Image.asset(
                      'assets/vendor.png',
                      height: 25,
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Text(
                      'Vendor',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
