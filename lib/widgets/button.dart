import 'package:flutter/material.dart';
import 'package:pragati/constants/consts.dart';

class PragatiButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color backgroundColor;
  final bool outlinedButton;
  const PragatiButton(
      {super.key,
      required this.onPressed,
      required this.text,
      this.backgroundColor = primaryColor,
      this.outlinedButton = false});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.sizeOf(context).width;
    return SizedBox(
      width: double.infinity,
      height: 45,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
            elevation: WidgetStatePropertyAll(0),
            backgroundColor: outlinedButton
                ? WidgetStatePropertyAll(Colors.white)
                : WidgetStatePropertyAll(primaryColor),
            foregroundColor: WidgetStatePropertyAll(Colors.white),
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: outlinedButton
                        ? BorderSide(color: primaryColor)
                        : BorderSide(color: Colors.transparent)))),
        child: Text(
          text,
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: w * 0.025,
              color: outlinedButton ? primaryColor : Colors.white),
        ),
      ),
    );
  }
}
