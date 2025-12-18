import 'package:equity/auth/auth_service.dart';
import 'package:equity/home/screen/home_screen.dart';
import 'package:equity/auth/login_screen.dart';
import 'package:equity/auth/register_screen.dart';
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
      body: StreamBuilder<User?>(
        stream: authService.value.authStateChanges,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return HomeScreen();
          } else {
            if (showLoginScreen) {
              return LoginScreen(onTap: togglePages);
            } else {
              return RegisterScreen(onTap: togglePages);
            }
          }
        },
      ),
    );
  }
}
