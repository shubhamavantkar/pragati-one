class WorkPackage {
  final String projectId;
  final String workOrderId;
  final String workPackageName;
  final int salary;

  WorkPackage({
    required this.projectId,
    required this.workOrderId,
    required this.workPackageName,
    required this.salary,
  });

  factory WorkPackage.fromJson(Map<String, dynamic> json) {
    return WorkPackage(
      projectId: json['projectId'],
      workOrderId: json['workOrderId'],
      workPackageName: json['workPackageName'],
      salary: json['salary'] ?? 0,
    );
  }
}
