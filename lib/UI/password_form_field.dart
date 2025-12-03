import 'package:flutter/material.dart';

class PasswordFormField extends FormField<String?> {
  final TextEditingController passwordController;
  final bool showPassword;
  final void Function() setShowPassword;
  final bool validatePasswordInit;

  PasswordFormField({
    super.key,
    required this.passwordController,
    required this.showPassword,
    required this.setShowPassword,
    this.validatePasswordInit = false,
  }) : super(
          validator: (_) {
            if (passwordController.text.isEmpty) {
              return "Saisir le mot de passe";
            }
            if (validatePasswordInit) {
              var errorMessage = '';
              if (passwordController.text.length < 6) {
                errorMessage += '• Doit contenir au moins 6 caractères\n';
              }
              if (!passwordController.text.contains(RegExp(r'[A-Z]'))) {
                errorMessage += '• Doit contenir au moins une lettre majuscule\n';
              }
              if (!passwordController.text.contains(RegExp(r'[a-z]'))) {
                errorMessage += '• Doit contenir au moins une lettre muniscule\n';
              }
              if (!passwordController.text.contains(RegExp(r'[0-9]'))) {
                errorMessage += '• Doit contenir au moins un chiffre\n';
              }
              if (!passwordController.text.contains(RegExp(r'[!@#%^&*(),.?":{}|<>]'))) {
                errorMessage += '• Doit contenir au moins un caractère spécial';
              }
              return errorMessage.isNotEmpty ? errorMessage : null;
            }
            return null;
          },
          builder: (FormFieldState<String?> state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  onChanged: (_) {
                    if (state.hasError) {
                      state.validate();
                    }
                  },
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
                        color: state.hasError ? Color.fromRGBO(208, 1, 4, 1) : Color(0xFF000000),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: state.hasError ? Color.fromRGBO(208, 1, 4, 1) : Color(0xFF000000),
                      ),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
                SizedBox(height: 4),
                if (state.hasError && state.errorText != null)
                  Text(
                    state.errorText!,
                    style: TextStyle(color: Color.fromRGBO(208, 1, 4, 1)),
                  ),
              ],
            );
          },
        );
}
