enum FieldType { Email, Password }

String? validateValue(String? value, FieldType fieldType) {
  if (value == null || value.isEmpty) {
    return fieldType == FieldType.Email
        ? 'localizations.enter_email_error_message'
        : 'localizations.enter_password_error_message';
  }
  return null;
}
