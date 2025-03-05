import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pragati/constants/consts.dart';
import 'package:pragati/controllers/accounts.controller.dart';
import 'package:pragati/models/project.dart';
import 'package:pragati/pages/materialRecoinsilationPage.dart';
import 'package:pragati/pages/packageRecoinsilationPage.dart';
import 'package:pragati/pages/vendorRecoinsilation.dart';
import 'package:pragati/widgets/button.dart';
import 'package:pragati/widgets/formDropDown.dart';
import 'package:pragati/widgets/formTextField.dart';

class AccountScreen extends StatefulWidget {
  final Project project;
  const AccountScreen({super.key, required this.project});

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
          _accountType[1]
              ? Expanded(child: AccountsAccount(project: widget.project))
              : _accountType[0]
                  ? Expanded(child: PayableAccount())
                  : Expanded(child: ReceivableAccount())
        ],
      ),
    );
  }
}

class ReceivableAccount extends StatelessWidget {
  const ReceivableAccount({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ElevatedButton(
          onPressed: () {},
          style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(primaryColor)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () {
                  print('Create Bill');
                },
                child: Text(
                  'Create Invoice',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600),
                ),
              ),
              Text(
                '  |  ',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
              ),
              GestureDetector(
                onTap: () {
                  print('Payment Out');
                },
                child: Text(
                  'Payment In',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          )),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          color: Colors.white,
          width: double.infinity,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/inflow.png',
                          height: 40,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Receivable',
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 18),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Total Receivable',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Rs. 39,87,587',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 22),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PackageRecoinsilationPage(),
                            ));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                'assets/package.png',
                                height: 25,
                              ),
                              SizedBox(
                                width: 25,
                              ),
                              Text(
                                'Package 1',
                                style: TextStyle(fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                          Text(
                            'Rs. 12,23,000',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    ),
                    Divider(
                      height: 30,
                      color: Colors.grey.shade300,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                'assets/package.png',
                                height: 25,
                              ),
                              SizedBox(
                                width: 25,
                              ),
                              Text(
                                'Package 2',
                                style: TextStyle(fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                          Text(
                            'Rs. 12,23,000',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    ),
                    Divider(
                      height: 30,
                      color: Colors.grey.shade300,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                'assets/package.png',
                                height: 25,
                              ),
                              SizedBox(
                                width: 25,
                              ),
                              Text(
                                'Package 3',
                                style: TextStyle(fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                          Text(
                            'Rs. 12,23,000',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    ),
                    Divider(
                      height: 30,
                      color: Colors.grey.shade300,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                'assets/package.png',
                                height: 25,
                              ),
                              SizedBox(
                                width: 25,
                              ),
                              Text(
                                'Package 4',
                                style: TextStyle(fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                          Text(
                            'Rs. 12,23,000',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class PayableAccount extends StatelessWidget {
  const PayableAccount({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ElevatedButton(
          onPressed: () {},
          style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(primaryColor)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () {
                  print('Create Bill');
                },
                child: Text(
                  'Create Bill',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600),
                ),
              ),
              Text(
                '  |  ',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
              ),
              GestureDetector(
                onTap: () {
                  print('Payment Out');
                },
                child: Text(
                  'Payment Out',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          )),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          color: Colors.white,
          width: double.infinity,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/outflow.png',
                          height: 40,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Payable',
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 18),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Total Payable',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Rs. 39,87,587',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 22),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PackageRecoinsilationPage(),
                            ));
                      },
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/layers.png',
                            height: 30,
                          ),
                          SizedBox(
                            width: 25,
                          ),
                          Text(
                            'Material Supplier',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                    Divider(
                      height: 30,
                      color: Colors.grey.shade300,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  MaterialRecoinsilationPage(),
                            ));
                      },
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/material.png',
                            height: 25,
                          ),
                          SizedBox(
                            width: 18,
                          ),
                          Text(
                            'Manpower Supplier',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                    Divider(
                      height: 30,
                      color: Colors.grey.shade300,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VendroRecoinsilationPage(),
                            ));
                      },
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/vendorFull.png',
                            height: 25,
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Text(
                            'Petty Contractor',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                    Divider(
                      height: 30,
                      color: Colors.grey.shade300,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VendroRecoinsilationPage(),
                            ));
                      },
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/store.png',
                            height: 25,
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Text(
                            'Asset Supplier',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class AccountsAccount extends StatefulWidget {
  final Project project;
  const AccountsAccount({super.key, required this.project});
  @override
  _AccountsAccountState createState() => _AccountsAccountState();
}

class _AccountsAccountState extends State<AccountsAccount> {
  final AccountsApiService apiService = AccountsApiService();
  List<Map<String, dynamic>> accounts = [];
  bool isLoading = true;

  // Declare these as state variables:
  String? depositId;
  String? withdrawalId;
  String? addMoneyAccId;

  // Controllers for date, amount, remarks, etc.
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _remarkController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchAccounts();
  }

  Future<void> fetchAccounts() async {
    try {
      String projectId = widget.project.projectId;
      List<Map<String, dynamic>> data =
          await apiService.getAllAccounts(projectId);

      setState(() {
        accounts = data;
        isLoading = false;
      });
    } catch (e) {
      print("Error fetching accounts: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  String _formatDate(String dateStr) {
    try {
      final date = DateTime.parse(dateStr);
      // Format as "DD MMM YYYY"
      final day = date.day.toString().padLeft(2, '0');
      final month = _monthName(date.month);
      final year = date.year.toString();
      return '$day $month $year';
    } catch (e) {
      return dateStr; // Fallback in case of parsing error
    }
  }

  String _monthName(int month) {
    const months = [
      '',
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return months[month];
  }

  double _calculateTotalAmount() {
    double total = 0;
    for (var account in accounts) {
      total += (account['totalAmount'] as num?)?.toDouble() ?? 0;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ElevatedButton(
          onPressed: () {
            showModalBottomSheet(
              backgroundColor: Colors.white,
              context: context,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              builder: (context) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Settle Balance',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      Divider(),
                      ListTile(
                        leading: Image.asset(
                          'assets/transferMoney.png',
                          height: 25,
                        ),
                        trailing: Icon(
                          Icons.arrow_forward,
                          color: primaryColor,
                        ),
                        title: Text(
                          'Transfer Money',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        onTap: () {
                          Navigator.pop(
                              context); // Close the first modal before opening the next one
                          showModalBottomSheet(
                            backgroundColor: Colors.white,
                            context: context,
                            isScrollControlled: true,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(16)),
                            ),
                            builder: (context) {
                              TextEditingController _dateController =
                                  TextEditingController();

                              TextEditingController _amountController =
                                  TextEditingController();

                              TextEditingController _remarkController =
                                  TextEditingController();

                              Future<void> _pickDate() async {
                                final DateTime? pickedDate =
                                    await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2100),
                                );
                                if (pickedDate != null) {
                                  _dateController.text = pickedDate
                                      .toLocal()
                                      .toString()
                                      .split(' ')[0];
                                }
                              }

                              return StatefulBuilder(
                                builder: (context, setState) {
                                  return Padding(
                                    padding: EdgeInsets.all(16),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          'Transfer Money',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Divider(),
                                        FormDropdown(
                                          label: 'Deposit to',
                                          items: accounts
                                              .map((account) =>
                                                  account['name'] as String)
                                              .toList(),
                                          hintText: 'Deposit to',
                                          onChanged: (selectedAccount) {
                                            final account = accounts.firstWhere(
                                                (acc) =>
                                                    acc['name'] ==
                                                    selectedAccount,
                                                orElse: () => {});
                                            depositId = account['_id'];
                                            // Optionally, you can create JSON data here for debugging:
                                            final jsonData = {
                                              'selectedAccountId': depositId,
                                            };
                                            print(
                                                "Deposit: ${jsonEncode(jsonData)}");
                                          },
                                        ),
                                        FormDropdown(
                                          label: 'Withdraw',
                                          items: accounts
                                              .map((account) =>
                                                  account['name'] as String)
                                              .toList(),
                                          hintText: 'Withdraw',
                                          onChanged: (selectedAccount) {
                                            final account = accounts.firstWhere(
                                                (acc) =>
                                                    acc['name'] ==
                                                    selectedAccount,
                                                orElse: () => {});
                                            withdrawalId = account['_id'];
                                            final jsonData = {
                                              'selectedAccountId': withdrawalId,
                                            };
                                            print(
                                                "Withdraw: ${jsonEncode(jsonData)}");
                                          },
                                        ),
                                        GestureDetector(
                                          onTap: () async {
                                            await _pickDate();
                                            setState(
                                                () {}); // Refresh the modal sheet UI
                                          },
                                          child: AbsorbPointer(
                                            child: FormTextField(
                                              suffix: Icon(
                                                Icons.calendar_month,
                                                color: Colors.grey.shade300,
                                              ),
                                              controller: _dateController,
                                              hintText: 'Start Date',
                                              label: 'Start Date',
                                              prefixImage: const SizedBox(),
                                            ),
                                          ),
                                        ),
                                        FormTextField(
                                            hintText: 'Enter Amount',
                                            label: 'Amount',
                                            controller: _amountController),
                                        FormTextField(
                                            keyboardType:
                                                TextInputType.multiline,
                                            hintText: 'Add remarks...',
                                            label: 'Remark',
                                            controller: _remarkController),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'New Amount',
                                              style: TextStyle(fontSize: 12),
                                            ),
                                            Text(
                                              'Rs. 1,74,350',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        PragatiButton(
                                          onPressed: () async {
                                            // Check if any required field is null or empty
                                            if (depositId == null ||
                                                withdrawalId == null ||
                                                _dateController.text.isEmpty ||
                                                _amountController
                                                    .text.isEmpty) {
                                              print(
                                                  "Please fill in all fields.");
                                              // Optionally, show a message to the user
                                              return;
                                            }

                                            // Prepare transfer data and call the API, for example:
                                            final transferData = {
                                              "date": _dateController.text,
                                              "amount": double.tryParse(
                                                      _amountController.text) ??
                                                  0,
                                              "remarks": _remarkController.text,
                                            };

                                            print(
                                                "Transfer Data: ${jsonEncode(transferData)}");
                                            // API call here...
                                            try {
                                              final result =
                                                  await AccountsApiService()
                                                      .transferMoney(
                                                withdrawalId!, // sender account ID
                                                depositId!, // receiver account ID
                                                transferData,
                                              );
                                              print(
                                                  "Transfer successful: $result");
                                              // Show a green SnackBar for success
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                      "Transfer successful"),
                                                  backgroundColor: Colors.green,
                                                ),
                                              );
                                              Navigator.pop(
                                                  context); // Close the modal on success
                                            } catch (e) {
                                              print("Transfer failed: $e");
                                              String errorMessage =
                                                  e.toString();
                                              if (errorMessage.contains(
                                                  "Insufficient balance")) {
                                                errorMessage =
                                                    "Insufficient balance";
                                              }
                                              // Show the error message without closing the modal
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(errorMessage),
                                                  backgroundColor: Colors.red,
                                                ),
                                              );
                                            }
                                          },
                                          child: const Text('Transfer'),
                                        )
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        },
                      ),
                      ListTile(
                        leading: Image.asset(
                          'assets/add-reduce.png',
                          height: 25,
                        ),
                        trailing: Icon(
                          Icons.arrow_forward,
                          color: primaryColor,
                        ),
                        title: Text(
                          'Add/Reduce Money',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        onTap: () {
                          Navigator.pop(context); // Close the first modal
                          showModalBottomSheet(
                            backgroundColor: Colors.white,
                            context: context,
                            isScrollControlled: true,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(16)),
                            ),
                            builder: (context) {
                              TextEditingController _dateController =
                                  TextEditingController();
                              TextEditingController _amountController =
                                  TextEditingController();
                              TextEditingController _remarkController =
                                  TextEditingController();
                              String _selectedOption =
                                  'Add Money'; // Default option

                              Future<void> _pickDate() async {
                                final DateTime? pickedDate =
                                    await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2100),
                                );
                                if (pickedDate != null) {
                                  _dateController.text = pickedDate
                                      .toLocal()
                                      .toString()
                                      .split(' ')[0];
                                }
                              }

                              return StatefulBuilder(
                                builder: (context, setState) {
                                  return Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Form(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Text(
                                            'Add/Reduce Money',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          const Divider(),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              ElevatedButton.icon(
                                                icon: Image.asset(
                                                    'assets/add-reduce.png',
                                                    height: 20),
                                                label: const Text('Add Money'),
                                                onPressed: () {
                                                  setState(() {
                                                    _selectedOption =
                                                        'Add Money';
                                                  });
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  elevation: 0,
                                                  backgroundColor:
                                                      _selectedOption ==
                                                              'Add Money'
                                                          ? primaryColor
                                                              .withAlpha(20)
                                                          : Colors.white,
                                                  shape: RoundedRectangleBorder(
                                                    side: BorderSide(
                                                      color: primaryColor,
                                                      width: 0.5,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                ),
                                              ),
                                              ElevatedButton.icon(
                                                icon: Image.asset(
                                                    'assets/add-reduce.png',
                                                    height: 20),
                                                label:
                                                    const Text('Reduce Money'),
                                                onPressed: () {
                                                  setState(() {
                                                    _selectedOption =
                                                        'Reduce Money';
                                                  });
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  elevation: 0,
                                                  backgroundColor:
                                                      _selectedOption ==
                                                              'Reduce Money'
                                                          ? primaryColor
                                                              .withAlpha(20)
                                                          : Colors.white,
                                                  shape: RoundedRectangleBorder(
                                                    side: BorderSide(
                                                      color: primaryColor,
                                                      width: 0.5,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 10),
                                          GestureDetector(
                                            onTap: () async {
                                              await _pickDate();
                                              setState(() {}); // Refresh UI
                                            },
                                            child: AbsorbPointer(
                                              child: FormTextField(
                                                suffix: Icon(
                                                  Icons.calendar_month,
                                                  color: Colors.grey.shade300,
                                                ),
                                                controller: _dateController,
                                                hintText: 'Date',
                                                label: 'Date',
                                                prefixImage: const SizedBox(),
                                              ),
                                            ),
                                          ),
                                          FormDropdown(
                                            label: 'Account',
                                            items: accounts
                                                .map((account) =>
                                                    account['name'] as String)
                                                .toList(),
                                            hintText: 'Select Account',
                                            onChanged: (selectedAccount) {
                                              final account =
                                                  accounts.firstWhere(
                                                (acc) =>
                                                    acc['name'] ==
                                                    selectedAccount,
                                                orElse: () => {},
                                              );
                                              addMoneyAccId = account['_id'];
                                              print(
                                                  "Selected Account ID: $addMoneyAccId");
                                            },
                                          ),
                                          FormTextField(
                                            controller: _amountController,
                                            hintText: 'Enter Amount',
                                            label: 'Amount*',
                                            prefixImage: const SizedBox(),
                                            keyboardType: TextInputType.number,
                                          ),
                                          FormTextField(
                                            controller: _remarkController,
                                            hintText: 'Add Remarks...',
                                            label: 'Remarks',
                                            prefixImage: const SizedBox(),
                                            keyboardType:
                                                TextInputType.multiline,
                                          ),
                                          const SizedBox(height: 10),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: const [
                                              Text(
                                                'New Amount',
                                                style: TextStyle(fontSize: 12),
                                              ),
                                              Text(
                                                'Rs. 1,74,350',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 5),
                                          PragatiButton(
                                            onPressed: () async {
                                              // Validate required fields
                                              if (addMoneyAccId == null ||
                                                  _dateController
                                                      .text.isEmpty ||
                                                  _amountController
                                                      .text.isEmpty) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                    content: Text(
                                                        "Please fill in all required fields."),
                                                    backgroundColor: Colors.red,
                                                  ),
                                                );
                                                return;
                                              }

                                              // Prepare request data common to both add and reduce actions.
                                              final Map<String, dynamic>
                                                  requestBody = {
                                                "date": _dateController
                                                    .text, // ideally in ISO8601 format
                                                "amount": double.tryParse(
                                                        _amountController
                                                            .text) ??
                                                    0,
                                                // "remarks" field is used only for add money API in our example.
                                                "remarks":
                                                    _remarkController.text,
                                              };

                                              // Check toggle and call the appropriate API
                                              if (_selectedOption ==
                                                  'Add Money') {
                                                try {
                                                  final result =
                                                      await AccountsApiService()
                                                          .addMoneyToAccount(
                                                              addMoneyAccId!,
                                                              requestBody);
                                                  print(
                                                      "Add money successful: $result");
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    const SnackBar(
                                                      content: Text(
                                                          "Money added successfully."),
                                                      backgroundColor:
                                                          Colors.green,
                                                    ),
                                                  );
                                                  Navigator.pop(
                                                      context); // Close the modal on success
                                                } catch (e) {
                                                  print("Add money failed: $e");
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content:
                                                          Text("Error: $e"),
                                                      backgroundColor:
                                                          Colors.red,
                                                    ),
                                                  );
                                                }
                                              } else if (_selectedOption ==
                                                  'Reduce Money') {
                                                // For reducing money, we assume remarks may not be needed.
                                                // Remove "remarks" if your API doesn't expect it.
                                                final Map<String, dynamic>
                                                    reduceRequestBody = {
                                                  "date": _dateController.text,
                                                  "amount":
                                                      _amountController.text,
                                                  // "remarks" field is used only for add money API in our example.
                                                  "remarks":
                                                      _remarkController.text,
                                                };

                                                try {
                                                  final result =
                                                      await AccountsApiService()
                                                          .reduceMoneyFromAccount(
                                                              addMoneyAccId!,
                                                              reduceRequestBody);
                                                  print(
                                                      "Reduce money successful: $result");
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    const SnackBar(
                                                      content: Text(
                                                          "Money reduced successfully."),
                                                      backgroundColor:
                                                          Colors.green,
                                                    ),
                                                  );
                                                  Navigator.pop(
                                                      context); // Close the modal on success
                                                } catch (e) {
                                                  print(
                                                      "Reduce money failed: $e");
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content:
                                                          Text("Error: $e"),
                                                      backgroundColor:
                                                          Colors.red,
                                                    ),
                                                  );
                                                }
                                              }
                                            },
                                            child: const Text(
                                              'Save',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          },
          style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(primaryColor)),
          child: Text(
            'Settle Balance',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          )),
      body: SingleChildScrollView(
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
              TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0, end: _calculateTotalAmount()),
                duration: Duration(seconds: 2), // Adjust duration as needed
                builder: (context, value, child) {
                  return Text(
                    'Rs. ${value.toStringAsFixed(2)}',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 30),
                  );
                },
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
                              fontWeight: FontWeight.w700, color: primaryColor),
                        ),
                        Text(
                          '+ Add New Bank',
                          style: TextStyle(
                              fontWeight: FontWeight.w400, color: primaryColor),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: accounts.length,
                      itemBuilder: (context, index) {
                        final account = accounts[index];
                        return TransactionCard(
                          name: account['name'] ?? 'Unnamed',
                          mode: account['accountType'] ?? '',
                          amount: account['totalAmount'] ?? 0,
                          date: _formatDate(account['createdAt'] ?? ''),
                        );
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
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
