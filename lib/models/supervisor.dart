import 'package:pragati/models/supervisorWorkPackage.dart';

class Supervisor {
  String name;
  String mobileNumber;
  List<WorkPackage> workPackage;
  int? monthlySalary;

  Supervisor({
    required this.name,
    required this.mobileNumber,
    required this.workPackage,
    this.monthlySalary,
  });

  factory Supervisor.fromJson(Map<String, dynamic> json) {
    return Supervisor(
      name: json['name'],
      mobileNumber: json['mobileNumber'],
      workPackage: (json['assignedWorkPackages'] as List<dynamic>)
          .map((wp) => WorkPackage.fromJson(wp))
          .toList(),
      monthlySalary: json['monthlySalary'] ?? 0,
    );
  }
}
