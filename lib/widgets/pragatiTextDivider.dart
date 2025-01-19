import 'package:flutter/material.dart';

class PragatiTextDivider extends StatelessWidget {
  String text;
  PragatiTextDivider({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.sizeOf(context).width;
    return Row(
      children: [
        Expanded(
          child: Divider(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Text(
            text,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: w * 0.03),
          ),
        ),
        Expanded(
          child: Divider(),
        ),
      ],
    );
  }
}
