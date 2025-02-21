import 'package:flutter/material.dart';
import 'package:pragati/constants/consts.dart';
import 'package:pragati/widgets/formDropDown.dart';
import 'package:pragati/widgets/formTextField.dart';

class UpdateProgressForm extends StatefulWidget {
  const UpdateProgressForm({super.key});

  @override
  State<UpdateProgressForm> createState() => _UpdateProgressFormState();
}

class _UpdateProgressFormState extends State<UpdateProgressForm> {
  TextEditingController _dateController = TextEditingController();

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
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Update Progress',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
      ),
      body: Column(
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
              ],
            ),
          )
        ],
      ),
    );
  }
}
