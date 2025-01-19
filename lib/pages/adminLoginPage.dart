import 'package:flutter/material.dart';
import 'package:phonenumbers/phonenumbers.dart';
import 'package:pragati/constants/consts.dart';
import 'package:pragati/widgets/button.dart';

class AdminLoginPage extends StatelessWidget {
  AdminLoginPage({super.key});

  PhoneNumberEditingController _phoneNumberController =
      PhoneNumberEditingController();

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.asset(
                'assets/back.png',
              ),
            )),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: w * 0.08,
                backgroundColor: Color(0xFF0265FF).withValues(alpha: 0.14),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image.asset('assets/logo.png'),
                ),
              ),
              SizedBox(
                height: 2,
              ),
              Text(
                'Pragati',
                style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: w * 0.05),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Your Partner in Construction.',
                style:
                    TextStyle(fontWeight: FontWeight.w600, fontSize: w * 0.05),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Focus on Building. Leave the Management to Us.',
                textAlign: TextAlign.center,
                style:
                    TextStyle(fontWeight: FontWeight.w500, fontSize: w * 0.035),
              ),
              SizedBox(
                height: 40,
              ),
              PragatiTextDivider(
                text: 'Login or Sign up as admin',
              ),
              SizedBox(
                height: 20,
              ),
              PhoneNumberField(
                controller: _phoneNumberController,
                countryCodeWidth: w * 0.15,
                dialogTitle: 'Enter Your Phone Number',
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8))),
              ),
              SizedBox(
                height: 20,
              ),
              // PragatiButton(onPressed: () {}, text: 'Continue'),
              SizedBox(
                height: 15,
              ),
              PragatiTextDivider(
                text: 'or',
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: w * 0.4,
                    height: w * 0.12,
                    child: ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                            elevation: WidgetStatePropertyAll(0),
                            backgroundColor:
                                WidgetStatePropertyAll(Colors.white),
                            foregroundColor:
                                WidgetStatePropertyAll(Colors.black),
                            shape:
                                WidgetStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        side: BorderSide(color: Colors.grey)))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/google.png',
                              height: 25,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Google',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            )
                          ],
                        )),
                  ),
                  SizedBox(
                    width: w * 0.4,
                    height: w * 0.12,
                    child: ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                            elevation: WidgetStatePropertyAll(0),
                            backgroundColor:
                                WidgetStatePropertyAll(Colors.white),
                            foregroundColor:
                                WidgetStatePropertyAll(Colors.black),
                            shape:
                                WidgetStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        side: BorderSide(color: Colors.grey)))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/apple.png',
                              height: 25,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Apple',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            )
                          ],
                        )),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class PragatiTextDivider extends StatelessWidget {
  String text;
  PragatiTextDivider({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Text(
            text,
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        Expanded(
          child: Divider(),
        ),
      ],
    );
  }
}
