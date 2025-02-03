import 'package:flutter/material.dart';
import 'package:pragati/constants/consts.dart';
import 'package:pragati/models/supervisor.dart';
import 'package:pragati/widgets/button.dart';

class SupervisorCard extends StatelessWidget {
  final Supervisor supervisor;
  SupervisorCard({super.key, required this.supervisor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        padding: EdgeInsets.all(8),
        height: 130,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/supervisorFull.png',
                  height: 40,
                ),
                SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      supervisor.name,
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Text(
                      'Supervisor',
                      style: TextStyle(fontSize: 12),
                    ),
                    Text(
                      supervisor.mobileNumber,
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(width: 8),
            VerticalDivider(
              thickness: 0.7,
              width: 0.3,
              color: Colors.grey.shade300,
            ),
            SizedBox(width: 15),
            Expanded(
              // Ensures proper layout within Row
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Packages:',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
                  ),
                  SizedBox(height: 5),
                  Expanded(
                    // Ensures proper scrolling
                    child: ListView.builder(
                      shrinkWrap: true, // Prevents infinite height issue
                      physics:
                          NeverScrollableScrollPhysics(), // Prevents conflict with main scroll
                      itemCount: supervisor.workPackage.length,
                      itemBuilder: (context, index) {
                        return Text(
                          '${supervisor.workPackage[index].packageName}',
                          style: TextStyle(fontSize: 12),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: SizedBox(
                height: 25,
                width: 90,
                child: PragatiButton(
                  onPressed: () {},
                  outlinedButton: true,
                  child: Text(
                    'Add More',
                    style: TextStyle(color: primaryColor, fontSize: 8),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
