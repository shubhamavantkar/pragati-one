import 'package:flutter/material.dart';
import 'package:pragati/constants/consts.dart';
import 'package:pragati/models/item.dart';
import 'package:pragati/widgets/button.dart';
import 'package:pragati/widgets/searchField.dart';

class ItemSearchPage extends StatefulWidget {
  final List<Item> items;
  const ItemSearchPage({Key? key, required this.items}) : super(key: key);

  @override
  State<ItemSearchPage> createState() => _ItemSearchPageState();
}

class _ItemSearchPageState extends State<ItemSearchPage> {
  // This list will be updated based on search input.
  late List<Item> displayedItems;

  @override
  void initState() {
    super.initState();
    displayedItems = widget.items;
    print('Items: ${widget.items}');
    for (var item in displayedItems) {
      print(item.itemName);
      print(item.unit);
      print(item.rate);
      print(item.quantity);
      print(item.amount);
    }
  }

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
