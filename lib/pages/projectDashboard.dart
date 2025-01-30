import 'package:flutter/material.dart';
import 'package:pragati/constants/consts.dart';
import 'package:pragati/widgets/cashFlowIndicator.dart';
import 'package:pragati/widgets/searchField.dart';

class ProjectDashboard extends StatelessWidget {
  const ProjectDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.sizeOf(context).width;

    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      appBar: AppBar(
        toolbarHeight: 80,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Icon(Icons.notifications_none_outlined),
          )
        ],
        title: Row(
          children: [
            const CircleAvatar(
              radius: 22,
              child: Image(image: AssetImage('assets/profile.png')),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Good Morning', style: TextStyle(fontSize: 14)),
                Text('Shubham!',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            )
          ],
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 15),
          Container(
            width: w,
            height: 170,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CashFlowIndicator(
                          label: 'RECEIVABLE',
                          amount: 1229000,
                          showCaption: true,
                          outflow: false),
                      CashFlowIndicator(
                          label: 'PAYABLE',
                          amount: 1229000,
                          showCaption: true,
                          outflow: true),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CashFlowIndicator(amount: 24357, label: 'Cash Inflow'),
                      CashFlowIndicator(
                          amount: 76543, label: 'Cash Outflow', outflow: true),
                    ],
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 15),
          Container(
            color: Colors.white,
            width: w,
            child: const Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  SearchField(),
                  SizedBox(height: 10),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
