import 'package:pragati/models/vendorType.dart';
import 'package:pragati/models/workPackage.dart';

class Vendor {
  String name;
  String mobileNumber;
  VendorType vendorType;
  List<WorkPackage> workPackage;

  Vendor({
    required this.name,
    required this.mobileNumber,
    required this.workPackage,
    required this.vendorType,
  });
}
