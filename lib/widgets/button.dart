import 'package:flutter/material.dart';
import 'package:pragati/constants/consts.dart';

class PragatiButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final Color backgroundColor;
  final bool outlinedButton;
  final bool enabled;
  final double borderRadius;
  final outlinedBorderColor;
  const PragatiButton(
      {super.key,
      required this.onPressed,
      required this.child,
      this.backgroundColor = primaryColor,
      this.enabled = true,
      this.borderRadius = 8.0,
      this.outlinedBorderColor = primaryColor,
      this.outlinedButton = false});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.sizeOf(context).width;
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
          onPressed: enabled ? onPressed : () {},
          style: ButtonStyle(
              elevation: WidgetStatePropertyAll(0),
              backgroundColor: outlinedButton
                  ? WidgetStatePropertyAll(Colors.white)
                  : enabled
                      ? WidgetStatePropertyAll(primaryColor)
                      : WidgetStatePropertyAll(Colors.grey),
              foregroundColor: WidgetStatePropertyAll(Colors.white),
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(borderRadius),
                      side: outlinedButton
                          ? BorderSide(color: outlinedBorderColor)
                          : BorderSide(color: Colors.transparent)))),
          child: child),
    );
  }
}
