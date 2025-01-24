import 'package:flutter/material.dart';

class FormTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final Widget prefixImage;
  final bool necessary;
  final TextEditingController controller; // Added controller

  const FormTextField({
    super.key,
    required this.hintText,
    required this.label,
    required this.prefixImage,
    this.necessary = false,
    required this.controller, // Added controller as a required parameter
  });

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.sizeOf(context).width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label.toUpperCase(),
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: w * 0.03),
            ),
            necessary
                ? Text(
                    '*',
                    style: TextStyle(
                        fontWeight: FontWeight.w500, color: Colors.red),
                  )
                : SizedBox(),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        TextFormField(
          controller: controller, // Pass the controller here
          scrollPadding: EdgeInsets.all(16),
          decoration: InputDecoration(
            disabledBorder: OutlineInputBorder(borderSide: BorderSide()),
            constraints: BoxConstraints(maxHeight: 50),
            contentPadding: EdgeInsets.all(16),
            prefixIconConstraints: BoxConstraints(maxHeight: 20),
            prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: prefixImage),
            hintText: hintText,
            hintStyle: TextStyle(
                fontSize: w * 0.035,
                fontWeight: FontWeight.w500,
                color: Colors.grey.withValues(alpha: 0.5)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: Colors.grey.withValues(alpha: 0.5),
                )),
          ),
        ),
        SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
