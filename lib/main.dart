import 'package:flutter/material.dart';
import 'package:pragati/constants/consts.dart';
import 'package:pragati/pages/landingPage.dart';
import 'package:pragati/pages/dashboardScreen.dart'; // Import the ProjectDashboard
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensure that async code runs before app starts
  bool isLoggedIn = await checkIfLoggedIn(); // Check if token exists

  runApp(MyApp(isLoggedIn: isLoggedIn)); // Pass the login status to the MyApp
}

Future<bool> checkIfLoggedIn() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('authToken'); // Retrieve the token
  print('Token: $token');
  return token != null && token.isNotEmpty; // If token exists, return true
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pragati',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Metropolis',
        colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
        useMaterial3: true,
      ),
      home: isLoggedIn
          ? DashboardScreen()
          : LandingPage(), // Navigate based on login status
    );
  }
}
