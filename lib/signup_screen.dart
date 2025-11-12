import 'package:equity/UI/custom_text_form_field.dart';
import 'package:equity/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final firstNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  DateTime selectedBirthDate = DateTime(1990);
  bool isLoading = false;
  bool isError = false;
  bool showPassword = false;
  late String errorMessage;

  Future<void> _selectBirthDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedBirthDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    setState(() {
      if (pickedDate != null) {
        selectedBirthDate = pickedDate;
      }
    });
  }

  void _registerUser() async {
    setState(() {
      isLoading = true;
      isError = false;
    });
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
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
    setState(() {
      isLoading = false;
    });
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
                      controller: nameController,
                      label: 'Nom',
                      errorMessage: 'Saisir le nom',
                    ),
                    SizedBox(height: 8),
                    CustomTextFormField(
                      controller: firstNameController,
                      label: 'Prénom',
                      errorMessage: 'Saisir le prénom',
                    ),
                    SizedBox(height: 8),
                    CustomTextFormField(
                      controller: emailController,
                      label: 'Adresse e-mail',
                      errorMessage: 'Saisir l\'adresse e-mail',
                    ),
                    SizedBox(height: 8),
                    Text('Date de naissance', style: TextStyle(fontSize: 18)),
                    SizedBox(height: 4),
                    InkWell(
                      onTap: _selectBirthDate,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(18),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                DateFormat('dd/MM/yyyy').format(selectedBirthDate),
                                style: TextStyle(fontSize: 16),
                              ),
                              Semantics(
                                excludeSemantics: true,
                                child: SvgPicture.asset(
                                  'assets/icons/calendar.svg',
                                  width: 20,
                                  height: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    CustomTextFormField(
                      controller: passwordController,
                      label: 'Mot de passe',
                      errorMessage: 'Saisir le mot de passe',
                    ),
                    SizedBox(height: 24),
                    OutlinedButton(
                      onPressed: () => _registerUser(),
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
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                          },
                          child: Text(
                            'Se connecter',
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
