import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<void> createVendor(Map<String, dynamic> vendorData) async {
  final url = Uri.parse(
      'http://api.pragatione.com/vendor/create'); // Replace with your API URL

  try {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');

    if (token == null) {
      print("Error: Token not found in SharedPreferences.");
      return;
    }
    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": token, // Add if needed
      },
      body: jsonEncode(vendorData),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Vendor created successfully: ${response.body}");
    } else {
      print("Failed to create vendor: ${response.body}");
    }
  } catch (e) {
    print("Error: $e");
  }
}
