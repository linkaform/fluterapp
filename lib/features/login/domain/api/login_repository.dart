import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/rest_config/api_provider.dart';
import '../../infrastructure/login_repository_impl.dart';

final loginRepository = Provider<LoginRepository>((ref) {
  return LoginRepositoryImpl(apiProvider: ref.read(apiProvider));
});

abstract class LoginRepository {
  Future<void> login(String username, String password);
}
