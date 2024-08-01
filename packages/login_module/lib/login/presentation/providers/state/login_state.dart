class LoginState {
  final bool isLoading;
  final bool loginSuccess;
  final String? error;
  final bool errorShown;
  final bool navigateToHome;

  LoginState({
    this.isLoading = false,
    this.loginSuccess = false,
    this.error,
    this.errorShown = false,
    this.navigateToHome = false,
  });

  LoginState copyWith({
    bool? isLoading,
    bool? loginSuccess,
    String? error,
    bool? errorShown,
    bool? navigateToHome,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      loginSuccess: loginSuccess ?? this.loginSuccess,
      error: error ?? this.error,
      errorShown: errorShown ?? this.errorShown,
      navigateToHome: navigateToHome ?? this.navigateToHome,
    );
  }
}
