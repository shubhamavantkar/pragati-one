import 'package:pragati/models/workPackage.dart';
import 'package:pragati/widgets/projectCard.dart';

class Project {
  String projectId;
  String projectName;
  String clientName;
  String location;
  List<WorkPackage> workpackages;

  Project({
    required this.projectId,
    required this.projectName,
    required this.location,
    required this.clientName,
    required this.workpackages,
  });

  // Convert JSON to Project object
  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      projectId: json['_id'] ?? '',
      projectName: json['projectName'] ?? '',
      clientName: json['clientName'] ?? '',
      location: json['location'] ?? '',
      workpackages: (json['workOrders'] as List<dynamic>?)
              ?.map((wp) => WorkPackage.fromJson(wp))
              .toList() ??
          [],
    );
  }

}
