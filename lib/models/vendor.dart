class Vendor {
  final String id;
  final String vendorName;
  final String mobileNumber;
  final String email;
  final String? gstin;
  final String vendorType;
  final List<WorkPackage> assignedWorkPackages;
  final double totalOrderValue;

  Vendor({
    required this.id,
    required this.vendorName,
    required this.mobileNumber,
    required this.email,
    this.gstin,
    required this.vendorType,
    required this.assignedWorkPackages,
    required this.totalOrderValue,
  });

  factory Vendor.fromJson(Map<String, dynamic> json) {
    var list = json['assignedWorkPackages'] as List;
    List<WorkPackage> workPackages =
        list.map((i) => WorkPackage.fromJson(i)).toList();

    return Vendor(
      id: json['_id'],
      vendorName: json['vendorName'],
      mobileNumber: json['mobileNumber'],
      email: json['email'],
      gstin: json['gstin'],
      vendorType: json['vendorType'],
      assignedWorkPackages: workPackages,
      totalOrderValue: json['totalOrderValue'].toDouble(),
    );
  }
}

class WorkPackage {
  final String projectId;
  final String workOrderId;
  final String workPackageName;
  final String selectedVendorType;
  final List<SubCategory> subCategories;
  final double totalValue;

  WorkPackage({
    required this.projectId,
    required this.workOrderId,
    required this.workPackageName,
    required this.selectedVendorType,
    required this.subCategories,
    required this.totalValue,
  });

  factory WorkPackage.fromJson(Map<String, dynamic> json) {
    var list = json['subCategories'] as List;
    List<SubCategory> subCategories =
        list.map((i) => SubCategory.fromJson(i)).toList();

    return WorkPackage(
      projectId: json['projectId'],
      workOrderId: json['workOrderId'],
      workPackageName: json['workPackageName'],
      selectedVendorType: json['selectedVendorType'],
      subCategories: subCategories,
      totalValue: json['totalValue'].toDouble(),
    );
  }
}

class SubCategory {
  final String name;
  final String unitOfMeasurement;
  final int quantity;
  final double rate;
  final double amount;
  final String id;

  SubCategory({
    required this.name,
    required this.unitOfMeasurement,
    required this.quantity,
    required this.rate,
    required this.amount,
    required this.id,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
      name: json['name'],
      unitOfMeasurement: json['unitOfMeasurement'],
      quantity: json['quantity'],
      rate: json['rate'].toDouble(),
      amount: json['amount'].toDouble(),
      id: json['_id'],
    );
  }
}
