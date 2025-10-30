import 'package:equity/UI/button_validate.dart';
import 'package:equity/UI/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(254, 99, 101, 1),
      body: Padding(
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
              SizedBox(height: 20),
              CustomTextFormField(
                controller: emailController,
                label: 'Adresse e-mail',
                errorMessage: 'Saisir l\'adresse e-mail',
              ),
              SizedBox(height: 16),
              CustomTextFormField(
                controller: passwordController,
                label: 'Mot de passe',
                errorMessage: 'Saisir le mot de passe',
              ),
              SizedBox(height: 40),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  minimumSize: Size(MediaQuery.of(context).size.width, 50),
                  backgroundColor: Color.fromRGBO(106, 208, 153, 1),
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                    side: BorderSide(width: 0)
                ),
                child: const Text(
                  'Se connecter',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
