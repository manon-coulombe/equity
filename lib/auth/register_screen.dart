import 'package:equity/UI/custom_text_form_field.dart';
import 'package:equity/UI/password_form_field.dart';
import 'package:equity/auth/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  final Function() onTap;

  const RegisterScreen({super.key, required this.onTap});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final firstNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool isError = false;
  bool showPassword = false;
  bool showConfirmPassword = false;
  late String errorMessage;

  @override
  void dispose() {
    nameController.dispose();
    firstNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void _registerUser() async {
    setState(() {
      isError = false;
    });
    try {
      if (passwordController.text == confirmPasswordController.text) {
        await authService.value.register(
          email: emailController.text,
          password: passwordController.text,
        );
      } else {
        isError = true;
        errorMessage = 'Les mots de passe doivent être identiques';
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        isError = true;
      });
      if (e.code == 'weak-password') {
        setState(() {
          errorMessage = 'Le mot de passe est trop faible';
        });
      } else if (e.code == 'email-already-in-use') {
        setState(() {
          errorMessage = 'L\'adresse e-mail est déjà associée à un compte';
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
    } catch (e) {
      print(e);
      setState(() {
        isError = true;
        errorMessage = 'Une erreur est survenue';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color.fromRGBO(254, 99, 101, 1),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 80),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(253, 221, 219, 1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Inscription',
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
                        if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value)) {
                          return "Format invalide";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 4),
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
                          validatePasswordInit: true,
                        ),
                      ],
                    ),
                    SizedBox(height: 24),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Confirmation du mot de passe', style: TextStyle(fontSize: 18)),
                        SizedBox(height: 4),
                        PasswordFormField(
                          passwordController: confirmPasswordController,
                          showPassword: showConfirmPassword,
                          setShowPassword: () {
                            setState(() {
                              showConfirmPassword = !showConfirmPassword;
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 24),
                    OutlinedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _registerUser();
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
                      child:
                          //TODO
                          // isLoading
                          //     ? SizedBox(
                          //         height: 20,
                          //         width: 20,
                          //         child: CircularProgressIndicator(),
                          //       )
                          //     :
                          Text(
                        'S\'inscrire',
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
                        Text('Vous avez déjà un compte ? '),
                        InkWell(
                          onTap: widget.onTap,
                          child: Text(
                            'Se connecter',
                            style: TextStyle(
                              color: Color.fromRGBO(77, 129, 231, 1),
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
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
