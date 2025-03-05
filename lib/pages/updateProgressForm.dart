import 'package:flutter/material.dart';
import 'package:pragati/constants/consts.dart';
import 'package:pragati/models/item.dart';
import 'package:pragati/pages/itemSearchPage.dart';
import 'package:pragati/widgets/button.dart';
import 'package:pragati/widgets/formDropDown.dart';
import 'package:pragati/widgets/formTextField.dart';
import 'package:pragati/widgets/pragatiDottedButton.dart';
import 'package:pragati/widgets/secondaryButton.dart';

class UpdateProgressForm extends StatefulWidget {
  const UpdateProgressForm({super.key});

  @override
  State<UpdateProgressForm> createState() => _UpdateProgressFormState();
}

class _UpdateProgressFormState extends State<UpdateProgressForm> {
  TextEditingController _dateController = TextEditingController();
  TextEditingController _vendorNameController = TextEditingController();
  TextEditingController _remarkController = TextEditingController();
  TextEditingController _quantityOfWorkDoneController = TextEditingController();

  List<Map<String, dynamic>> additionalFields = [];
  late final List<Item> items;
  void _showAddFieldDialog() {
    TextEditingController fieldController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        double w = MediaQuery.sizeOf(context).width;

        return AlertDialog(
          backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                'assets/newField.png',
                height: 40,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Image.asset(
                  'assets/x-close.png',
                  height: 25,
                ),
              )
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FormTextField(
                label: 'Field Name',
                hintText: 'Enter Field Name',
                controller: fieldController,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 40,
                    width: w * 0.29,
                    child: PragatiButton(
                      outlinedButton: true,
                      outlinedBorderColor: Colors.grey.shade300,
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                    width: w * 0.29,
                    child: PragatiButton(
                      onPressed: () {
                        setState(() {
                          additionalFields.add({
                            'label': fieldController.text,
                            'controller': TextEditingController()
                          });
                        });
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Confirm',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _showAddWorkDialog() {
    TextEditingController fieldController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        double w = MediaQuery.sizeOf(context).width;

        return AlertDialog(
          backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                'assets/Group 70.png',
                height: 40,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Image.asset(
                  'assets/x-close.png',
                  height: 25,
                ),
              )
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Add Work',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Mr. Jin Sakai',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
                  )),
              SizedBox(
                height: 20,
              ),
              FormDropdown(
                  label: 'Work Type',
                  items: [],
                  hintText: 'Select Work Type',
                  onChanged: (s) {}),
              FormTextField(
                  hintText: 'Enter Quantity',
                  label: 'Quantity of Work Done',
                  controller: _quantityOfWorkDoneController),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 40,
                child: PragatiSecondaryButton(
                    onPressed: () {
                      setState(() {
                        additionalFields.add({
                          'label': fieldController.text,
                          'controller': TextEditingController()
                        });
                      });
                      Navigator.pop(context);
                    },
                    label: 'Add to Work Done'),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickDate(TextEditingController controller) async {
    try {
      final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
      );
      if (pickedDate != null) {
        setState(() {
          controller.text = pickedDate.toLocal().toString().split(' ')[0];
        });
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error selecting date: $error')));
    }
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Update Progress',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.all(16),
              color: Colors.white,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () async {
                      await _pickDate(_dateController);
                    },
                    child: AbsorbPointer(
                      child: FormTextField(
                        suffix: Icon(
                          Icons.calendar_month,
                          color: Colors.grey.shade300,
                        ),
                        controller: _dateController,
                        hintText: 'Enter Date',
                        label: 'Date',
                        necessary: true,
                        prefixImage: const SizedBox(),
                      ),
                    ),
                  ),
                  FormDropdown(
                      necessary: true,
                      label: 'Package',
                      items: [],
                      hintText: 'Select Package',
                      onChanged: (s) {}),
                  FormTextField(
                    hintText: 'Enter Vendor Name',
                    label: 'Vendor Name',
                    controller: _vendorNameController,
                    necessary: true,
                    prefixImage: Image.asset(
                      'assets/person.png',
                      height: 18,
                    ),
                  ),
                  ...additionalFields.map((field) => FormTextField(
                        hintText: 'Enter ${field['label']}',
                        label: field['label'],
                        controller: field['controller'],
                      )),
                  Align(
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                      height: 20,
                      width: 110,
                      child: PragatiButton(
                          outlinedBorderColor: Colors.grey.shade300,
                          outlinedButton: true,
                          borderRadius: 30,
                          onPressed: _showAddFieldDialog,
                          child: Text(
                            'Add New Field',
                            style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 8,
                                fontWeight: FontWeight.w200),
                          )),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Work Done",
                        style: TextStyle(
                          fontSize: w * 0.03,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '*',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  PragatiButton(
                    onPressed: _showAddWorkDialog,
                    outlinedButton: true,
                    outlinedBorderColor: Colors.grey.shade400,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Add Work Done",
                          style: TextStyle(color: Colors.grey.shade300),
                        ),
                        Icon(
                          Icons.chevron_right_rounded,
                          color: Colors.grey.shade300,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Material Used",
                        style: TextStyle(
                          fontSize: w * 0.03,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  PragatiButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ItemSearchPage(
                              items: [],
                            ),
                          ));
                    },
                    outlinedButton: true,
                    outlinedBorderColor: Colors.grey.shade400,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Add Used Material",
                          style: TextStyle(color: Colors.grey.shade300),
                        ),
                        Icon(
                          Icons.chevron_right_rounded,
                          color: Colors.grey.shade300,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  FormTextField(
                      keyboardType: TextInputType.multiline,
                      hintText: 'Add remarks...',
                      label: 'Remark',
                      controller: _remarkController),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Attachments',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: w * 0.03)),
                  ),
                  SizedBox(height: 5),
                  PragatiDottedButton(
                    label: 'Upload',
                    onTap: () {},
                    backgroundColor: Colors.white,
                    height: 45,
                    icon: Icons.photo_library_outlined,
                    labelColor: Colors.grey,
                    labelSize: 12,
                  ),
                  SizedBox(
                    height: 80,
                  )
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: PragatiButton(onPressed: () {}, child: Text('Update')),
      ),
    );
  }
}
