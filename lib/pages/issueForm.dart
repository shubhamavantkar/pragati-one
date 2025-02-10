import 'package:flutter/material.dart';
import 'package:pragati/constants/consts.dart';
import 'package:pragati/models/item.dart';
import 'package:pragati/pages/itemSearchPage.dart';
import 'package:pragati/widgets/button.dart';
import 'package:pragati/widgets/formDropDown.dart';
import 'package:pragati/widgets/formTextField.dart';
import 'package:pragati/widgets/itemCard.dart';
import 'package:pragati/widgets/pragatiDottedButton.dart';
import 'package:pragati/widgets/secondaryButton.dart';

class IssueForm extends StatefulWidget {
  IssueForm({super.key});

  @override
  State<IssueForm> createState() => _IssueFormState();
}

class _IssueFormState extends State<IssueForm> {
  final TextEditingController _vendorNameController = TextEditingController();

  final TextEditingController _remarkController = TextEditingController();

  int _totalAmount = 0;

  List<Item> items = [];

  final List<String> month = [
    'Jan',
    ' Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];

  bool _formValid = false;

  List<Map<String, dynamic>> additionalFields = [];

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

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.sizeOf(context).width;

    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Issued',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Indent Number #543',
                    style: TextStyle(color: primaryColor, fontSize: 12),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    '${DateTime.now().day}${month[DateTime.now().month - 1]} ${DateTime.now().year}',
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.all(16),
              color: Colors.white,
              child: Column(
                children: [
                  FormDropdown(
                      necessary: true,
                      label: 'Package',
                      items: [],
                      hintText: 'Select Package',
                      onChanged: (s) {}),
                  ...additionalFields.map((field) => FormTextField(
                        hintText: 'Enter ${field['label']}',
                        label: field['label'],
                        controller: field['controller'],
                      )),
                  FormTextField(
                      prefixImage: Image.asset(
                        'assets/person.png',
                        height: 15,
                      ),
                      necessary: true,
                      hintText: 'Add Vendor',
                      label: 'Vendor',
                      controller: _vendorNameController),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Items',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12),
                          ),
                          Text(
                            '*',
                            style: TextStyle(color: Colors.red, fontSize: 12),
                          )
                        ],
                      ),
                      SizedBox(
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
                    ],
                  ),
                  Container(
                    height: items.length * 85,
                    child: ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return ItemCard(item: items[index]);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  PragatiSecondaryButton(
                      label: 'Add Item',
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ItemSearchPage(),
                            ));
                      })
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.all(16),
              color: Colors.white,
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
                ],
              ),
            ),
            SizedBox(
              height: 120,
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: PragatiButton(
          onPressed: () {},
          child: Text('Done'),
          enabled: _formValid,
        ),
      ),
    );
  }
}
