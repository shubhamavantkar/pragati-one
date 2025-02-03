import 'package:pragati/models/workPackage.dart';

class Supervisor {
  String name;
  String mobileNumber;
  List<WorkPackage> workPackage;
  int? monthlySalary;

  Supervisor(
      {required this.name,
      required this.mobileNumber,
      required this.workPackage,
      this.monthlySalary});
}
