import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/form_validator_providers.dart';
import '../../../styles/linkaform_security_styles.dart';

class LoginTextFormField extends ConsumerStatefulWidget {
  final String label;
  final TextEditingController controller;
  final FieldType fieldType;

  const LoginTextFormField({
    super.key,
    required this.label,
    required this.controller,
    required this.fieldType,
  });

  @override
  ConsumerState createState() => _LoginTextFormFieldState();
}

class _LoginTextFormFieldState extends ConsumerState<LoginTextFormField> {
  var _isPasswordVisible = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText:
          widget.fieldType == FieldType.Password ? _isPasswordVisible : false,
      decoration: LinkaformSecurityStyles.TextFormFieldStyle(
        widget.label,
        widget.fieldType,
        isPasswordVisible:
            widget.fieldType == FieldType.Password ? _isPasswordVisible : false,
        method: widget.fieldType == FieldType.Password ? showPassword : null,
      ),
      validator: (_) => ref.read(
        loginFormValidationProvider(LoginFormType(_, widget.fieldType)),
      ),
    );
  }

  void showPassword() =>
      setState(() => _isPasswordVisible = !_isPasswordVisible);
}
