import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui_look_and_feel_module/gen/colors.gen.dart';
import 'package:ui_look_and_feel_module/src/providers/translation_providers.dart';

import '../../styles/linkaform_security_styles.dart';
import '../snack_bars/common_snackbar.dart';

class LoginProgressButtonWidget extends ConsumerStatefulWidget {
  final bool isLoading;
  final GlobalKey<FormState> formKey;
  final VoidCallback function;

  const LoginProgressButtonWidget({
    super.key,
    required this.isLoading,
    required this.formKey,
    required this.function,
  });

  @override
  ConsumerState createState() => _LoginProgressButtonWidgetState();
}

class _LoginProgressButtonWidgetState
    extends ConsumerState<LoginProgressButtonWidget> {
  @override
  Widget build(BuildContext context) {
    final translation = ref.watch(translationWidgetStateProvider).translations;

    return widget.isLoading
        ? const CircularProgressIndicator(color: ColorName.colorChangeOther)
        : ElevatedButton(
            style: LinkaformSecurityStyles.primaryButtonStyle,
            onPressed: () async {
              buildSuccessSnackBar(
                  translation.validatingMessage.replaceFirst(
                    '\$',
                    translation.credentialsLabel,
                  ),
                  Colors.greenAccent);
              if (widget.formKey.currentState?.validate() != null)
                widget.function();
            },
            child: Text(translation.loginButtonText),
          );
  }
}
