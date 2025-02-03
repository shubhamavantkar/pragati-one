import 'package:flutter/material.dart';
import 'package:pragati/constants/consts.dart';
import 'package:pragati/constants/items.dart';
import 'package:pragati/models/item.dart';

class ItemCard extends StatelessWidget {
  Item item;
  ItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.sizeOf(context).width;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 85,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      itemIconsMap[item.itemName],
                      width: w * 0.15,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.itemName,
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        Row(
                          children: [
                            Text(
                              'Rate:',
                              style: TextStyle(fontSize: w * 0.033),
                            ),
                            Text(
                              '${item.rate.toString()}/${item.unit}',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: w * 0.033),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Qty: ',
                              style: TextStyle(fontSize: w * 0.03),
                            ),
                            Text(
                              '${item.quantity.toString()} ${item.unit}',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: w * 0.03),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Edit',
                      style: TextStyle(color: primaryColor, fontSize: 12),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      children: [
                        Text(
                          'Amount: ',
                          style: TextStyle(fontSize: w * 0.03),
                        ),
                        Text(
                          'Rs. ${item.amount.toString()}',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: w * 0.03),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
            Divider(
              color: Colors.grey.shade300,
              thickness: 0.8,
            )
          ],
        ),
      ),
    );
  }
}
