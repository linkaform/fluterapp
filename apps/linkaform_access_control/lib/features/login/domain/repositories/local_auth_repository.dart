import 'package:http/http.dart';
import 'package:linkaform_access_control/features/login/domain/entities/login_response.dart';

abstract class LocalAuthRepository {
  Future<LoginResponse?> getStoredLoginResponse();
  Future<void> saveLoginResponse(dynamic response);
  Future<void> clearLoginResponse();
}