import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CashFlowIndicator extends StatelessWidget {
  String? label;
  bool outflow;
  int amount;
  bool showCaption;
  CashFlowIndicator(
      {super.key,
      this.label,
      this.outflow = false,
      required this.amount,
      this.showCaption = false});

  final indianRupeesFormat = NumberFormat.currency(
    name: "INR",
    locale: 'en_IN',
    decimalDigits: 0, // change it to get decimal places
    symbol: 'Rs.',
  );

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.sizeOf(context).width;
    double h = MediaQuery.sizeOf(context).height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label != null
            ? Text(
                label!,
                style:
                    TextStyle(fontSize: w * 0.03, fontWeight: FontWeight.w600),
              )
            : SizedBox(),
        SizedBox(
          height: 3,
        ),
        Container(
          height: 50,
          width: w * 0.45,
          decoration: BoxDecoration(
            color: outflow ? Color(0xFFFFF1F1) : Color(0xFFEDF6EE),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                outflow
                    ? Image.asset('assets/outflow.png')
                    : Image.asset('assets/inflow.png'),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      indianRupeesFormat.format(amount),
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    showCaption
                        ? Row(
                            children: [
                              Text(
                                outflow ? 'To Pay' : 'To Collect',
                                style: TextStyle(
                                    fontSize: w * 0.02,
                                    color: outflow
                                        ? Color(0xFFFF5757)
                                        : Color(0xFF2E9243),
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              outflow
                                  ? Image.asset(
                                      'assets/up.png',
                                      height: h * 0.007,
                                    )
                                  : Image.asset(
                                      'assets/down.png',
                                      height: h * 0.007,
                                    ),
                            ],
                          )
                        : SizedBox()
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
