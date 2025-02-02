import 'package:animated_custom_dropdown/custom_dropdown.dart';
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
        CustomDropdown<String>(
          // value: selectedValue,
          // isExpanded: true,
          // dropdownColor: Colors.white,
          decoration: CustomDropdownDecoration(
              closedBorderRadius: BorderRadius.circular(8),
              headerStyle: TextStyle(fontWeight: FontWeight.normal),
              listItemStyle: TextStyle(fontWeight: FontWeight.normal),
              hintStyle: TextStyle(
                fontSize: w * 0.035,
                fontWeight: FontWeight.w500,
                color: Colors.grey.withValues(alpha: 0.5),
              ),
              closedFillColor: Colors.white,
              closedBorder: Border.all(color: Colors.grey.shade300)),
          hintText: hintText,
          itemsListPadding: EdgeInsets.all(0),

          items: items,

          onChanged: onChanged,
        ),
        SizedBox(
          height: 15,
        )
      ],
    );
  }
}
