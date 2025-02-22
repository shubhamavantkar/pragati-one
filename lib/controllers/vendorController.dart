import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pragati/constants/consts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VendorController {
  static Future<bool> createVendor({
    required String vendorName,
    required String mobileNumber,
    String? email,
    String? gstin,
    required String vendorType,
    required List<Map<String, dynamic>> assignedWorkPackages,
  }) async {
    final String baseUrl = "http://api.pragatione.com";
    try {
      // Retrieve the stored token
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('authToken');

      if (token == null) {
        throw Exception("Token is missing");
      }
      final response = await http.post(
        Uri.parse('$baseUrl/vendor/create'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // Include token here
        },
        body: jsonEncode({
          "vendorName": vendorName,
          "mobileNumber": mobileNumber,
          "email": email,
          "gstin": gstin,
          "vendorType": vendorType,
          "assignedWorkPackages": assignedWorkPackages,
        }),
      );

      if (response.statusCode == 201) {
        return true;
      } else {
        print('Error: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Exception: $e');
      return false;
    }
  }
}
