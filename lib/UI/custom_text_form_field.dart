import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String errorMessage;

  const CustomTextFormField({
    super.key,
    required this.label,
    required this.controller,
    required this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 18)),
        SizedBox(height: 8),
        TextFormField(
          onTapOutside: (_) {
            print('onTapOutside');
            FocusManager.instance.primaryFocus?.unfocus();
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return errorMessage;
            }
            return null;
          },
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            fillColor: Colors.white,
            filled: true,
          ),
        ),
      ],
    );
  }
}
