class LoginState {
  final bool isLoading;
  final bool loginSuccess;
  final String? error;

  LoginState({
    this.isLoading = false,
    this.loginSuccess = false,
    this.error,
  });

  LoginState copyWith({
    bool? isLoading,
    bool? loginSuccess,
    String? error,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      loginSuccess: loginSuccess ?? this.loginSuccess,
      error: error ?? this.error,
    );
  }
}
