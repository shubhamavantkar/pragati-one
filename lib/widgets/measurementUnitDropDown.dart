import 'package:flutter/material.dart';

class UnitSearchField extends StatefulWidget {
  final TextEditingController unitController;
  const UnitSearchField({super.key, required this.unitController});
  @override
  _UnitSearchFieldState createState() => _UnitSearchFieldState();
}

class _UnitSearchFieldState extends State<UnitSearchField> {
  final List<String> units = [
    // Weight
    "Kilogram (kg)", "Gram (g)", "Ton (t)",
    // Length
    "Meter (m)", "Centimeter (cm)", "Millimeter (mm)", "Kilometer (km)",
    "Inch (in)", "Foot (ft)", "Yard (yd)", "Mile (mi)",
    // Area
    "Square Meter (m²)", "Square Centimeter (cm²)", "Square Millimeter (mm²)",
    "Square Kilometer (km²)", "Acre (ac)", "Hectare (ha)", "Square Inch (in²)",
    "Square Foot (ft²)", "Square Yard (yd²)",
    // Volume
    "Liter (L)", "Milliliter (mL)", "Cubic Meter (m³)",
    "Cubic Centimeter (cm³)",
    "Cubic Millimeter (mm³)", "Cubic Foot (ft³)", "Cubic Yard (yd³)",
    // Quantity
    "Piece (pcs)", "Number (nos)", "Pack (pkt)", "Dozen (doz)", "Pair (pr)",
    // Time
    "Hour (hr)", "Minute (min)", "Second (sec)", "Day", "Week", "Month",
    "Year", "Manday",
    // Others
    "Roll", "Bundle", "Set", "Box", "Container", "Sheet"
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
                  'Units of Measurement',
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
                hintText: 'Enter Unit of Measurement',
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
