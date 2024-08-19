import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:linkaform_access_control/features/login/domain/repositories/remote_auth_repository.dart';

class RemoteAuthRepositoryImpl implements RemoteAuthRepository {

  RemoteAuthRepositoryImpl({required this.baseUrl});

  final String baseUrl;


  @override
  Future<void> logout() async {
    try {
     await http.post(
        Uri.parse('$baseUrl/user_admin/logout/'),
      );
    } catch (error) {
      throw Exception(error);
    }

  }
}