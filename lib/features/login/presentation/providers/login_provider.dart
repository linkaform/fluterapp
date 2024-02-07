import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'login_state.dart';

class LoginNotifier extends StateNotifier<LoginState> {
  LoginNotifier() : super(LoginState());

  Future<void> login() async {
    state = state.copyWith(isLoading: true, error: null);
    await Future.delayed(const Duration(seconds: 2));
    state = state.copyWith(isLoading: false, error: 'Error message');
  }
}

final loginNotifierProvider =
    StateNotifierProvider<LoginNotifier, LoginState>((ref) {
  return LoginNotifier();
});
