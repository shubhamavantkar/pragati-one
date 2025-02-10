import 'package:flutter/material.dart';
import 'package:pragati/constants/consts.dart';
import 'package:pragati/pages/issueForm.dart';
import 'package:pragati/pages/receivedForm.dart';
import 'package:pragati/widgets/materialStatusToggleSwitch.dart';
import 'package:pragati/widgets/searchField.dart';

class IssueMaterial extends StatelessWidget {
  const IssueMaterial({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        shape: CircleBorder(),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => IssueForm(),
              ));
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: Column(
        children: [
          MaterialStatusToggleSwitch(),
          SizedBox(
            height: 10,
          ),
          SearchField(
            hintText: 'Search Vendor',
          ),
        ],
      ),
    );
  }
}
