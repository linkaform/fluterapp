import 'package:dartz/dartz.dart';
import 'package:wilt/wilt.dart';

import '../domain/api/login_data_source.dart';
import '../domain/entities/login.dart';

class LoginDataSourceImpl implements LoginDataSource {
  final Wilt client;
  LoginDataSourceImpl({required this.client});

  @override
  Future<Either<WiltException, dynamic>> login(
      LoginCredentialsEntity credentials) async {
    try {
      Future.delayed(
        const Duration(seconds: 1),
        () => client.login(
          credentials.username,
          credentials.password,
        ),
      );
      final response = await client.getSession();
      return Right(response);
    } catch (e) {
      return Left(WiltException(e.toString()));
    }
  }
}
