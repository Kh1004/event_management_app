import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String _statusMessage = 'Loading...';

  @override
  void initState() {
    super.initState();
    _checkDatabaseConnection();
  }

  Future<void> _checkDatabaseConnection() async {
    // Simulate a delay of 3 seconds for loading
    await Future.delayed(Duration(seconds: 3));

    // After the delay, check the database connection
    String result = await ApiConnection().checkDatabaseConnection();

    // Print the result to the console
    print(result);

    // Update the status message with the result
    setState(() {
      _statusMessage = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedOpacity(
              opacity: 1.0,
              duration: Duration(seconds: 2),
              child: Icon(
                Icons.event,
                size: 100,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Event Management App',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
            SizedBox(height: 20),
            Text(
              _statusMessage,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ApiConnection {
  final String url = 'http://192.168.8.250/event_management_app/api/config.php';

  Future<String> checkDatabaseConnection() async {
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['success'] != null) {
          return data['success'];
        } else if (data['error'] != null) {
          return data['error'];
        } else {
          return 'Unexpected response format';
        }
      } else {
        return 'Failed to connect to server';
      }
    } catch (e) {
      return 'Error: $e';
    }
  }
}
