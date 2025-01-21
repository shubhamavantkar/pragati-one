import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pragati/constants/consts.dart';
import 'package:pragati/widgets/button.dart';
import 'package:pragati/widgets/resendButton.dart';

class OTPButtons extends StatelessWidget {
  VoidCallback onEditPressed;
  String phoneNumber;
  OTPButtons(
      {super.key, required this.phoneNumber, required this.onEditPressed});

  String _verificationCode = '';

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.sizeOf(context).width;
    return Column(
      children: [
        Text('We have sent a verification code to'),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              phoneNumber,
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            SizedBox(
              width: 30,
              height: 35,
              child: IconButton(
                onPressed: onEditPressed,
                icon: Icon(
                  Icons.edit,
                  size: 15,
                ),
                color: primaryColor,
              ),
            )
          ],
        ),
        SizedBox(
          height: 20,
        ),
        OtpTextField(
          numberOfFields: 6,
          showFieldAsBox: true,
          fieldWidth: w * 0.12,
          borderColor: Colors.grey,
          borderRadius: BorderRadius.circular(8),
          onSubmit: (String verificationCode) {
            _verificationCode = verificationCode;
          },
        ),
        SizedBox(
          height: 20,
        ),
        PragatiButton(
            onPressed: () {
              if (_verificationCode.length < 6) {
                Fluttertoast.showToast(
                    msg: 'Invalid OTP', backgroundColor: Colors.redAccent);
              }
            },
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
            ResendButton(onResend: () {})
          ],
        )
      ],
    );
  }
}
