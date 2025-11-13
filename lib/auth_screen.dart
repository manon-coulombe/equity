import 'package:equity/home/screen/home_screen.dart';
import 'package:equity/login_screen.dart';
import 'package:equity/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool showLoginScreen = true;
  void togglePages() {
    setState(() {
      showLoginScreen = !showLoginScreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return HomeScreen();
          } else {
            if (showLoginScreen) {
              return LoginScreen(onTap: togglePages);
            } else {
              return SignupScreen(onTap: togglePages);
            }
          }
        },
      )
    );
  }
}
