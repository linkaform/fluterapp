import '../domain/api/login_data_source.dart';
import '../domain/api/login_repository.dart';

class LoginDataSourceImpl implements LoginDataSource {
  final LoginRepository repository;

  LoginDataSourceImpl({required this.repository});

  @override
  Future<void> login(String username, String password) async {
    repository.login(username, password);
  }
}
