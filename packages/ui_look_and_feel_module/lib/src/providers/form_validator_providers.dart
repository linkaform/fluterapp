import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui_look_and_feel_module/src/providers/translation_providers.dart';

enum FieldType { Email, Password }

enum ValidationType { Credentials }

class LoginFormType {
  final String? value;
  final FieldType fieldType;

  LoginFormType(this.value, this.fieldType);
}

final loginFormValidationProvider = Provider.family<String?, LoginFormType>(
  (ref, loginType) {
    final translations = ref.watch(translationWidgetStateProvider).translations;
    if (loginType.value?.isEmpty == true) {
      return loginType.fieldType == FieldType.Email
          ? translations.enterEmailErrorMessage
          : translations.enterPasswordErrorMessage;
    }
    return null;
  },
);
