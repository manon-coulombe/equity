import 'package:flutter/material.dart';

class PasswordFormField extends FormField<String?> {
  final TextEditingController passwordController;
  final bool showPassword;
  final void Function() setShowPassword;

  PasswordFormField({
    super.key,
    required this.passwordController,
    required this.showPassword,
    required this.setShowPassword,
  }) : super(
          validator: (_) {
            if (passwordController.text.isEmpty) {
              return "Saisir le mot de passe";
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
                        color: state.hasError ? Color.fromRGBO(208, 1, 4, 1) :  Color(0xFF000000),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: state.hasError ? Color.fromRGBO(208, 1, 4, 1) :  Color(0xFF000000),
                      ),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
                if (state.hasError && state.errorText != null)
                  Text(
                    state.errorText!,
                    style: TextStyle(color: Color.fromRGBO(208, 1, 4, 1)),
                  )
                else
                  SizedBox(height: 20),
              ],
            );
          },
        );
}
