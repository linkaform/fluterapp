import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_module/login/infrastructure/login_repository_impl.dart';
import 'state/login_state.dart';

final loginNotifierProvider = StateNotifierProvider<LoginNotifier, LoginState>(
  (ref) => LoginNotifier(repository: ref.read(loginRepositoryProvider)),
);

class LoginNotifier extends StateNotifier<LoginState> {
  final LoginRepositoryImpl repository;

  LoginNotifier({required this.repository}) : super(LoginState());

  Future<void> login(String username, String password) async {
    state = state.copyWith(isLoading: true);

    /// Mocked Login
    Future.delayed(
        Duration(seconds: 2), () => state = state.copyWith(isLoading: false));
    // Future.wait([dataSource.login(username, password)]).then((value) {
    //   sharedPreferences.setStringList('credentials', [username, password]);
    //   state = state.copyWith(isLoading: false, loginSuccess: true);
    // }, onError: (error) {
    //   state = state.copyWith(isLoading: false, error: error.toString());
    // });
  }
}
