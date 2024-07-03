import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wilt/wilt.dart';

import '../../infrastructure/login_data_source_impl.dart';
import '../entities/login.dart';

final loginDataSourceProvider = Provider<LoginDataSource>((ref) {
  return LoginDataSourceImpl(client: Wilt('cdb.linkaform.com'));
});

abstract class LoginDataSource {
  Future<Either<WiltException, dynamic>> login(
      LoginCredentialsEntity credentials);
}
