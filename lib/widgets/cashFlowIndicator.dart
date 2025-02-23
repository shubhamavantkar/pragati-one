import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CashFlowIndicator extends StatefulWidget {
  String? label;
  bool outflow;
  int amount;
  bool showCaption;
  bool showDropdown;
  CashFlowIndicator(
      {super.key,
      this.label,
      this.outflow = false,
      this.showDropdown = false,
      required this.amount,
      this.showCaption = false});

  @override
  State<CashFlowIndicator> createState() => _CashFlowIndicatorState();
}

class _CashFlowIndicatorState extends State<CashFlowIndicator> {
  final indianRupeesFormat = NumberFormat.currency(
    name: "INR",
    locale: 'en_IN',
    decimalDigits: 0, // change it to get decimal places
    symbol: 'Rs.',
  );

  String selectedValue = 'Daily';

  final List<String> items = ['Daily', 'Weekly', 'Monthly', 'Yearly'];

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.sizeOf(context).width;
    double h = MediaQuery.sizeOf(context).height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            widget.label != null
                ? Text(
                    widget.label!,
                    style: TextStyle(
                        fontSize: w * 0.03, fontWeight: FontWeight.w600),
                  )
                : SizedBox(),
            SizedBox(
              width: 40,
            ),
            widget.showDropdown
                ? SizedBox(
                    height: 15,
                    child: DropdownButton<String>(
                      value: selectedValue,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedValue = newValue!;
                        });
                      },
                      items: ['Daily', 'Weekly', 'Monthly', 'Yearly']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(fontSize: 10), // Smaller text
                          ),
                        );
                      }).toList(),
                      dropdownColor: Colors.white,
                      iconSize: 12, // Smaller icon
                      style: TextStyle(
                          fontSize: 10,
                          color: Colors.black), // Text inside dropdown
                      underline: SizedBox(), // Removes default underline
                    ),
                  )
                : SizedBox()
          ],
        ),
        SizedBox(
          height: 3,
        ),
        Container(
          height: 50,
          width: w * 0.45,
          decoration: BoxDecoration(
            color: widget.outflow ? Color(0xFFFFF1F1) : Color(0xFFEDF6EE),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                widget.outflow
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
                      indianRupeesFormat.format(widget.amount),
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    widget.showCaption
                        ? Row(
                            children: [
                              Text(
                                widget.outflow ? 'To Pay' : 'To Collect',
                                style: TextStyle(
                                    fontSize: w * 0.02,
                                    color: widget.outflow
                                        ? Color(0xFFFF5757)
                                        : Color(0xFF2E9243),
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              widget.outflow
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
