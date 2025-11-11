import 'package:flutter/material.dart';

class CustomTextFormField extends FormField<String?> {
  final String label;
  final TextEditingController controller;
  final String errorMessage;
  final TextInputType keyboardType;

  CustomTextFormField({
    super.key,
    required this.label,
    required this.controller,
    required this.errorMessage,
    this.keyboardType = TextInputType.text,
  }) : super(
          validator: (_) {
            if (controller.text.isEmpty) {
              return errorMessage;
            }
            return null;
          },
          builder: (FormFieldState<String?> state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: TextStyle(fontSize: 18)),
                SizedBox(height: 4),
                TextFormField(
                  textCapitalization: TextCapitalization.sentences,
                  keyboardType: keyboardType,
                  onTapOutside: (_) {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  controller: controller,
                  onChanged: (_) {
                    if (state.hasError) {
                      state.validate();
                    }
                  },
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: state.hasError ? Colors.red : Colors.white,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: state.hasError ? Colors.red : Color(0xFF000000),
                      ),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
                if (state.hasError && state.errorText != null)
                  Text(
                    state.errorText!,
                    style: TextStyle(color: Colors.red),
                  ),
              ],
            );
          },
        );
}
