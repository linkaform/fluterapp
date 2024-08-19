import 'dart:convert';
import 'package:linkaform_access_control/features/login/domain/entities/login_response.dart';
import 'package:linkaform_access_control/features/login/domain/repositories/local_auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalAuthRepositoryImpl implements LocalAuthRepository {
  LocalAuthRepositoryImpl(this._prefs);

  final SharedPreferences _prefs;

  static const String loginResponseKey = 'login_response';
  static const String headersKey = 'login_headers';

  @override
  Future<LoginResponse?> getStoredLoginResponse() async {
    final jsonString = _prefs.getString(loginResponseKey);
    if (jsonString == null) return null;
    final jsonMap = json.decode(jsonString) as Map<String, dynamic>;
    return LoginResponse.fromJson(jsonMap);
  }

  @override
  Future<void> saveLoginResponse(dynamic response) async {
    final res = jsonDecode(response as String) as Map<String, dynamic>;
    final loginResponse = LoginResponse.fromJson(res);
    await _prefs.setString(
      loginResponseKey,
      loginResponse.response,
    );
    await _prefs.setString(
      headersKey,
      loginResponse.headers,
    );
  }

  @override
  Future<void> clearLoginResponse() async {
    await _prefs.remove(loginResponseKey);
  }
}
