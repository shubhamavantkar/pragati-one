import 'package:flutter/material.dart';
import 'package:pragati/constants/consts.dart';

class PragatiDialogs {
  void showLoadingDialog(BuildContext context, String text) {
    showDialog(
      context: context,
      barrierDismissible: true, // Prevent closing by tapping outside
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(24),
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                color: primaryColor,
              ),
              SizedBox(width: 50),
              Text(
                text,
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ],
          ),
        );
      },
    );
  }
}
