import 'app_localizations.dart';

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get login_button_text => 'Login';

  @override
  String get successfully_message => 'Inicio de sesión exitoso!';

  @override
  String get failure_message => 'Ocurrió un error al iniciar sesión: ';

  @override
  String get validating_credentials_message => 'Validadando credenciales...';

  @override
  String get enter_email_error_message => 'Por favor ingresa tu correo electrónico';

  @override
  String get enter_password_error_message => 'Por favor ingresa tu contraseña';
}
