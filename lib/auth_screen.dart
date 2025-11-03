import 'package:equity/home/screen/home_screen.dart';
import 'package:equity/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
        print('hey');
          if (snapshot.hasData) {
            print(snapshot);
            return HomeScreen();
          } else {
            return LoginScreen();
          }
        },
      )
    );
  }
}
