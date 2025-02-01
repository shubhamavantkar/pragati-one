import 'package:flutter/material.dart';
import 'dart:math';

class SemiRadialGraph extends StatelessWidget {
  final double value; // Value in percentage (0-100)
  final String label;

  const SemiRadialGraph({super.key, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.sizeOf(context).width;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(children: [
          CustomPaint(
            size: Size(w * 0.12, 40), // Width and height
            painter: SemiCirclePainter(value / 100), // Convert to 0-1 range
          ),
          Positioned(
            top: 26,
            left: 15,
            child: Text(
              '${value.toStringAsFixed(0)}%', // Display percentage
              style: const TextStyle(
                fontSize: 10,
              ),
            ),
          ),
        ]),
        Text(label, style: const TextStyle(fontSize: 10, color: Colors.black)),
      ],
    );
  }
}

class SemiCirclePainter extends CustomPainter {
  final double progress; // Value between 0 and 1

  SemiCirclePainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint backgroundPaint = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFFF53C3C), Color(0xFFF5AB3C)],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.square;

    final Paint progressPaint = Paint()
      ..color = Color(0xFF695CFF)
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.square;

    final center = Offset(size.width / 2, size.height);
    final radius = size.width / 2;

    // Draw background arc
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      pi, // Start from left
      pi, // Sweep to right
      false,
      backgroundPaint,
    );

    // Draw progress arc
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      pi, // Start from left
      pi * progress, // Sweep based on value
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
