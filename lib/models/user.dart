import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class User {
  String mobile;
  String role;
  bool isPhoneVerified;
  String gstNumber;
  String companyName;
  String email;
  int employeesCount;
  String name;
  String workingType;
  int yearlyTurnover;
  String otherWorkingType;

  User({
    required this.mobile,
    required this.role,
    required this.isPhoneVerified,
    required this.gstNumber,
    required this.companyName,
    required this.email,
    required this.employeesCount,
    required this.name,
    required this.workingType,
    required this.yearlyTurnover,
    required this.otherWorkingType,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      mobile: json['mobile'] ?? '',
      role: json['role'] ?? '',
      isPhoneVerified: json['isPhoneVerified'] ?? false,
      gstNumber: json['GSTNumber'] ?? '',
      companyName: json['companyName'] ?? '',
      email: json['email'] ?? '',
      employeesCount: json['employeesCount'] ?? 0,
      name: json['name'] ?? '',
      workingType: json['workingType'] ?? '',
      yearlyTurnover: json['yearlyTurnover'] ?? 0,
      otherWorkingType: json['otherWorkingType'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mobile': mobile,
      'role': role,
      'isPhoneVerified': isPhoneVerified,
      'GSTNumber': gstNumber,
      'companyName': companyName,
      'email': email,
      'employeesCount': employeesCount,
      'name': name,
      'workingType': workingType,
      'yearlyTurnover': yearlyTurnover,
      'otherWorkingType': otherWorkingType,
    };
  }

  static Future<User?> getSavedUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString('userData');
    if (userData != null) {
      return User.fromJson(jsonDecode(userData));
    }
    return null;
  }
}
