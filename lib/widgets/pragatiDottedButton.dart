import 'package:flutter/material.dart';
import 'package:pragati/widgets/dottedBorder.dart';

class PragatiDottedButton extends StatefulWidget {
  final String label;
  final double? width;
  final double? height;
  final VoidCallback onTap;
  final double? labelSize;
  final Color? backgroundColor;
  final Color? labelColor;
  final IconData? icon;

  const PragatiDottedButton({
    super.key,
    required this.label,
    this.width,
    this.height = 40,
    required this.onTap,
    this.labelSize = 13,
    this.backgroundColor,
    this.labelColor,
    this.icon = Icons.add,
  });

  @override
  State<PragatiDottedButton> createState() => _PragatiDottedButtonState();
}

class _PragatiDottedButtonState extends State<PragatiDottedButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: CustomPaint(
        painter: DottedBorder(widget.labelColor!),
        child: Container(
          alignment: Alignment.center,
          width: widget.width ?? MediaQuery.of(context).size.width,
          height: widget.height,
          decoration: BoxDecoration(
            color: widget.backgroundColor,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.icon,
                color: widget.labelColor,
                size: 18.0,
              ),
              const SizedBox(width: 8.0),
              Text(
                widget.label,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: widget.labelColor,
                  fontSize: widget.labelSize,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
