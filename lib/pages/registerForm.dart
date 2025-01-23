import 'package:flutter/material.dart';
import 'package:pragati/constants/consts.dart';
import 'package:pragati/widgets/button.dart';
import 'package:pragati/widgets/formDropDown.dart';
import 'package:pragati/widgets/formTextField.dart';
import 'package:pragati/widgets/pragatiCircleAvatarLogo.dart';

class RegisterFormPage extends StatefulWidget {
  RegisterFormPage({super.key});

  @override
  State<RegisterFormPage> createState() => _RegisterFormPageState();
}

class _RegisterFormPageState extends State<RegisterFormPage> {
  bool _gstin = false;

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
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              PragatiCircleAvatar(size: w),
              SizedBox(
                height: 20,
              ),
              Text(
                'Enter Your Details!',
                style:
                    TextStyle(fontWeight: FontWeight.w600, fontSize: w * 0.04),
              ),
              SizedBox(
                height: 20,
              ),
              FormTextField(
                hintText: 'Enter Your Name',
                label: 'Name',
                prefixImage: Image.asset('assets/person.png'),
                necessary: true,
              ),
              FormTextField(
                hintText: 'Enter Company Name',
                label: 'Company Name',
                prefixImage: Image.asset('assets/company.png'),
                necessary: true,
              ),
              FormTextField(
                hintText: 'Enter Email',
                label: 'Email',
                prefixImage: Image.asset('assets/mail.png'),
                necessary: true,
              ),
              FormTextField(
                hintText: 'Enter Yearly Turnover',
                label: 'Yearly Turnover',
                prefixImage: Image.asset('assets/turnover.png'),
                necessary: true,
              ),
              FormTextField(
                hintText: 'Enter Employees count',
                label: 'Employees count',
                prefixImage: Image.asset('assets/employees.png'),
                necessary: true,
              ),
              FormDropdown(
                label: 'Working type',
                items: ['hehe', 'gege'],
                necessary: true,
                hintText: 'Select Working Type',
                onChanged: (value) {},
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'GSTIN',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Transform.scale(
                    scale: 0.55,
                    child: Switch(
                      value: _gstin,
                      onChanged: (value) {
                        setState(() {
                          _gstin = !_gstin;
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: w * 0.4,
                    child: PragatiButton(
                      onPressed: () {},
                      outlinedButton: true,
                      child: Text(
                        'Skip',
                        style: TextStyle(
                            color: primaryColor, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: w * 0.4,
                    child: PragatiButton(
                      onPressed: () {},
                      child: Text(
                        'Continue',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
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
