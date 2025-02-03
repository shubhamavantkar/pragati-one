import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pragati/models/project.dart';
import 'package:pragati/models/supervisor.dart';
import 'package:pragati/widgets/button.dart';
import 'package:pragati/widgets/formDropDown.dart';
import 'package:pragati/widgets/formTextField.dart';

class AssignSupervisorForm extends StatefulWidget {
  Project project;
  AssignSupervisorForm({super.key, required this.project});

  @override
  State<AssignSupervisorForm> createState() => _AssignSupervisorFormState();
}

class _AssignSupervisorFormState extends State<AssignSupervisorForm> {
  final TextEditingController _supervisorNameController =
      TextEditingController();

  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _salaryController = TextEditingController();

  String? selectedWorkPackage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(232, 242, 240, 252),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Assign Supervisor',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(16.0),
        child: PragatiButton(
            onPressed: () {
              if (_supervisorNameController.text.isNotEmpty &&
                  _mobileNumberController.text.isNotEmpty &&
                  selectedWorkPackage != null) {
                Supervisor supervisor = Supervisor(
                    name: _supervisorNameController.text,
                    mobileNumber: _mobileNumberController.text,
                    workPackage: [],
                    monthlySalary: int.parse(_salaryController.text));
                supervisor.workPackage.add(
                  widget.project.workpackages.firstWhere(
                    (element) => element.packageName == selectedWorkPackage,
                  ),
                );

                Navigator.pop(context, supervisor);
              } else {
                Fluttertoast.showToast(
                    msg: 'Please enter all details',
                    backgroundColor: Colors.redAccent);
              }
            },
            child: Text('Assign')),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16),
              color: Colors.white,
              child: Column(
                children: [
                  FormTextField(
                      hintText: 'Enter Name',
                      necessary: true,
                      label: 'Supervisor Name',
                      controller: _supervisorNameController),
                  FormTextField(
                      keyboardType: TextInputType.numberWithOptions(),
                      hintText: 'Enter Mobile Number',
                      necessary: true,
                      label: 'Mobile Number',
                      controller: _mobileNumberController),
                  FormDropdown(
                    label: 'Work Package',
                    items: widget.project.workpackages
                        .map((wp) => wp.packageName)
                        .toList(),
                    necessary: true,
                    hintText: 'Select Work Package',
                    onChanged: (package) {
                      setState(() {
                        selectedWorkPackage = package;
                      });
                    },
                  ),
                  FormTextField(
                      keyboardType: TextInputType.numberWithOptions(),
                      hintText: 'Enter Amount',
                      label: 'Salary (monthly)',
                      controller: _salaryController)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
