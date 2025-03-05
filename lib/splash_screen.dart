import 'package:event_management_app/auth_page.dart';
import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'home_page.dart'; // Make sure to import your home page

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String _databaseStatus = "Loading...";
  bool _isLoading = true; // Flag to control the loading indicator

  @override
  void initState() {
    super.initState();
    _showSplashScreen();
  }

  void _showSplashScreen() async {
    await Future.delayed(const Duration(seconds: 3));

    Map<String, dynamic> result = await checkDatabaseConnection();

    setState(() {
      _isLoading = false;
      _databaseStatus = result['message'];
    });

    if (result['status']) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AuthPage()),
      );
      print("Connection successful");
      print(result['status']);
    } else {
      print("Connection failed: ${result['message']}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.white), // White progress indicator
              )
            : Text(
                _databaseStatus,
                style: const TextStyle(fontSize: 24, color: Colors.white),
              ),
      ),
    );
  }
}
