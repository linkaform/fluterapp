import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui_look_and_feel_module/module_exports.dart';

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
    final translations = ref.watch(translationWidgetStateProvider).translations;
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: widget.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: TextFormField(
                controller: widget.emailController,
                decoration: InputDecoration(
                  labelText: translations.emailLabel,
                  border: OutlineInputBorder(),
                ),
                validator: (_) => ref.read(
                  loginFormValidationProvider(
                    LoginFormType(_, FieldType.Email),
                  ),
                ),
              ),
            ),
            TextFormField(
              controller: widget.passwordController,
              obscureText: _isPasswordVisible,
              decoration: InputDecoration(
                labelText: translations.passwordLabel,
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
              validator: (_) => ref.read(
                loginFormValidationProvider(
                  LoginFormType(_, FieldType.Password),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showPassword() =>
      setState(() => _isPasswordVisible = !_isPasswordVisible);
}
