import 'package:flutter/material.dart';
import 'package:pragati/constants/consts.dart';
import 'package:pragati/widgets/button.dart';

class MaterialStatusToggleSwitch extends StatefulWidget {
  const MaterialStatusToggleSwitch({super.key});

  @override
  State<MaterialStatusToggleSwitch> createState() =>
      _MaterialStatusToggleSwitchState();
}

class _MaterialStatusToggleSwitchState
    extends State<MaterialStatusToggleSwitch> {
  bool _pending = true;
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.sizeOf(context).width;

    return Container(
      width: w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            height: 45,
            width: w * 0.45,
            child: PragatiButton(
                outlinedButton: !_pending,
                onPressed: () {
                  setState(() {
                    _pending = true;
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Pending',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: _pending ? Colors.white : primaryColor),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons.history_sharp,
                      color: _pending ? Colors.white : primaryColor,
                      size: 15,
                    ),
                  ],
                )),
          ),
          SizedBox(
            height: 45,
            width: w * 0.45,
            child: PragatiButton(
                outlinedButton: _pending,
                onPressed: () {
                  setState(() {
                    _pending = false;
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Approved',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: _pending ? primaryColor : Colors.white),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons.check_circle_outline_rounded,
                      color: _pending ? primaryColor : Colors.white,
                      size: 15,
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
