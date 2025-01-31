import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 374,
      height: 44,
      child: SearchBar(
        leading: Image.asset(
          'assets/search.png',
          height: 20,
        ),
        hintText: 'Search Project',
        hintStyle: WidgetStatePropertyAll(TextStyle(
            color: Colors.grey.withOpacity(0.5),
            fontSize: 14,
            fontWeight: FontWeight.w600)),
        elevation: WidgetStatePropertyAll(0),
        backgroundColor: WidgetStatePropertyAll(Colors.white),
        shape: WidgetStatePropertyAll(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: const BorderSide(
                color: Color(0xFFD5E0F6), style: BorderStyle.solid))),
      ),
    );
  }
}
