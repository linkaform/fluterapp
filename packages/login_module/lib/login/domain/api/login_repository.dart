import 'package:login_module/login/domain/entities/login.dart';

abstract class LoginRepository {
  Future<dynamic> login(LoginCredentialsEntity credentials);
}
