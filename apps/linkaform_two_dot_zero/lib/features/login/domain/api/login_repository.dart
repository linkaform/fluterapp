import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wilt/wilt.dart';
import '../../../../core/common/config/app_shared_preferences.dart';
import '../../infrastructure/login_repository_impl.dart';

final loginRepository = Provider<LoginRepository>((ref) {
  final sharedPreferences = ref.watch(sharedPreferencesProvider);
  return LoginRepositoryImpl(sharedPreferences: sharedPreferences);
});

abstract class LoginRepository {
  Future<Either<WiltException, dynamic>> login(String username, String password);
}
