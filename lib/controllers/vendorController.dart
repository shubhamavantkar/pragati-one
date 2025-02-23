import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pragati/constants/consts.dart';
import 'package:pragati/models/vendor.dart';
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

      final Map<String, dynamic> requestBody = {
        "vendorName": vendorName,
        "mobileNumber": mobileNumber,
        "email": email,
        "vendorType": vendorType,
        "assignedWorkPackages": assignedWorkPackages,
        if (gstin != null)
          "gstin": gstin, // Include gstin only if it's not null
      };

      final response = await http.post(
        Uri.parse('$baseUrl/vendor/create'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // Include token here
        },
        body: jsonEncode(requestBody),
      );
      print(response.body);
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

  static Future<List<Vendor>?> fetchVendorData(
      String projectId, String token) async {
    final String baseUrl = "http://api.pragatione.com";
    final String url = '$baseUrl/vendor/$projectId';

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data =
            json.decode(response.body); // Decode as a list
        return data
            .map((json) => Vendor.fromJson(json))
            .toList(); // Convert each item to Vendor
      } else {
        print('Error: ${response.statusCode}, ${response.body}');
        return null;
      }
    } catch (e) {
      print('Exception: $e');
      return null;
    }
  }
}
