import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_provider.dart';
import '../../infrastructure/login_data_source_impl.dart';
import '../entities/login.dart';

final loginDataSourceProvider = Provider<LoginDataSource>((ref) {
  return LoginDataSourceImpl(
    client: Dio(
      BaseOptions(
        baseUrl: 'https://app.linkaform.com/api/infosync/',
        headers: {},
      ),
    )..interceptors.add(
        ref.watch(
          interceptorProvider('Development'),
        ),
    ),
  );
});

abstract class LoginDataSource {
  Future<Either<DioException, dynamic>> login(
      LoginCredentialsEntity credentials);
}
