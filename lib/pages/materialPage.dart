import 'package:flutter/material.dart';
import 'package:pragati/constants/consts.dart';
import 'package:pragati/pages/issuematerial.dart';
import 'package:pragati/pages/receivedMaterial.dart';
import 'package:pragati/widgets/button.dart';
import 'package:pragati/widgets/materialStatusToggleSwitch.dart';
import 'package:pragati/widgets/searchField.dart';

class MaterialScreen extends StatefulWidget {
  const MaterialScreen({super.key});

  @override
  State<MaterialScreen> createState() => _MaterialScreenState();
}

class _MaterialScreenState extends State<MaterialScreen> {
  List<bool> _materialType = [true, false, false];
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.sizeOf(context).width;

    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            color: Colors.white,
            width: double.infinity,
            height: 70,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 44,
                    width: w * 0.28,
                    child: PragatiButton(
                      outlinedBorderColor: Colors.grey.withValues(alpha: 0.3),
                      outlinedButton: !_materialType[0],
                      borderRadius: 30,
                      onPressed: () {
                        setState(() {
                          _materialType = [true, false, false];
                        });
                      },
                      child: Text(
                        'Received',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: w * 0.033,
                            color: !_materialType[0]
                                ? Colors.black
                                : Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 44,
                    width: w * 0.25,
                    child: PragatiButton(
                      outlinedBorderColor: Colors.grey.withValues(alpha: 0.3),
                      outlinedButton: !_materialType[1],
                      borderRadius: 30,
                      onPressed: () {
                        setState(() {
                          _materialType = [false, true, false];
                        });
                      },
                      child: Text(
                        'Issue',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: w * 0.033,
                            color: !_materialType[1]
                                ? Colors.black
                                : Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 44,
                    width: w * 0.35,
                    child: PragatiButton(
                      outlinedBorderColor: Colors.grey.withValues(alpha: 0.3),
                      outlinedButton: !_materialType[2],
                      borderRadius: 30,
                      onPressed: () {
                        setState(() {
                          _materialType = [false, false, true];
                        });
                      },
                      child: Text(
                        'Recoinsilation',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: w * 0.033,
                            color: !_materialType[2]
                                ? Colors.black
                                : Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16),
              color: Colors.white,
              child: _materialType[0]
                  ? ReceivedMaterial()
                  : _materialType[1]
                      ? IssueMaterial()
                      : SizedBox(),
            ),
          ),
        ],
      ),
    );
  }
}
