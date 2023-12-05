import 'package:covid_tracker/View/world_stats.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoggedIn = false;

  void _login() {
    // Implement your authentication logic here
    // For simplicity, let's assume the login is successful if both username and password are not empty
    if (_usernameController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      setState(() {
        _isLoggedIn = true;
      });
    } else {
      // Show an error message or handle the authentication failure
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('Invalid username or password.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: _isLoggedIn ? _buildLoggedInWidget() : _buildLoginWidget(),
        ),
      ),
    );
  }

  Widget _buildLoginWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextField(
          controller: _usernameController,
          decoration: const InputDecoration(
            labelText: 'Username',
            prefixIcon: Icon(Icons.person),
          ),
        ),
        const SizedBox(height: 16.0),
        TextField(
          controller: _passwordController,
          obscureText: true,
          decoration: const InputDecoration(
            labelText: 'Password',
            prefixIcon: Icon(Icons.lock),
          ),
        ),
        const SizedBox(height: 16.0),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => WorldStatsScreen()));
          },
          child: const Text('Login'),
        ),
      ],
    );
  }

  Widget _buildLoggedInWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Welcome, ${_usernameController.text}!'),
        const SizedBox(height: 16.0),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _isLoggedIn = false;
              _usernameController.clear();
              _passwordController.clear();
            });
          },
          child: const Text('Logout'),
        ),
      ],
    );
  }
}
//////////////////////////////////////////////////////////////////////////////
