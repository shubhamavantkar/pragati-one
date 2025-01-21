import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:phonenumbers/phonenumbers.dart';
import 'package:pragati/constants/consts.dart';
import 'package:pragati/widgets/button.dart';
import 'package:pragati/widgets/loginButtons.dart';
import 'package:pragati/widgets/pragatiTextDivider.dart';

class AdminLoginPage extends StatelessWidget {
  AdminLoginPage({super.key});

  final PhoneNumberEditingController _phoneNumberController =
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
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
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
                prefixBuilder: (context, country) {
                  return buildPhoneNumberPrefix(context, country);
                },
                controller: _phoneNumberController,
                countryCodeWidth: w * 0.25,
                dialogTitle: 'Select Country Code',
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8))),
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  Text('We have sent a verification code to'),
                  Text(
                      _phoneNumberController.value!.formattedNumber.toString()),
                  OtpTextField(
                    numberOfFields: 6,
                    showFieldAsBox: true,
                    fieldWidth: w * 0.12,
                    borderColor: Colors.grey,
                    borderRadius: BorderRadius.circular(8),
                    onSubmit: (String verificationCode) {},
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  PragatiButton(
                      onPressed: () {},
                      child: Text(
                        'Continue',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Did\'nt get the OTP?',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      true
                          ? GestureDetector(onTap: () {}, child: Text('Resend'))
                          : Text('Resend OTP in 60s')
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    ),
    );
  }
}

Widget? buildPhoneNumberPrefix(BuildContext context, Country? country) {
  return country != null
      ? Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.network(
            'https://flagsapi.com/${country.code}/flat/64.png',
            width: 5,
            height: 5,
          ),
        )
      : null;
}
