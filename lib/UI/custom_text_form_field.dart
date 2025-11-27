import 'package:flutter/material.dart';

class CustomTextFormField extends FormField<String?> {
  final String label;
  final TextEditingController controller;
  final String emptyErrorMessage;
  final TextInputType keyboardType;
  final Function? customValidator;
  final Function? onChange;

  CustomTextFormField({
    super.key,
    required this.label,
    required this.controller,
    required this.emptyErrorMessage,
    this.keyboardType = TextInputType.text,
    this.customValidator,
    this.onChange,
  }) : super(
          validator: (_) {
            if (controller.text.isEmpty) {
              return emptyErrorMessage;
            }

            if (customValidator != null) {
              final error = customValidator(controller.text);
              if (error != null) return error;
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
                    onChange?.call();
                    if (state.hasError) {
                      state.validate();
                    }
                  },
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: state.hasError ? Color.fromRGBO(208, 1, 4, 1) :  Color(0xFF000000),
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
                if (state.hasError && state.errorText != null)
                  Text(
                    state.errorText!,
                    style: TextStyle(color: Color.fromRGBO(208, 1, 4, 1)),
                  )
                else
                  SizedBox(height: 20)
              ],
            );
          },
        );
}
