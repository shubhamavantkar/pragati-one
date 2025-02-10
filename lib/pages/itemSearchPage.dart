import 'package:flutter/material.dart';
import 'package:pragati/constants/consts.dart';
import 'package:pragati/widgets/button.dart';
import 'package:pragati/widgets/searchField.dart';

class ItemSearchPage extends StatefulWidget {
  const ItemSearchPage({super.key});

  @override
  State<ItemSearchPage> createState() => _ItemSearchPageState();
}

class _ItemSearchPageState extends State<ItemSearchPage> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.sizeOf(context).width;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 140,
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Column(
          children: [
            SizedBox(
              height: 40,
              child: SearchField(
                borderRadius: 30,
                hintText: 'Search item',
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              color: Colors.grey.shade300,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                height: 20,
                width: 110,
                child: PragatiButton(
                    outlinedBorderColor: Colors.grey.shade300,
                    outlinedButton: true,
                    borderRadius: 30,
                    onPressed: () {},
                    child: Text(
                      'Add New Item',
                      style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 8,
                          fontWeight: FontWeight.w200),
                    )),
              ),
            ),
            Divider(
              color: Colors.grey.shade300,
            ),
          ],
        ),
      ),
      backgroundColor: scaffoldBackgroundColor,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
        width: w,
        height: 60,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                blurRadius: 1, spreadRadius: 2, color: Colors.grey.shade100)
          ],
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  '0 Items added',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Icon(
                  Icons.arrow_circle_right_rounded,
                  color: primaryColor,
                  size: 12,
                )
              ],
            ),
            Row(
              children: [
                Text(
                  'Continue',
                  style: TextStyle(
                      color: primaryColor, fontWeight: FontWeight.w600),
                ),
                Icon(
                  Icons.arrow_right,
                  color: primaryColor,
                  size: 20,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
