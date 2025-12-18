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
      authService.value.sendVerificationEmail();

      timer = Timer.periodic(
        Duration(seconds: 3),
        (_) => _checkVerifiedEmail(),
      );
    }
  }

  Future _checkVerifiedEmail() async {
    await authService.value.currentUser?.reload();
    setState(() {
      isEmailVerified = authService.value.isEmailVerified;
    });

    if (isEmailVerified) timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return isEmailVerified ? HomeScreen() : Center(child: Text('Verifier l\'email'));
  }
}
