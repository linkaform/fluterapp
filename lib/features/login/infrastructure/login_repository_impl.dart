import 'package:dartz/dartz.dart';

import '../../../core/rest_config/api_provider.dart';
import '../domain/api/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  final ApiProvider apiProvider;
  LoginRepositoryImpl({required this.apiProvider});

  @override
  Future<Either<String, dynamic>> login(
      String username, String password) async {
    return await apiProvider
        .get('http://$username:$password@cdb.linkaform.com:5984/_users/');
  }
}
