import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_module/login/domain/api/login_data_source.dart';

import '../domain/api/login_repository.dart';
import '../domain/entities/login.dart';

final loginRepositoryProvider = Provider((ref) =>
    LoginRepositoryImpl(dataSource: ref.read(loginDataSourceProvider)));

class LoginRepositoryImpl implements LoginRepository {
  final LoginDataSource dataSource;
  LoginRepositoryImpl({required this.dataSource});

  @override
  Future<dynamic> login(LoginCredentialsEntity credentials) async =>
      dataSource.login(credentials);
}
