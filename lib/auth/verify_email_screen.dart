import 'dart:async';

import 'package:equity/auth/auth_service.dart';
import 'package:equity/home/screen/home_screen.dart';
import 'package:flutter/material.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({super.key});

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  bool isEmailVerified = false;
  bool canResendEmail = false;
  Timer? timer;

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    isEmailVerified = authService.value.isEmailVerified;
    super.initState();
    if (!isEmailVerified) {
      _sendVerificationEmail();

      timer = Timer.periodic(
        Duration(seconds: 3),
        (_) => _checkVerifiedEmail(),
      );
    }
  }

  Future _sendVerificationEmail() async {
    try {
      await authService.value.sendVerificationEmail();
      setState(() {
        canResendEmail = false;
      });
      await Future.delayed(Duration(seconds: 30));
      setState(() {
        canResendEmail = true;
      });
    } catch (e) {
      print(e);
    }
  }

  Future _checkVerifiedEmail() async {
    print('coucou');
    await authService.value.currentUser?.reload();
    setState(() {
      isEmailVerified = authService.value.isEmailVerified;
    });

    if (isEmailVerified) timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return isEmailVerified
        ? HomeScreen()
        : Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Un e-mail de vérification a été envoyé à l\'adresse indiquée. Veuillez vérifier votre e-mail pour continuer.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 24),
                  if (canResendEmail)
                    ElevatedButton.icon(
                      onPressed: _sendVerificationEmail,
                      label: Text(
                        'Renvoyer l\'e-mail',
                        style: TextStyle(color: Color.fromRGBO(252, 99, 97, 1)),
                      ),
                      style: ElevatedButton.styleFrom(
                        // maximumSize: Size.fromHeight(60),
                        backgroundColor: Color.fromRGBO(253, 221, 219, 1),
                      ),
                      icon: Icon(Icons.email, size: 32, color: Color.fromRGBO(252, 99, 97, 1)),
                    ),
                  SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: authService.value.logOut,
                    style: ElevatedButton.styleFrom(
                      // maximumSize: Size.fromHeight(60),
                      backgroundColor: Color.fromRGBO(252, 99, 97, 1),
                    ),
                    child: Text(
                      'Annuler',
                      style: TextStyle(color: Color.fromRGBO(253, 221, 219, 1)),
                    ),
                  )
                ],
              ),
            ),
          );
  }
}
