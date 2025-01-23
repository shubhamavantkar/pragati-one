import 'package:flutter/material.dart';

class FormDropdown extends StatelessWidget {
  final String label;
  final bool necessary;
  final List<String> items;
  final String hintText;
  final void Function(String?) onChanged;

  const FormDropdown({
    super.key,
    required this.label,
    this.necessary = false,
    required this.items,
    required this.hintText,
    required this.onChanged,
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
        DropdownButtonFormField<String>(
          // value: selectedValue,
          isExpanded: true,
          decoration: InputDecoration(
            constraints: BoxConstraints(maxHeight: 50),
            contentPadding: EdgeInsets.all(8),
            hintText: hintText,
            hintStyle: TextStyle(
                fontSize: w * 0.01,
                fontWeight: FontWeight.w500,
                color: Colors.grey.withValues(alpha: 0.5)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: Colors.grey.withAlpha(128),
                )),
          ),
          items: items
              .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: TextStyle(fontSize: w * 0.035),
                    ),
                  ))
              .toList(),
          onChanged: onChanged,
        ),
        SizedBox(
          height: 15,
        )
      ],
    );
  }
}
