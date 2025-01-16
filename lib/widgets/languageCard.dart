import 'package:flutter/material.dart';

class LanguageCard extends StatefulWidget {
  String imageLocation;
  String language;
  LanguageCard(
      {super.key, required this.imageLocation, required this.language});

  @override
  State<LanguageCard> createState() => _LanguageCardState();
}

class _LanguageCardState extends State<LanguageCard> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Container(
        padding: EdgeInsets.all(8),
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.withValues(alpha: 0.3))),
        child: Row(
          children: [
            Image.asset(
              widget.imageLocation,
              height: 20,
            ),
            SizedBox(
              width: 25,
            ),
            Text(
              widget.language,
              style: TextStyle(fontSize: w * 0.03, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
