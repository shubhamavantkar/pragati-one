import 'package:pragati/widgets/projectCard.dart';

class Project {
  String projectId; // New field for project ID
  String projectName;
  String clientName;
  String location;

  Project({
    required this.projectId,
    required this.projectName,
    required this.clientName,
    required this.location,
  });

  // fromJson method to initialize Project instance from JSON
  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      projectId: json['_id'] ?? '', // Default empty string if key doesn't exist
      projectName: json['projectName'] ?? '',
      clientName: json['clientName'] ?? '',
      location: json['location'] ?? '',
    );
  }
}

