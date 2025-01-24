import 'package:flutter/material.dart';
import 'package:pragati/constants/consts.dart';
import 'package:pragati/widgets/button.dart';
import 'package:pragati/widgets/formDropDown.dart';
import 'package:pragati/widgets/formTextField.dart';
import 'package:pragati/widgets/pragatiCircleAvatarLogo.dart';
import 'package:pragati/controllers/userController.dart'; // Import your UserController
import 'package:shared_preferences/shared_preferences.dart';

class RegisterFormPage extends StatefulWidget {
  RegisterFormPage({super.key});

  @override
  State<RegisterFormPage> createState() => _RegisterFormPageState();
}

class _RegisterFormPageState extends State<RegisterFormPage> {
  bool _gstin = false;

  // Add controllers for the form fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _turnoverController = TextEditingController();
  final TextEditingController _employeesController = TextEditingController();
  
  // For dropdown
  String _workingType = 'hehe'; // You can update this with proper options

  final UserController _userController = UserController();

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
              // Name field
              FormTextField(
                controller: _nameController,
                hintText: 'Enter Your Name',
                label: 'Name',
                prefixImage: Image.asset('assets/person.png'),
                necessary: true,
              ),
              // Company Name field
              FormTextField(
                controller: _companyNameController,
                hintText: 'Enter Company Name',
                label: 'Company Name',
                prefixImage: Image.asset('assets/company.png'),
                necessary: true,
              ),
              // Email field
              FormTextField(
                controller: _emailController,
                hintText: 'Enter Email',
                label: 'Email',
                prefixImage: Image.asset('assets/mail.png'),
                necessary: true,
              ),
              // Yearly Turnover field
              FormTextField(
                controller: _turnoverController,
                hintText: 'Enter Yearly Turnover',
                label: 'Yearly Turnover',
                prefixImage: Image.asset('assets/turnover.png'),
                necessary: true,
              ),
              // Employees Count field
              FormTextField(
                controller: _employeesController,
                hintText: 'Enter Employees count',
                label: 'Employees count',
                prefixImage: Image.asset('assets/employees.png'),
                necessary: true,
              ),
              // Working type dropdown
              FormDropdown(
                label: 'Working type',
                items: ['civil', 'electrical','mechanical','others'],
                necessary: true,
                hintText: 'Select Working Type',
                onChanged: (value) {
                  setState(() {
                    _workingType = value!;
                  });
                },
              ),
              // GSTIN switch
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
                          _gstin = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              // Skip and Continue buttons
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
                      onPressed: _submitForm,
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

  // Handle form submission
  void _submitForm() async {
    // Collect user data
    Map<String, dynamic> userData = {
      'name': _nameController.text,
      'company_name': _companyNameController.text,
      'email': _emailController.text,
      'yearly_turnover': _turnoverController.text,
      'employees_count': _employeesController.text,
      'working_type': _workingType,
      'gstin': _gstin,
    };

    // Call the UserController to update the user
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('authToken');
      
      if (token != null) {
        await _userController.updateUser(userData);
      } else {
        print('No token found');
      }
    } catch (e) {
      print('Error submitting form: $e');
    }
  }
}
