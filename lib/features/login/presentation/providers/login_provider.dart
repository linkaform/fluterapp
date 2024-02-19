import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linkaform/features/login/domain/api/login_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/common/config/app_shared_preferences.dart';
import '../../domain/entities/login.dart';
import 'login_state.dart';

final loginNotifierProvider = StateNotifierProvider<LoginNotifier, LoginState>(
  (ref) => LoginNotifier(
    dataSource: ref.read(loginDataSourceProvider),
    sharedPreferences: ref.read(sharedPreferencesProvider),
  ),
);

class LoginNotifier extends StateNotifier<LoginState> {
  final LoginDataSource dataSource;
  final SharedPreferences sharedPreferences;

  LoginNotifier({
    required this.dataSource,
    required this.sharedPreferences,
  }) : super(LoginState());

  Future<Either<DioException, dynamic>> login(LoginCredentials userData) async {
    try {
      state = state.copyWith(isLoading: true);
      final res = await dataSource
          .login(userData.username, userData.password)
          .whenComplete(
        () {
          state = state.copyWith(isLoading: false);
          sharedPreferences.setBool(
            'isLoggedIn',
            true,
          );
        },
      );
      return Right(res);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: '$e.toString()');
      return Left(
        DioException(
          requestOptions: RequestOptions(path: ''),
          response: Response(requestOptions: RequestOptions(path: '')),
          error: e.toString(),
        ),
      );
    }
  }
}
