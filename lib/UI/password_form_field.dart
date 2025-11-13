import 'package:flutter/material.dart';

class PasswordFormField extends StatelessWidget {
  const PasswordFormField({
    super.key,
    required this.passwordController,
    required this.showPassword,
    required this.setShowPassword,
  });

  final TextEditingController passwordController;
  final bool showPassword;
  final void Function() setShowPassword;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.text,
      onTapOutside: (_) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      controller: passwordController,
      obscureText: !showPassword,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          icon: Icon(
            showPassword ? Icons.visibility : Icons.visibility_off,
            color: Colors.black38,
          ),
          onPressed: () => setShowPassword(),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Color(0xFF000000),
          ),
        ),
        fillColor: Colors.white,
        filled: true,
      ),
    );
  }
}
