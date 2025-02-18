import 'package:flutter/material.dart';

class MaterialRecoinsilationPage extends StatelessWidget {
  const MaterialRecoinsilationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Material',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'assets/Cement.png',
                          height: 30,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Cement',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                    Text(
                      'Rs.13,160',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    )
                  ],
                ),
                Divider(
                  height: 20,
                  color: Colors.grey.shade200,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Received\n140',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      'Consumed\n91',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      'Balance\n47',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                Divider(
                  height: 20,
                  color: Colors.grey.shade400,
                )
              ],
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'assets/Cement.png',
                          height: 30,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Cement',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                    Text(
                      'Rs.13,160',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    )
                  ],
                ),
                Divider(
                  height: 20,
                  color: Colors.grey.shade200,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Received\n140',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      'Consumed\n91',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      'Balance\n47',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                Divider(
                  height: 20,
                  color: Colors.grey.shade400,
                )
              ],
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'assets/Cement.png',
                          height: 30,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Cement',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                    Text(
                      'Rs.13,160',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    )
                  ],
                ),
                Divider(
                  height: 20,
                  color: Colors.grey.shade200,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Received\n140',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      'Consumed\n91',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      'Balance\n47',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                Divider(
                  height: 20,
                  color: Colors.grey.shade400,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
