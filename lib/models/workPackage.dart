class WorkPackage {
  String packageName;
  String measurementUnit;
  int quantity;
  int rate;
  int margin;
  int amount;
  int profit;

  WorkPackage({
    required this.packageName,
    required this.measurementUnit,
    required this.quantity,
    required this.rate,
    required this.margin,
    this.amount = 0,
    this.profit = 0,
  });

  // Convert JSON to WorkPackage object
  factory WorkPackage.fromJson(Map<String, dynamic> json) {
    return WorkPackage(
      packageName: json['packageName'] ?? '',
      measurementUnit: json['measurementUnit'] ?? '',
      quantity: json['quantity'] ?? 0,
      rate: json['rate'] ?? 0,
      margin: json['margin'] ?? 0,
      amount: json['amount'] ?? 0,
      profit: json['profit'] ?? 0,
    );
  }
}
