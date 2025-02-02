import 'package:pragati/models/workPackage.dart';
import 'package:pragati/widgets/projectCard.dart';

class Project {
  String projectName;
  String projectOwner;
  String projectLocation;
  List<WorkPackage> workpackages;

  Project({
    required this.projectName,
    required this.projectLocation,
    required this.projectOwner,
    required this.workpackages,
  });
}
