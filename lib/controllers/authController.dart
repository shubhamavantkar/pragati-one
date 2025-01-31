import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  final String baseUrl = "http://api.pragatione.com";

  Future<bool> sendOtp(String phoneNumber, String role) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/user/register"),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'mobile': phoneNumber,
          'role': role,
        }),
      );

      if (response.statusCode == 201) {
        final responseData = json.decode(response.body);
        Fluttertoast.showToast(
            msg: responseData['message'], backgroundColor: Colors.green);
        return true; // OTP sent successfully
      } else {
        final errorData = json.decode(response.body);
        Fluttertoast.showToast(
            msg: errorData['error'] ?? 'Failed to send OTP',
            backgroundColor: Colors.redAccent);
        return false;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error: $e', backgroundColor: Colors.redAccent);
      return false;
    }
  }

  Future<bool> verifyOtp(String phoneNumber, String otp) async {
  try {
    final response = await http.post(
      Uri.parse("$baseUrl/user/register"),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'mobile': phoneNumber,
        'otp': otp,
      }),
    );

    print(response.statusCode);
    if (response.statusCode == 201) {
      final responseData = json.decode(response.body);

      if (responseData.containsKey('token')) {
        final String token = responseData['token']; // The authentication token

        // Optionally, you can save the token or use it in your app
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('authToken', token);
        Fluttertoast.showToast(
            msg: responseData['message'], backgroundColor: Colors.green);

        return true; // OTP verified successfully
      } else {
        return false; // Token not found in response
      }
    } else {
      return false; // OTP verification failed or wrong status code
    }
  } catch (e) {
    // Handle error (e.g., network issues)
    print('Error: $e');
    return false;
  }
}
}




