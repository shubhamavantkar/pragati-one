import 'package:flutter/material.dart';
import 'package:pragati/widgets/button.dart';
import 'package:pragati/widgets/formTextField.dart';

class WorkOrderPage extends StatelessWidget {
  const WorkOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          FormTextField(
              hintText: 'Enter Package Name',
              label: "Name of Work Package",
              prefixImage: Image.asset('name')),
          SizedBox(
            height: 10,
          ),
          FormTextField(
              hintText: 'Enter Units of Measurement',
              label: "Units of Measurement",
              prefixImage: Image.asset('name')),
          SizedBox(
            height: 10,
          ),
          FormTextField(
              hintText: 'Enter Quantity',
              label: "Quantity",
              prefixImage: Image.asset('name')),
          SizedBox(
            height: 10,
          ),
          FormTextField(
              hintText: 'Enter Rate',
              label: "Rate",
              prefixImage: Image.asset('name')),
          SizedBox(
            height: 10,
          ),
          FormTextField(
              hintText: 'Enter Amount',
              label: "Amount",
              prefixImage: Image.asset('name')),
          SizedBox(
            height: 10,
          ),
          Text('Expected Margin'),
          TextField(),
          PragatiButton(onPressed: () {}, child: Text('Save'))
        ],
      ),
    );
  }
}
