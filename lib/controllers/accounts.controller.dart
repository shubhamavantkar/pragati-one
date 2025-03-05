import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pragati/controllers/tokeController.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountsApiService {
  final String baseUrl = "http://api.pragatione.com";

  Future<List<Map<String, dynamic>>> getAllAccounts(String projectId) async {
    final Uri url = Uri.parse("$baseUrl/accounts/project/$projectId/accounts");
    // Retrieve the stored token
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('authToken');
    print(token);
    try {
      final response = await http.get(url, headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      });

      print(response.body);
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);

        // Check if "data" field exists and is a List
        if (jsonResponse.containsKey('data') && jsonResponse['data'] is List) {
          return List<Map<String, dynamic>>.from(jsonResponse['data']);
        } else {
          throw Exception("Invalid API response format");
        }
      } else {
        throw Exception("Failed to fetch accounts");
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<Map<String, dynamic>> transferMoney(String fromAccountId,
      String toAccountId, Map<String, dynamic> transferData) async {
    final Uri url = Uri.parse(
        "$baseUrl/accounts/account/$fromAccountId/transfer/$toAccountId");

    // Retrieve the stored token
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('authToken');
    print("Token: $token");

    try {
      final response = await http.post(url,
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
          body: jsonEncode(transferData));

      print(response.body);
      if (response.statusCode == 200) {
        return json.decode(response.body) as Map<String, dynamic>;
      } else {
        throw Exception(
            "Transfer failed: ${response.statusCode} ${response.body}");
      }
    } catch (e) {
      throw Exception("Error during transfer: $e");
    }
  }

  Future<Map<String, dynamic>> addMoneyToAccount(
      String accountId, Map<String, dynamic> bodyData) async {
    // Construct the URL using the accountId
    final Uri url = Uri.parse("$baseUrl/accounts/account/$accountId/add");

    // Retrieve the stored token
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('authToken');
    print("Token: $token");

    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(bodyData),
      );

      print("Response: ${response.body}");
      if (response.statusCode == 200) {
        // Parse and return the response body as JSON
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        throw Exception(
            "Failed to add money: ${response.statusCode} ${response.body}");
      }
    } catch (e) {
      throw Exception("Error adding money: $e");
    }
  }

  Future<Map<String, dynamic>> reduceMoneyFromAccount(
      String accountId, Map<String, dynamic> bodyData) async {
    final Uri url = Uri.parse("$baseUrl/accounts/account/$accountId/reduce");

    // Retrieve the stored token
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('authToken');
    print("Token: $token");

    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(bodyData),
      );

      print("Response: ${response.body}");
      if (response.statusCode == 200) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        throw Exception(
            "Failed to reduce money: ${response.statusCode} ${response.body}");
      }
    } catch (e) {
      throw Exception("Error reducing money: $e");
    }
  }
}
