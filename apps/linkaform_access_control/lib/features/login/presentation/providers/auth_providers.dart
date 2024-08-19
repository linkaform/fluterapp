import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linkaform_access_control/core/services/shared_preferences_service.dart';
import 'package:linkaform_access_control/features/login/domain/entities/login_response.dart';
import 'package:linkaform_access_control/features/login/infrastructure/repositories/impl/auth_repository_impl.dart';
import 'package:linkaform_access_control/features/login/infrastructure/repositories/impl/local_auth_repository_impl.dart';
import 'package:linkaform_access_control/features/login/infrastructure/repositories/impl/remote_auth_repository_impl.dart';

final authRepositoryProvider = Provider<AuthRepositoryImpl>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  final localRepo = LocalAuthRepositoryImpl(prefs);
  final remoteRepo =
      RemoteAuthRepositoryImpl(baseUrl: 'https://api.example.com');
  return AuthRepositoryImpl(localRepo, remoteRepo);
});

final authStateProvider = StateNotifierProvider<AuthNotifier, AsyncValue<void>>(
  (ref) => AuthNotifier(
    ref.watch(authRepositoryProvider),
  ),
);

class AuthNotifier extends StateNotifier<AsyncValue<void>> {
  AuthNotifier(this._authRepository) : super(const AsyncValue.loading()) {
    _init();
  }

  final AuthRepositoryImpl _authRepository;

  Future<void> _init() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () async => _authRepository.getStoredLoginResponse(),
    );
  }

  Future<void> login(LoginResponse response) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _authRepository.login(response));
  }

  Future<void> logout() async {
    state = const AsyncValue.loading();
    await _authRepository.logout();
    state = const AsyncValue.data(null);
  }
}
