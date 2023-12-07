import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final _firebase = FirebaseAuth.instance;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _form = GlobalKey<FormState>();
  var _isLogIn = true;
  var _enteredEmail = '';
  var _enteredPassword = '';

  void _submit() async {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }

    _form.currentState!.save();
    try {
      if (_isLogIn) {
        //if user is in Login state
        final userCredentials = await _firebase.createUserWithEmailAndPassword(
            email: _enteredEmail, password: _enteredPassword);
        print(userCredentials);
      } else {
        final userCredentials = await _firebase.createUserWithEmailAndPassword(
            email: _enteredEmail, password: _enteredPassword);
        print(userCredentials);
      }
    } on FirebaseAuthException catch (error) {
      if (error.code == 'email-already-in-use') {
        //code if we intercept an Firebase Auth error
      }
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.message ?? 'Authentication Failed'),
        ),
      );
    }
  }

  void _login() {
    // Implement your authentication logic here
    // For simplicity, let's assume the login is successful if both username and password are not empty
    if (_usernameController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _usernameController.text, password: _passwordController.text);
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
        title: const Text('COVID-19 Tracker'),
        centerTitle: true,
      ),
      body: _buildLoginWidget(),
    );
  }

  Widget _buildLoginWidget() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 150,
            margin: const EdgeInsets.only(
              top: 30,
              bottom: 20,
              left: 20,
              right: 20,
            ),
            child: Image.asset('images/virus.png'),
          ),
          Card(
            margin: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _form,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (value == null ||
                              value.trim().isEmpty ||
                              !value.contains('@')) {
                            return 'Please return a valid E-mail address';
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          _enteredEmail = newValue!;
                        },
                        controller: _usernameController,
                        decoration: const InputDecoration(
                          labelText: 'Username',
                          prefixIcon: Icon(Icons.person),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        onSaved: (newValue) {
                          _enteredPassword = newValue!;
                        },
                        validator: (value) {
                          if (value == null || value.trim().length < 6) {
                            return 'Password must be 6 characters long';
                          }
                          return null;
                        },
                        controller: _passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          prefixIcon: Icon(Icons.lock),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      ElevatedButton(
                        onPressed: _submit,
                        // () {
                        //   Navigator.of(context).push(
                        //       MaterialPageRoute(builder: (context) => WorldStatsScreen()));
                        // },
                        child: Text(_isLogIn ? 'Login' : 'Signup'),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _isLogIn = !_isLogIn;
                          });
                        },
                        child: Text(_isLogIn
                            ? 'Create an account'
                            : 'I already have an account'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget _buildLoggedInWidget() {
  //   return Center(
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         Text('Welcome, ${_usernameController.text}!'),
  //         const SizedBox(height: 16.0),
  //         ElevatedButton(
  //           onPressed: () {
  //             setState(() {
  //               _isLogIn = false;
  //               _usernameController.clear();
  //               _passwordController.clear();
  //             });
  //           },
  //           child: const Text('Logout'),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
//////////////////////////////////////////////////////////////////////////////
