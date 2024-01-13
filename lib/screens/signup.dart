import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:haulier_track_app/screens/signin.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  late FocusNode currentFocus;

  @override
  void initState() {
    super.initState();
    currentFocus = FocusNode();
  }

  @override
  void dispose() {
    emailController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    currentFocus.dispose();
    super.dispose();
  }

  Future<void> signUp() async {
    final url = Uri.https(
      'haulier-track-app-default-rtdb.asia-southeast1.firebasedatabase.app',
      'haulier-track-app.json',
    );

    try {
      final response = await http.post(
        url,
        body: json.encode({
          'email': emailController.text,
          'username': usernameController.text,
          'password': passwordController.text,
        }),
      );

      if (response.statusCode == 200) {
        // Store the credentials in SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('username', usernameController.text);
        prefs.setString('password', passwordController.text);

        // Successful signup, handle accordingly
        print('User signed up successfully');

        // Navigate to login screen with pre-filled username and password
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(
              preFilledUsername: usernameController.text,
              preFilledPassword: passwordController.text,
            ),
          ),
        );
      } else {
        // Handle error during signup
        print('Error during signup - ${response.statusCode}');
        // You can display an error message or handle it in another way
      }
    } catch (error) {
      // Handle network or other errors
      print('Error during signup - $error');
      // You can display an error message or handle it in another way
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 199, 196, 180),
        title: Text(
          'Sign Up',
          style: TextStyle(
            fontFamily: 'CustomFont',
            color: Color.fromARGB(255, 0, 0, 0),
            fontSize: 24,
            shadows: [
              Shadow(
                color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.5),
                offset: Offset(2, 2),
                blurRadius: 2,
              ),
            ],
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/background_image.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          hintText: 'Enter your email',
                          prefixIcon: const Icon(
                            Icons.email,
                            size: 30,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextField(
                        controller: usernameController,
                        decoration: InputDecoration(
                          labelText: 'Username',
                          hintText: 'Enter your username',
                          prefixIcon: const Icon(
                            Icons.person,
                            size: 30,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
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
                      const SizedBox(height: 15),
                      TextField(
                        controller: confirmPasswordController,
                        decoration: InputDecoration(
                          labelText: 'Confirm Password',
                          hintText: 'Confirm your password',
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
                      const SizedBox(height: 25),
                      ElevatedButton(
                        onPressed: () {
                          signUp();
                        },
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            fontFamily: 'CustomFont',
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 20,
                            shadows: [
                              Shadow(
                                color:
                                    Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
                                offset: Offset(2, 2),
                                blurRadius: 2,
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
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()),
                          );
                        },
                        child: Text(
                          "Already have an account? Log in now!",
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
          ),
        ],
      ),
    );
  }
}
