import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pragati/constants/consts.dart';

class ResendButton extends StatefulWidget {
  final VoidCallback onResend; // Callback for when "Resend" is tapped
  final int timerDuration; // Timer duration in seconds (default: 60)

  const ResendButton({
    Key? key,
    required this.onResend,
    this.timerDuration = 60,
  }) : super(key: key);

  @override
  _ResendButtonState createState() => _ResendButtonState();
}

class _ResendButtonState extends State<ResendButton> {
  bool _isResendEnabled = false;
  int _remainingTime = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    setState(() {
      _isResendEnabled = false;
      _remainingTime = widget.timerDuration;
    });

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        setState(() {
          _remainingTime--;
        });
      } else {
        timer.cancel();
        setState(() {
          _isResendEnabled = true;
        });
      }
    });
  }

  void onResendTap() {
    widget.onResend();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return _isResendEnabled
        ? GestureDetector(
            onTap: onResendTap,
            child: Text(
              'Resend',
              style: TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        : Text(
            'Resend OTP in ${_remainingTime}s',
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          );
  }
}
