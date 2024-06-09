import 'package:flutter/material.dart';
import 'package:watch_list/core/theme/app_theme.dart';

class CustomTextFieldWidget extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController controller;
  final String hintMessage;
  const CustomTextFieldWidget(
      {required this.controller,
      required this.formKey,
      required this.hintMessage,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formKey,
        child: TextFormField(
          cursorColor: primaryColor,
          style: const TextStyle(color: primaryColor),
          controller: controller,
          autocorrect: true,
          validator: (value) =>
              value == null ? "Please Fill The Text Field !" : null,
          decoration: InputDecoration(
              hintText: hintMessage,
              hintStyle: const TextStyle(fontSize: 18, color: primaryColor),
              fillColor: Colors.black.withAlpha(200),
              filled: true,
              suffixIcon: const Icon(
                Icons.person,
                color: primaryColor,
              ),
              border: OutlineInputBorder(
                  borderSide: const BorderSide(color: secondaryColor, width: 2),
                  borderRadius: BorderRadius.circular(30))),
        ));
  }
}
