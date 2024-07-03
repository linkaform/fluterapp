import 'package:login_module/gen/l10n/app_localizations_es.dart';

enum FieldType { Email, Password }

String? validateValue(String? value, FieldType fieldType) {
  final localizations = AppLocalizationsEs();
  if (value == null || value.isEmpty) {
    return fieldType == FieldType.Email
        ? localizations.enter_email_error_message
        : localizations.enter_password_error_message;
  }
  return null;
}
