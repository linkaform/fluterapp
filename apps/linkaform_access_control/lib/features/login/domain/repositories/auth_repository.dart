import 'package:linkaform_access_control/features/login/domain/entities/login_response.dart';

abstract class AuthRepository {
  Future<void> login(LoginResponse response);
  Future<void> logout();
  Future<LoginResponse?> getStoredLoginResponse();
}