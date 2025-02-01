import 'package:flutter/material.dart';

class FormTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final Widget? prefixImage;
  final bool necessary;
  final TextEditingController controller; // Added controller
  final Function(String)? onChanged; // Add the onChanged parameter
  TextInputType keyboardType;

  FormTextField({
    super.key,
    this.keyboardType = TextInputType.text,
    required this.hintText,
    required this.label,
    this.prefixImage,
    this.necessary = false,
    required this.controller, // Added controller as a required parameter
    this.onChanged, // Initialize onChanged
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
              label,
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
          keyboardType: keyboardType,
          controller: controller, // Pass the controller here
          scrollPadding: EdgeInsets.all(16),
          onChanged: onChanged, // Pass onChanged to the TextField
          decoration: InputDecoration(
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.grey.withOpacity(0.2)), // Lighter border
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.grey.withOpacity(0.2)), // Lighter border
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color:
                      Colors.grey.withOpacity(0.4)), // Slightly darker on focus
            ),
            constraints: BoxConstraints(maxHeight: 50),
            contentPadding: EdgeInsets.all(16),
            prefixIconConstraints: BoxConstraints(maxHeight: 20),
            prefixIcon: prefixImage != null
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: prefixImage,
                  )
                : SizedBox(width: 5),
            hintText: hintText,
            hintStyle: TextStyle(
              fontSize: w * 0.03,
              fontWeight: FontWeight.w500,
              color: Colors.grey.withOpacity(0.5),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: Colors.grey.withOpacity(0.2), // Lighter border
              ),
            ),
          ),
        ),
        SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
