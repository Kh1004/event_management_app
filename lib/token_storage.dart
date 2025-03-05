import 'package:shared_preferences/shared_preferences.dart';

class TokenStorage {
  // Key for storing the auth token
  static const String _authTokenKey = 'auth_token';

  // Save the token to shared preferences
  static Future<void> saveAuthToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_authTokenKey, token);
  }

  // Get the auth token from shared preferences
  static Future<String?> getAuthToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_authTokenKey);
  }

  // Remove the auth token from shared preferences (for logout functionality)
  static Future<void> removeAuthToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_authTokenKey);
  }
}
