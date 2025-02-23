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
      print("Token: $token");
      print("User Data: $userData");
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // Token used for authentication
        },
        body: json.encode(userData),
      );
      print(response.body);
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        // Ensure the response is a valid map
        if (jsonResponse == null || jsonResponse is! Map<String, dynamic>) {
          print("Error: API response is not a valid JSON object.");
          return null;
        }

        // Now deserialize it correctly
        return User.fromJson(jsonResponse);
      } else {
        print("Error updating user: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error updating user: $e");
    }
  }
}
