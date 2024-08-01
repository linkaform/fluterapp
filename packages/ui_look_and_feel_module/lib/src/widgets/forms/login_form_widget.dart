import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui_look_and_feel_module/module_exports.dart';
import 'package:ui_look_and_feel_module/src/widgets/form_fields/login_fields/login_text_form_field.dart';

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
  @override
  Widget build(BuildContext context) {
    final translations = ref.watch(translationWidgetStateProvider).translations;
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: widget.formKey,
        autovalidateMode: AutovalidateMode.disabled,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: LoginTextFormField(
                label: translations.emailLabel,
                controller: widget.emailController,
                fieldType: FieldType.Email,
              ),
            ),
            LoginTextFormField(
              label: translations.passwordLabel,
              controller: widget.passwordController,
              fieldType: FieldType.Password,
            )
          ],
        ),
      ),
    );
  }
}
