import 'package:flutter/material.dart';

class itemNameDropDown extends StatefulWidget {
  final TextEditingController unitController;
  const itemNameDropDown({super.key, required this.unitController});
  @override
  _itemNameDropDownState createState() => _itemNameDropDownState();
}

class _itemNameDropDownState extends State<itemNameDropDown> {
  final List<String> units = [
    // Weight
    "Cement", "Brick", "Sand"
  ];

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.sizeOf(context).width;

    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return const Iterable<String>.empty();
        }
        return units.where((unit) =>
            unit.toLowerCase().contains(textEditingValue.text.toLowerCase()));
      },
      onSelected: (String selection) {
        widget.unitController.text = selection;
      },
      fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
        widget.unitController.text = controller.text;
        return Column(
          children: [
            Row(
              children: [
                Text(
                  'Item Name',
                  style: TextStyle(
                      fontWeight: FontWeight.w600, fontSize: w * 0.03),
                ),
                Text(
                  '*',
                  style:
                      TextStyle(fontWeight: FontWeight.w500, color: Colors.red),
                )
              ],
            ),
            SizedBox(
              height: 5,
            ),
            TextFormField(
              controller: controller,
              focusNode: focusNode,
              onFieldSubmitted: (value) => onFieldSubmitted(),
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
                      color: Colors.grey
                          .withOpacity(0.4)), // Slightly darker on focus
                ),
                constraints: BoxConstraints(maxHeight: 50),
                contentPadding: EdgeInsets.all(16),
                prefixIconConstraints: BoxConstraints(maxHeight: 20),
                hintText: 'Enter Item Name',
                hintStyle: TextStyle(
                  fontSize: w * 0.035,
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
      },
    );
  }
}
