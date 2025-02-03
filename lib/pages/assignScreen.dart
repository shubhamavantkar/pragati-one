import 'package:flutter/material.dart';
import 'package:pragati/constants/consts.dart';
import 'package:pragati/models/project.dart';
import 'package:pragati/pages/assignSupervisor.dart';
import 'package:pragati/pages/assignVendorScreen.dart';
import 'package:pragati/widgets/button.dart';

class AssignScreen extends StatefulWidget {
  Project project;
  AssignScreen({super.key, required this.project});

  @override
  State<AssignScreen> createState() => _AssignScreenState();
}

class _AssignScreenState extends State<AssignScreen> {
  bool _assignVendor = true;
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      body: Column(
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
                      width: w * 0.44,
                      child: PragatiButton(
                          outlinedBorderColor:
                              Colors.grey.withValues(alpha: 0.3),
                          outlinedButton: !_assignVendor,
                          borderRadius: 30,
                          onPressed: () {
                            setState(() {
                              _assignVendor = true;
                            });
                          },
                          child: Text(
                            'Assign Vendor',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: w * 0.033,
                                color: !_assignVendor
                                    ? Colors.black
                                    : Colors.white),
                          ))),
                  SizedBox(
                      height: 44,
                      width: w * 0.44,
                      child: PragatiButton(
                          outlinedBorderColor:
                              Colors.grey.withValues(alpha: 0.3),
                          outlinedButton: _assignVendor,
                          borderRadius: 30,
                          onPressed: () {
                            setState(() {
                              _assignVendor = false;
                            });
                          },
                          child: Text(
                            'Assign Supervisor',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: w * 0.033,
                                color: _assignVendor
                                    ? Colors.black
                                    : Colors.white),
                          ))),
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
              child: _assignVendor
                  ? AssignVendorScreen(
                      project: widget.project,
                    )
                  : AssignSupervisor(
                      project: widget.project,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
