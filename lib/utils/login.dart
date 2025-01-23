import 'package:shared_preferences/shared_preferences.dart';

// Function to save JWT token
Future<void> saveToken(String token) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('jwt_token', token);
}

// Function to retrieve JWT token
Future<String?> getToken() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('jwt_token');
}

// Function to remove JWT token (on logout)
Future<void> removeToken() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('jwt_token');
}

Future<bool> isAuthenticated() async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('jwt_token'); // Retrieve the stored JWT token
  return token != null && token.isNotEmpty;
}
