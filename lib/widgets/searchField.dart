import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  String hintText;
  SearchField({super.key, this.hintText = ''});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: SearchBar(
        leading: Image.asset(
          'assets/search.png',
          height: 20,
        ),
        hintText: hintText,
        hintStyle: WidgetStatePropertyAll(TextStyle(
            color: Colors.grey.withValues(alpha: 0.5),
            fontSize: 14,
            fontWeight: FontWeight.w600)),
        elevation: WidgetStatePropertyAll(0),
        backgroundColor: WidgetStatePropertyAll(Colors.white),
        shape: WidgetStatePropertyAll(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(
                color: Color(0xFFD5E0F6), style: BorderStyle.solid))),
      ),
    );
  }
}
