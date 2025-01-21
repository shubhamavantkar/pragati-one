import 'package:flutter/material.dart';
import 'package:pragati/constants/consts.dart';
import 'package:pragati/pages/adminLoginPage.dart';
import 'package:pragati/widgets/button.dart';
import 'package:pragati/widgets/languagesModalSheet.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  barrierColor: Colors.transparent,
                  backgroundColor: Colors.transparent,
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                  builder: (BuildContext context) {
                    return LanguageModalSheet();
                  },
                );
              },
              child: Image.asset(
                'assets/languages.png',
                height: 25,
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 16),
        child: Column(
          children: [
            Image.asset(
              'assets/ConstructionSiteVector.png',
              height: 303,
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/logo.png',
                        height: 39,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Pragati',
                        style: TextStyle(
                            color: primaryColor,
                            fontSize: w * 0.055,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Your All-in-One Construction Management Solution!',
                    style: TextStyle(
                        fontSize: w * 0.045,
                        fontWeight: FontWeight.w700,
                        height: 1.4),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Manage projects, track materials, handle vendors, and streamline workflows with ease. Pragati empowers contractors to focus on building while we simplify the rest”',
                    style: TextStyle(
                      fontSize: w * 0.035,
                      height: 1.4,
                      color: Colors.grey,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  PragatiButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AdminLoginPage(),
                          ));
                    },
                    child: Text(
                      'Owner',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  PragatiButton(
                    onPressed: () {},
                    outlinedButton: true,
                    child: Text(
                      'Supervisor',
                      style: TextStyle(
                          color: primaryColor, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
