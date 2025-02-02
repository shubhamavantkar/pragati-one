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
}
