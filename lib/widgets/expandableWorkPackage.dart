import 'package:flutter/material.dart';
import 'package:pragati/models/workPackage.dart';

class ExpandableWorkPackage extends StatelessWidget {
  WorkPackage order;
  ExpandableWorkPackage({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.sizeOf(context).width;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.withValues(alpha: 0.3))),
        child: ExpansionTile(
          backgroundColor: Colors.white,
          collapsedBackgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              side: BorderSide(color: Colors.grey.withValues(alpha: 0))),
          title: Text(
            order.packageName,
            style: TextStyle(fontSize: w * 0.04),
          ),
          subtitle: Text(
            'Rs.${order.amount}',
            style: TextStyle(fontSize: w * 0.025),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Unit of Measurement',
                        style: TextStyle(fontSize: w * 0.03),
                      ),
                      Text(
                        order.measurementUnit,
                        style: TextStyle(
                            fontSize: w * 0.03, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Quantity',
                        style: TextStyle(fontSize: w * 0.03),
                      ),
                      Text(
                        order.quantity.toString(),
                        style: TextStyle(
                            fontSize: w * 0.03, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Rate',
                        style: TextStyle(fontSize: w * 0.03),
                      ),
                      Text(
                        order.rate.toString(),
                        style: TextStyle(
                            fontSize: w * 0.03, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Amount',
                        style: TextStyle(fontSize: w * 0.03),
                      ),
                      Text(
                        order.amount.toString(),
                        style: TextStyle(
                            fontSize: w * 0.03, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Expected Margin',
                        style: TextStyle(fontSize: w * 0.03),
                      ),
                      Text(
                        '${order.margin}% ${order.profit}',
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: w * 0.03,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
