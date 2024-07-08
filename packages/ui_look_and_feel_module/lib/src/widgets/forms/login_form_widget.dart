import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/form_validator_providers.dart';

class LoginFormWidget extends ConsumerStatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController, passwordController;

  const LoginFormWidget({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
  });

  @override
  ConsumerState createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends ConsumerState<LoginFormWidget> {
  var _isPasswordVisible = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: widget.formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: TextFormField(
                controller: widget.emailController,
                decoration: InputDecoration(
                  labelText: FieldType.Email.name,
                  border: OutlineInputBorder(),
                ),
                validator: (_) => validateField(ref, _, FieldType.Email),
              ),
            ),
            TextFormField(
              controller: widget.passwordController,
              obscureText: _isPasswordVisible,
              decoration: InputDecoration(
                labelText: FieldType.Password.name,
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: () => showPassword(),
                ),
              ),
              validator: (_) => validateField(ref, _, FieldType.Password),
            ),
          ],
        ),
      ),
    );
  }

  void showPassword() =>
      setState(() => _isPasswordVisible = !_isPasswordVisible);

  @override
  void dispose() {
    widget.emailController.dispose();
    widget.passwordController.dispose();
    super.dispose();
  }
}
