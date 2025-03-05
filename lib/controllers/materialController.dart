import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<Map<String, dynamic>>> getMaterialsByProjectId(
    String projectId, String token) async {
  final String baseUrl = "http://api.pragatione.com";
  final url = Uri.parse('$baseUrl/material/$projectId');

  final response = await http.get(
    url,
    headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> responseData = jsonDecode(response.body);
    // Extract the "data" key from the response and convert it to a list of maps.
    return List<Map<String, dynamic>>.from(responseData['data']);
  } else {
    throw Exception('Failed to fetch materials: ${response.statusCode}');
  }
}
