import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linkaform/features/login/domain/api/login_repository.dart';
import 'package:wilt/wilt.dart';

import '../../domain/entities/login.dart';

final loginProvider = FutureProvider.family<Either<WiltException, dynamic>, LoginCredentials>((ref, credentials) async {
  final repository = ref.watch(loginRepository);
  final response = await repository.login(credentials.username, credentials.password);
  return response;
});

