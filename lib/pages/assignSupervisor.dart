import 'package:flutter/material.dart';
import 'package:pragati/constants/consts.dart';
import 'package:pragati/widgets/searchField.dart';

class AssignSupervisor extends StatelessWidget {
  const AssignSupervisor({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        backgroundColor: primaryColor,
        onPressed: () {},
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SearchField(
              hintText: 'Search Supervisor ',
            ),
            SizedBox(
              height: 150,
            ),
            Center(
              child: Image.asset(
                'assets/supervisor.png',
                height: 150,
              ),
            )
          ],
        ),
      ),
    );
    ;
  }
}
