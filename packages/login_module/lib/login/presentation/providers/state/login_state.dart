class LoginState {
  final bool isLoading;
  final bool loginSuccess;
  final String? error;
  final bool errorShown;

  LoginState({
    this.isLoading = false,
    this.loginSuccess = false,
    this.error,
    this.errorShown = false,
  });

  LoginState copyWith({
    bool? isLoading,
    bool? loginSuccess,
    String? error,
    bool? errorShown,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      loginSuccess: loginSuccess ?? this.loginSuccess,
      error: error ?? this.error,
      errorShown: errorShown ?? this.errorShown,
    );
  }
}
