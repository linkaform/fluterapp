import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wilt/wilt.dart';
import '../domain/api/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  final SharedPreferences sharedPreferences;

  LoginRepositoryImpl({required this.sharedPreferences});

  @override
  Future<Either<WiltException, dynamic>> login(
      String username, String password) async {
    try {
      final client = Wilt('cdb.linkaform.com');
      client.login(username, password);
      final response = await client.getSession().then((value) => sharedPreferences.setStringList('credentials', [username, password]));
      return Right(response);
    } catch (e) {
      return Left(WiltException(e.toString()));
    }
  }
}
