import 'package:flutter/material.dart';
import 'package:pragati/constants/consts.dart';
import 'package:pragati/pages/addProject.dart';
import 'package:pragati/pages/dashboardScreen.dart';
import 'package:pragati/pages/projectDashboard.dart';
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
  final TextEditingController _gstNumberController =
      TextEditingController(); // New Controller
  final TextEditingController _otherWorkingTypeController =
      TextEditingController();

  // For dropdown
  String _workingType = 'civil';

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
              SizedBox(height: 20),
              Text(
                'Enter Your Details!',
                style:
                    TextStyle(fontWeight: FontWeight.w600, fontSize: w * 0.04),
              ),
              SizedBox(height: 20),
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
                items: ['civil', 'electrical', 'mechanical', 'others'],
                necessary: true,
                hintText: 'Select Working Type',
                onChanged: (value) {
                  setState(() {
                    _workingType = value!;
                  });
                },
              ),
              // Additional field for 'others'
              if (_workingType == 'others')
                FormTextField(
                  controller: _otherWorkingTypeController,
                  hintText: 'Specify Your Working Type',
                  label: 'Other Working Type',
                  necessary: true,
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
              // GST Number field
              _buildGSTField(),
              SizedBox(height: 10),
              // Skip and Continue buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: w * 0.4,
                    child: PragatiButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DashboardScreen(),
                            ));
                      },
                      outlinedButton: true,
                      child: Text(
                        'Skip',
                        style: TextStyle(
                            color: primaryColor, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
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

  Widget _buildGSTField() {
    if (_gstin) {
      return FormTextField(
        controller: _gstNumberController,
        hintText: 'Enter GST Number',
        label: 'GST Number',
        necessary: true,
      );
    }
    return SizedBox.shrink();
  }

  void _submitForm() async {
    Map<String, dynamic> userData = {
      'name': _nameController.text,
      'email': _emailController.text,
      'companyName': _companyNameController.text,
      'yearlyTurnover': int.tryParse(_turnoverController.text) ?? 0,
      'employeesCount': int.tryParse(_employeesController.text) ?? 0,
      'workingType': _workingType,
      // Add otherWorkingType only if _workingType is "others"
      if (_workingType == 'others')
        'otherWorkingType': _otherWorkingTypeController.text,
      'GSTNumber': _gstin
          ? _gstNumberController.text
          : null, // Add a default or optional value
    };

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('authToken');

      if (token != null) {
        print(userData); // Debugging output to check the userData
        await _userController.updateUser(userData);

        // Navigate to the AddProjectPage after a successful update
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddProjectPage()),
        );
      } else {
        print('No token found');
      }
    } catch (e) {
      print('Error submitting form: $e');
    }
  }
}
