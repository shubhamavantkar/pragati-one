import 'package:shared_preferences/shared_preferences.dart';


Future<String?> getToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('authToken'); // Returns the stored token or null
}