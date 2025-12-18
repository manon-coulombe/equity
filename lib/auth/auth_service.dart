import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

ValueNotifier<AuthService> authService = ValueNotifier(AuthService());

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => firebaseAuth.currentUser;

  bool get isEmailVerified => currentUser?.emailVerified ?? false;

  Stream<User?> get authStateChanges => firebaseAuth.authStateChanges();

  Future<UserCredential> register({
    required String email,
    required String password,
  }) async {
    return await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
  }

  Future<UserCredential> logIn({
    required String email,
    required String password,
  }) async {
    return await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> logOut() async {
    await firebaseAuth.signOut();
  }

  Future<void> sendVerificationEmail() async {
    try {
      await currentUser?.sendEmailVerification();
    } catch (e) {
      print(e);
    }
  }
}
