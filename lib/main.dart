import 'package:event_management_app/auth_page.dart';
import 'package:event_management_app/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Event Management App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
      // home: AuthPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
