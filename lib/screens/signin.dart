import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:haulier_track_app/screens/truck_sched.dart';
import 'signup.dart';

class LoginScreen extends StatefulWidget {
  final String? preFilledUsername;
  final String? preFilledPassword;

  const LoginScreen({Key? key, this.preFilledUsername, this.preFilledPassword})
      : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  late FocusNode currentFocus;

  @override
  void initState() {
    super.initState();
    currentFocus = FocusNode();

    // Pre-fill the username and password if provided
    if (widget.preFilledUsername != null) {
      emailController.text = widget.preFilledUsername!;
    }
    if (widget.preFilledPassword != null) {
      passwordController.text = widget.preFilledPassword!;
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    currentFocus.dispose();
    super.dispose();
  }

  // Function to handle the login button press
  void _handleLogin() {
    // Perform login logic here

    // Navigate to the dashboard page
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => DashboardScreen(truckTrips: [])),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 199, 196, 180),
        title: Text(
          'Login',
          style: TextStyle(
            fontFamily: 'CustomFont',
            color: Color.fromARGB(255, 0, 0, 0),
            fontSize: 24,
            shadows: [
              Shadow(
                color: const Color.fromARGB(255, 255, 255, 255)
                    .withOpacity(0.5), // Adjust the shadow color and opacity
                offset: Offset(2, 2), // Adjust the shadow offset
                blurRadius: 2, // Adjust the shadow blur radius
              ),
            ],
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                "assets/images/background_image.jpg"), // Replace with your image asset path
            fit: BoxFit.cover,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    hintText: 'Enter your username',
                    prefixIcon: const Icon(
                      Icons.email,
                      size: 30,
                      color: Color.fromARGB(255, 254, 254, 254),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  focusNode: currentFocus,
                ),
                const SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: 'Enter your password',
                    prefixIcon: const Icon(
                      Icons.lock,
                      size: 30,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  obscureText: true,
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: _handleLogin, // Call the _handleLogin function
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontFamily: 'CustomFont',
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 20,
                      shadows: [
                        Shadow(
                          color: Color.fromARGB(255, 0, 0, 0).withOpacity(
                              0.5), // Adjust the shadow color and opacity
                          offset: Offset(2, 2), // Adjust the shadow offset
                          blurRadius: 2, // Adjust the shadow blur radius
                        ),
                      ],
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 185, 182, 165),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpScreen()),
                    );
                  },
                  child: Text(
                    "Don't have an account? Sign up now!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
