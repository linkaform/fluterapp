import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../infrastructure/login_data_source_impl.dart';
import 'login_repository.dart';

final loginDataSourceProvider = Provider<LoginDataSource>((ref) {
  return LoginDataSourceImpl(repository: ref.read(loginRepository));
});

abstract class LoginDataSource {
  Future<dynamic> login(String username, String password);
}
