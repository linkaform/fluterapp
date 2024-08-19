import 'package:http/http.dart';
import 'package:linkaform_access_control/features/login/domain/entities/login_response.dart';
import 'package:linkaform_access_control/features/login/domain/repositories/auth_repository.dart';
import 'package:linkaform_access_control/features/login/domain/repositories/local_auth_repository.dart';
import 'package:linkaform_access_control/features/login/domain/repositories/remote_auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {

  AuthRepositoryImpl(this._localRepository, this._remoteRepository);
  
  final LocalAuthRepository _localRepository;
  final RemoteAuthRepository _remoteRepository;

  @override
  Future<void> login(dynamic response) async {
    await _localRepository.saveLoginResponse(response);
  }

  @override
  Future<void> logout() async {
    await _remoteRepository.logout();
    await _localRepository.clearLoginResponse();
  }

  @override
  Future<LoginResponse?> getStoredLoginResponse() {
    return _localRepository.getStoredLoginResponse();
  }


}