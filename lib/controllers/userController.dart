import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pragati/models/user.dart';

class UserController {
  final String baseUrl = "http://api.pragatione.com";

  Future<User?> updateUser(Map<String, dynamic> userData) async {
    final String url = "$baseUrl/user/update-user";

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('authToken');

      if (token == null) {
        print("Error: Token not found in SharedPreferences.");
        return null;
      }

      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // Token used for authentication
        },
        body: json.encode(userData),
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        return User.fromJson(
            jsonResponse['user']); // Adapt to your API response structure
      } else {
        print("Error updating user: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error updating user: $e");
    }
  }
}
