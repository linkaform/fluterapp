class LoginState {
  final bool isLoading;
  final String? error;

  LoginState({
    this.isLoading = true,
    this.error,
  });

  LoginState copyWith({
    bool? isLoading,
    String? error,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
