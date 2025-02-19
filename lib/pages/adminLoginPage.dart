import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:phonenumbers/phonenumbers.dart';

import 'package:pragati/controllers/authController.dart';
import 'package:pragati/pages/registerForm.dart';
import 'package:pragati/widgets/loadingDialog.dart';
import 'package:pragati/widgets/loginButtons.dart';
import 'package:pragati/widgets/otpButtons.dart';
import 'package:pragati/widgets/pragatiCircleAvatarLogo.dart';
import 'package:pragati/widgets/pragatiTextDivider.dart';
import 'package:pragati/models/user.dart';
import 'package:pragati/pages/dashboardScreen.dart';

class AdminLoginPage extends StatefulWidget {
  AdminLoginPage({super.key});

  @override
  State<AdminLoginPage> createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  bool _otpSent = false;

  final PhoneNumberEditingController _phoneNumberController =
      PhoneNumberEditingController(PhoneNumber.isoCode('IN', ''));
  final AuthController _authController = AuthController();

  void _handleLogin() async {
    if (_phoneNumberController.value!.formattedNumber.length < 10) {
      Fluttertoast.showToast(
          msg: 'Please enter a valid phone number',
          backgroundColor: Colors.redAccent);
      return;
    }

    // Show loading dialog
    PragatiDialogs().showLoadingDialog(context, "Sending OTP");

    final isOtpSent = await _authController.sendOtp(
        _phoneNumberController.value!.formattedNumber, 'admin');

    if (isOtpSent) {
      setState(() {
        _otpSent = true; // Enable OTP view
      });
    }

    if (context.mounted) {
      Navigator.of(context).pop(); // Close loading dialog
    }
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
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
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                PragatiCircleAvatar(size: w),
                SizedBox(height: 20),
                Text(
                  'Your Partner in Construction.',
                  style: TextStyle(
                      fontWeight: FontWeight.w600, fontSize: w * 0.05),
                ),
                SizedBox(height: 10),
                Text(
                  'Focus on Building. Leave the Management to Us.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w500, fontSize: w * 0.035),
                ),
                SizedBox(height: 40),
                PragatiTextDivider(text: 'Login or Sign up as admin'),
                SizedBox(height: 20),
                PhoneNumberField(
                  prefixBuilder: (context, country) {
                    return buildPhoneNumberPrefix(context, country);
                  },
                  controller: _phoneNumberController,
                  countryCodeWidth: w * 0.26,
                  dialogTitle: 'Select Country Code',
                  decoration: InputDecoration(
                      constraints: BoxConstraints(maxHeight: 60),
                      hintText: 'Enter your Phone Number',
                      hintStyle: TextStyle(fontSize: 14),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8))),
                ),
                SizedBox(height: 20),
                _otpSent
                    ? OTPButtons(
                        onEditPressed: () {
                          setState(() {
                            _otpSent = false;
                          });
                        },
                        phoneNumber:
                            _phoneNumberController.value!.formattedNumber,
                        onOtpEntered: (String otp) async {
                          try {
                            PragatiDialogs()
                                .showLoadingDialog(context, "Verifying OTP");

                            final isOtpVerified =
                                await _authController.verifyOtp(
                              _phoneNumberController.value!.formattedNumber,
                              otp,
                            );

                            if (context.mounted) {
                              Navigator.of(context)
                                  .pop(); // Close loading dialog
                            }

                            if (isOtpVerified) {
                              // Check if user data exists in SharedPreferences
                              final user = await User.getSavedUser();

                              if (context.mounted) {
                                if (user != null) {
                                  // User exists - navigate to Dashboard
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            DashboardScreen()),
                                  );
                                } else {
                                  // New user - navigate to Registration
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            RegisterFormPage()),
                                  );
                                }
                              }
                            } else {
                              Fluttertoast.showToast(
                                msg:
                                    "OTP verification failed. Please try again.",
                                backgroundColor: Colors.redAccent,
                              );
                            }
                          } catch (error) {
                            if (context.mounted) {
                              Navigator.of(context)
                                  .pop(); // Close loading dialog
                            }
                            Fluttertoast.showToast(
                              msg: "An error occurred: $error",
                              backgroundColor: Colors.redAccent,
                            );
                          }
                        },
                      )
                    : LoginButtons(
                        onPressed: () async {
                          _handleLogin();
                        },
                        phoneNumber: _phoneNumberController,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget? buildPhoneNumberPrefix(BuildContext context, Country? country) {
    return country != null
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.network(
              'https://flagsapi.com/${country.code}/flat/64.png',
              width: 24,
              height: 24,
            ),
          )
        : null;
  }
}
