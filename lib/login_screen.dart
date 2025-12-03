import 'package:equity/UI/custom_text_form_field.dart';
import 'package:equity/UI/password_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoginScreen extends StatefulWidget {
  final Function() onTap;

  const LoginScreen({super.key, required this.onTap});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;
  bool isError = false;
  bool showPassword = false;
  late String errorMessage;

  void _logUserIn() async {
    setState(() {
      isLoading = true;
      isError = false;
    });
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        isError = true;
      });
      if (e.code == 'invalid-credential' || e.code == 'user-not-found' || e.code == 'wrong-password') {
        setState(() {
          errorMessage = 'E-mail ou mot de passe incorrect';
        });
      } else if (e.code == 'invalid-email') {
        setState(() {
          errorMessage = 'Adresse e-mail invalide';
        });
      } else {
        setState(() {
          errorMessage = 'Une erreur est survenue';
        });
        print(e);
      }
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        isError = true;
        errorMessage = 'Une erreur est survenue';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Color.fromRGBO(254, 99, 101, 1),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 80),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 48),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(253, 221, 219, 1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/equity.svg',
                      width: 40,
                      height: 40,
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Connexion',
                      style: TextStyle(fontSize: 36, fontWeight: FontWeight.w700),
                      textAlign: TextAlign.center,
                    ),
                    if (isError)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Text(errorMessage, textAlign: TextAlign.center, style: TextStyle(color: Colors.red)),
                      )
                    else
                      SizedBox(height: 32),
                    CustomTextFormField(
                      controller: emailController,
                      label: 'Adresse e-mail',
                      emptyErrorMessage: 'Saisir l\'adresse e-mail',
                      customValidator: (value) {
                        if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
                          return "Format invalide";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Mot de passe', style: TextStyle(fontSize: 18)),
                        SizedBox(height: 4),
                        PasswordFormField(
                          passwordController: passwordController,
                          showPassword: showPassword,
                          setShowPassword: () {
                            setState(() {
                              showPassword = !showPassword;
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: InkWell(
                        child: Text(
                          'Mot de passe oublié',
                          style: TextStyle(
                            color: Color.fromRGBO(77, 129, 231, 1),
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 24),
                    OutlinedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _logUserIn();
                        }
                      },
                      style: OutlinedButton.styleFrom(
                          minimumSize: Size(MediaQuery.of(context).size.width, 50),
                          backgroundColor: Color.fromRGBO(106, 208, 153, 1),
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          side: BorderSide(width: 0)),
                      child: isLoading
                          ? SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(),
                            )
                          : Text(
                              'Se connecter',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    ),
                    SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Pas de compte ? '),
                        InkWell(
                          onTap: widget.onTap,
                          child: Text(
                            'S\'inscrire',
                            style: TextStyle(
                              color: Color.fromRGBO(77, 129, 231, 1),
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
