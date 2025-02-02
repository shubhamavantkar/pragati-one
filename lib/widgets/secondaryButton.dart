import 'package:flutter/material.dart';
import 'package:pragati/constants/consts.dart';

class PragatiSecondaryButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  const PragatiSecondaryButton(
      {super.key, required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
            elevation: WidgetStatePropertyAll(0),
            backgroundColor: WidgetStatePropertyAll(Color(0xFFF2F0FC)),
            foregroundColor: WidgetStatePropertyAll(primaryColor),
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ))),
        child: Text(
          label,
          style: TextStyle(fontSize: 12),
        ),
      ),
    );
  }
}
