import 'package:flutter/material.dart';
import 'package:pragati/widgets/button.dart';
import 'package:pragati/widgets/pragatiTextDivider.dart';

class LoginButtons extends StatelessWidget {
  const LoginButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.sizeOf(context).width;
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              PragatiButton(
                onPressed: () {},
                child: Text(
                  'Continue',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
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
                              height: 20,
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
                              height: 20,
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
              ),
            ],
          ),
          Text(
            'By continuing, you agree to our\nTerms of Service Privacy Policy',
            style: TextStyle(fontSize: w * 0.025, fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }
}
