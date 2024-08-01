import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linkaform/features/login/domain/api/login_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/common/config/app_shared_preferences.dart';
import 'login_state.dart';

final loginNotifierProvider = StateNotifierProvider<LoginNotifier, LoginState>(
  (ref) => LoginNotifier(
    dataSource: ref.watch(loginDataSourceProvider),
    sharedPreferences: ref.watch(sharedPreferencesProvider),
  ),
);

class LoginNotifier extends StateNotifier<LoginState> {
  final LoginDataSource dataSource;
  final SharedPreferences sharedPreferences;

  LoginNotifier({
    required this.dataSource,
    required this.sharedPreferences,
  }) : super(LoginState());

  Future<void> login(String username, String password) async {
    state = state.copyWith(isLoading: true);
    Future.wait([dataSource.login(username, password)]).then((value) {
      sharedPreferences.setStringList('credentials', [username, password]);
      state = state.copyWith(isLoading: false, loginSuccess: true);
    }, onError: (error) {
      state = state.copyWith(isLoading: false, error: error.toString());
    });
  }
}
