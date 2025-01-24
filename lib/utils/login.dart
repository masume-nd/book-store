import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

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
  final token = prefs.getString('jwt_token');
  // Retrieve the stored JWT token
  return token != null && token.isNotEmpty;
}

Future<void> scheduleLogoutBasedOnToken(String token) async {
  Map<String, dynamic> decodedToken = JwtDecoder.decode(token);

  if (decodedToken.containsKey('exp')) {
    print('expireddddd');
    DateTime expirationDate =
        JwtDecoder.getExpirationDate(token); // Returns DateTime object

    // Get the remaining time
    final Duration timeUntilExpiry = expirationDate.difference(DateTime.now());

    if (timeUntilExpiry.isNegative) {
      // Token is already expired
      removeToken();
    } else {
      // Schedule a logout when the token expires
      Future.delayed(timeUntilExpiry, () {
        removeToken();
      });
    }
  } else {
    throw Exception("Token does not contain an 'exp' field");
  }
}
