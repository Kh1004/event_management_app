import 'package:event_management_app/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:event_management_app/database_helper.dart'; // Assuming this contains the loginUser function
import 'package:shared_preferences/shared_preferences.dart'; // For shared preferences storage

class LoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Validate email input
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    final regex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!regex.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  // Validate password input
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    return null;
  }

  // Function to handle login
  Future<void> get_login(BuildContext context) async {
    String email = _emailController.text;
    String password = _passwordController.text;

    // Check if email or password is empty
    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Input fields cannot be empty')),
      );
      return;
    }

    // Perform the login action
    print('Email: $email');
    print('Password: $password');

    try {
      final result =
          await loginUser(email, password); // loginUser is your login API call

      if (result == null) {
        // Show error if the result is null (invalid credentials)
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid credentials')),
        );
      } else {
        // Assuming result contains the auth token (String)
        String authToken = result;

        // Save the auth token in SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', authToken);

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login successful')),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      }
    } catch (e) {
      // Catch any errors that might occur during the login process
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Email field
        TextFormField(
          controller: _emailController,
          decoration: const InputDecoration(labelText: 'Email'),
          keyboardType: TextInputType.emailAddress,
          validator: _validateEmail,
        ),
        // Password field
        TextFormField(
          controller: _passwordController,
          decoration: const InputDecoration(labelText: 'Password'),
          obscureText: true,
          validator: _validatePassword,
        ),
        const SizedBox(height: 20),
        // Login button
        ElevatedButton(
          onPressed: () {
            get_login(context); // Call the login function
          },
          child: const Text('Login'),
        ),
      ],
    );
  }
}
