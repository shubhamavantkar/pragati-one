import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:pragati/widgets/button.dart';

class OTPButtons extends StatefulWidget {
  String phoneNumber;
  OTPButtons({super.key, required this.phoneNumber});

  @override
  State<OTPButtons> createState() => _OTPButtonsState();
}

class _OTPButtonsState extends State<OTPButtons> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.sizeOf(context).width;
    return Column(
      children: [
        Text('We have sent a verification code to'),
        Text(widget.phoneNumber),
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
    );
  }
}
