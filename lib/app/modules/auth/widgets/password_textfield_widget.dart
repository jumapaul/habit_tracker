import 'package:flutter/material.dart';

import '../../../common/dimens/dimens.dart';

class PasswordTextFieldWidget extends StatefulWidget {
  final String hintText;
  final String labelText;
  final String? errorText;
  final TextEditingController passwordTextEditController;

  const PasswordTextFieldWidget(
      {super.key,
        required this.hintText,
        required this.passwordTextEditController,
        required this.labelText,
        this.errorText});

  @override
  State<PasswordTextFieldWidget> createState() =>
      _PasswordTextFieldWidgetState();
}

class _PasswordTextFieldWidgetState extends State<PasswordTextFieldWidget> {
  bool showPassword = false;

  void _toggleVisibility() {
    setState(() {
      showPassword = !showPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: !showPassword,
      controller: widget.passwordTextEditController,
      decoration: InputDecoration(
        hintText: widget.hintText,
        labelText: widget.labelText,
        errorText: widget.errorText,
        hintStyle: AppTextStyles.subHeaderStyle,
        labelStyle: AppTextStyles.subHeaderStyle,
        suffixIcon: IconButton(
          onPressed: () {
            _toggleVisibility();
          },
          icon: showPassword
              ? const Icon(
            size: 15,
            Icons.visibility,
          )
              : const Icon(
            size: 15,
            Icons.visibility_off,
          ),
        ),
      ),
      style: const TextStyle(
        fontSize: 14,
      ),
      validator: (val) {
        if (val?.isEmpty == true) {
          return "Please input password";
        }
        return null;
      },
    );
  }
}
