import 'package:flutter/material.dart';
import 'package:pragati/constants/consts.dart';
import 'package:pragati/widgets/button.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  List<bool> _accountType = [true, false, false];
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
                    width: w * 0.28,
                    child: PragatiButton(
                      outlinedBorderColor: Colors.grey.withValues(alpha: 0.3),
                      outlinedButton: !_accountType[0],
                      borderRadius: 30,
                      onPressed: () {
                        setState(() {
                          _accountType = [true, false, false];
                        });
                      },
                      child: Text(
                        'Payable',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: w * 0.033,
                            color:
                                !_accountType[0] ? Colors.black : Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 44,
                    width: w * 0.3,
                    child: PragatiButton(
                      outlinedBorderColor: Colors.grey.withValues(alpha: 0.3),
                      outlinedButton: !_accountType[1],
                      borderRadius: 30,
                      onPressed: () {
                        setState(() {
                          _accountType = [false, true, false];
                        });
                      },
                      child: Text(
                        'Accounts',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: w * 0.033,
                            color:
                                !_accountType[1] ? Colors.black : Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 44,
                    width: w * 0.3,
                    child: PragatiButton(
                      outlinedBorderColor: Colors.grey.withValues(alpha: 0.3),
                      outlinedButton: !_accountType[2],
                      borderRadius: 30,
                      onPressed: () {
                        setState(() {
                          _accountType = [false, false, true];
                        });
                      },
                      child: Text(
                        'Receivable',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: w * 0.03,
                            color:
                                !_accountType[2] ? Colors.black : Colors.white),
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
              width: double.infinity,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Cash & Bank Balance',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text('Total Amount'),
                  Text(
                    'Rs. 8,420.00',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 30),
                  ),
                  Row(
                    children: [
                      Text(
                        'See Report',
                        style: TextStyle(
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.arrow_forward,
                        size: 15,
                        color: primaryColor,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Bank/Online',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: primaryColor),
                            ),
                            Text(
                              '+ Add New Bank',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: primaryColor),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TransactionCard(
                          amount: 2324,
                          date: '22 Sept 2024',
                          mode: 'Online',
                          name: 'Prasad Patil',
                        ),
                        TransactionCard(
                          amount: 2324,
                          date: '22 Sept 2024',
                          mode: 'Online',
                          name: 'Prasad Patil',
                        ),
                        TransactionCard(
                          amount: 2324,
                          date: '22 Sept 2024',
                          mode: 'Online',
                          name: 'Prasad Patil',
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ElevatedButton(
          onPressed: () {},
          style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(primaryColor)),
          child: Text(
            'Settle Balance',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          )),
    );
  }
}

class TransactionCard extends StatelessWidget {
  String name;
  String mode;
  int amount;
  String date;
  TransactionCard({
    required this.name,
    required this.mode,
    required this.amount,
    required this.date,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                    color: primaryColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8)),
                child: Image.asset(
                  'assets/avatar.png',
                  height: 22,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    mode,
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.black.withValues(alpha: 0.3),
                        fontSize: 12),
                  )
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Rs. ${amount}',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              Text(
                date,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.black.withValues(alpha: 0.3),
                    fontSize: 12),
              )
            ],
          ),
        ],
      ),
    );
  }
}
