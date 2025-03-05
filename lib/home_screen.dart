import 'package:event_management_app/auth_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_page.dart'; // Assuming you have a login page

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? authToken;

  @override
  void initState() {
    super.initState();
    _checkAuthToken();
  }

  // Check for the auth token in SharedPreferences
  Future<void> _checkAuthToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');

    if (token == null || token.isEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AuthPage()),
      );
    } else {
      setState(() {
        authToken = token;
      });
      print("Auth Token: $authToken");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Center(
        child: authToken == null
            ? CircularProgressIndicator() // Show loading indicator while checking the token
            : Text(
                'Welcome to the Event Management App! \nAuth Token: $authToken'),
      ),
    );
  }
}
