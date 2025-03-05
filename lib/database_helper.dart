import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> checkDatabaseConnection() async {
  final Uri url =
      Uri.parse('http://192.168.8.250/event_management_app/api/config.php');

  try {
    final response = await http.get(url);

    // Check if the server response status code is not 500 (success)
    if (response.statusCode != 500) {
      return {
        'status': true,
        'message': 'Connection successful',
      };
    } else {
      // If the status code is 500, return a failure message
      return {
        'status': false,
        'message': 'Server returned an error (500)',
      };
    }
  } catch (e) {
    // If there is any error (e.g., network issues), return the error details
    print('Error: $e');
    return {
      'status': false,
      'message': 'Error: $e',
    };
  }
}

Future<Map<String, dynamic>> registerUser(
    String name, String email, String password) async {
  print("register start");
  try {
    final response = await http.post(
      Uri.parse(
          'http://192.168.8.250/event_management_app/api/auth/register.php'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'name': name,
        'email': email,
        'password': password,
      }),
    );

    print("Raw Response Body: ${response.body}");

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      print('Response: $responseData');
      return responseData;
    } else {
      return {
        'status': 'error',
        'message': 'Failed to register: ${response.statusCode}'
      };
    }
  } catch (e) {
    print('Error occurred: $e');
    return {'status': 'error', 'message': 'Error occurred: $e'};
  }
}

Future<String?> loginUser(String email, String password) async {
  print("loginstart ............");

  Uri apiUrl =
      Uri.parse('http://192.168.8.250/event_management_app/api/auth/login.php');

  Map<String, String> body = {
    'email': email,
    'password': password,
  };

  try {
    final response = await http.post(apiUrl, body: body);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      if (data['success']) {
        String token = data['user']['token'];
        print('Token: $token');
        return token;
      } else {
        print('Login failed: ${data['message']}');
        return null;
      }
    } else {
      print('Failed to login. Status code: ${response.statusCode}');
      return null;
    }
  } catch (e) {
    print('Error: $e');
    return null;
  }
}
