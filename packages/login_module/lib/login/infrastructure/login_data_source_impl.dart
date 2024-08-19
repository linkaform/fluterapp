import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../domain/api/login_data_source.dart';
import '../domain/entities/login.dart';

class LoginDataSourceImpl implements LoginDataSource {
  LoginDataSourceImpl({required this.client});

  final Dio client;
  static final String loginPath = '/user_admin/login/';

  @override
  Future<Either<DioException, dynamic>> login(
      LoginCredentialsEntity credentials) async {
    try {
      final response = await client.post(
        loginPath,
        data: {
          'username': credentials.username,
          'password': credentials.password,
        },
      );
      return Right(response);
    } catch (e) {
      return Left(
        DioException(
          requestOptions: RequestOptions(
            path: loginPath,
          ),
          error: e,
        ),
      );
    }
  }
}
