import 'package:flutter/material.dart';

class DottedBorder extends CustomPainter {
  final Color color;

  DottedBorder(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.0
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round;

    const double radius = .8; //only for dot

    final path = Path();

    // Dotted borders
    // Bordure supérieure
    for (double x = 0; x < size.width; x += 5.0) {
      canvas.drawCircle(Offset(x, 0), radius, paint);
    }

    // Bordure droite
    for (double y = 0; y < size.height; y += 5.0) {
      canvas.drawCircle(Offset(size.width, y), radius, paint);
    }

    // Bordure inférieure
    for (double x = size.width; x >= 0; x -= 5.0) {
      canvas.drawCircle(Offset(x, size.height), radius, paint);
    }

    // Bordure gauche
    for (double y = size.height; y >= 0; y -= 5.0) {
      canvas.drawCircle(Offset(0, y), radius, paint);
    }

    // Dashed Borders

    // // Dessiner la bordure supérieure
    //     path.moveTo(0, 0);
    //     for (double x = 0; x < size.width; x += 10.0) {
    //       path.moveTo(x, 0);
    //       path.lineTo(x + 5, 0);
    //     }

    //     // Dessiner la bordure droite
    //     path.moveTo(size.width, 0);
    //     for (double y = 0; y < size.height; y += 10.0) {
    //       path.moveTo(size.width, y);
    //       path.lineTo(size.width, y + 5);
    //     }

    //     // Dessiner la bordure inférieure
    //     path.moveTo(size.width, size.height);
    //     for (double x = size.width; x >= 0; x -= 10.0) {
    //       path.moveTo(x, size.height);
    //       path.lineTo(x - 5, size.height);
    //     }

    //     // Dessiner la bordure gauche
    //     path.moveTo(0, size.height);
    //     for (double y = size.height; y >= 0; y -= 10.0) {
    //       path.moveTo(0, y);
    //       path.lineTo(0, y - 5);
    //     }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
