import 'package:flutter/material.dart';
import 'package:pragati/constants/consts.dart';

class PragatiCircleAvatar extends StatelessWidget {
  double size;
  PragatiCircleAvatar({
    super.key,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: size * 0.08,
          backgroundColor: Color(0xFF0265FF).withValues(alpha: 0.14),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Image.asset('assets/logo.png'),
          ),
        ),
        SizedBox(
          height: 2,
        ),
        Text(
          'Pragati',
          style: TextStyle(
              color: primaryColor,
              fontWeight: FontWeight.w600,
              fontSize: size * 0.05),
        ),
      ],
    );
  }
}
