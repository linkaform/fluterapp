import 'dart:async';
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linkaform/core/common/config/app_shared_preferences.dart';
import 'package:wilt/wilt.dart';

import '../../features/login/domain/entities/login.dart';
import 'api_calls.dart';

final credentialsProvider = Provider<LoginCredentials>((ref) {
  final credentialsFromSharedPreference = ref.read(sharedPreferencesProvider).getStringList('credentials');
  return LoginCredentials(
    username: credentialsFromSharedPreference?.first ?? '',
    password: credentialsFromSharedPreference?.last ?? '',
  );
});

final apiProvider = Provider<ApiProvider>((ref) {
  // Create an instance of Dio and also instantiate the credentials
  final credentials = ref.read(credentialsProvider);
  return ApiProvider(wilt: Wilt('cdb.linkaform.com'), credentials: credentials);
});

class ApiProvider implements ApiCalls {
  final Wilt _wilt;
  final LoginCredentials _credentials;

  ApiProvider({required Wilt wilt, required LoginCredentials credentials}) : _wilt = wilt, _credentials = credentials;

  Future<Either<String, List<dynamic>>> getAllDatabases() async {
    try {
      _wilt.login(_credentials.username, _credentials.password);
      final response = await _wilt.getAllDbs();
      final values =  jsonDecode(response['jsonCouchResponse'].toString());
      return Right(values);
    } catch (e) {
      if (e is DioException) {
        return Left(e.message.toString());
      }

      return Left(e.toString());
    }
  }


  @override
  Future<Either<String, List<dynamic>>> get(String url,
      {Map<String, String>? headers}) async {
    try {
      _wilt.login(_credentials.username, _credentials.password);
      _wilt.db = url;
      final response = await _wilt.getAllDocs();
      final values =  jsonDecode(response['jsonCouchResponse']['rows'].toString());
      return Right(values);
    } catch (e) {
      if (e is DioException) {
        return Left(e.message.toString());
      }

      return Left(e.toString());
    }
  }

  Future<Either<String, Map<String, dynamic>>> getDocData(
      String url, String docId,
      {Map<String, String>? headers}) async {
    try {
      _wilt.login(_credentials.username, _credentials.password);
      _wilt.db = url;
      final response = await _wilt.getDocument(docId);
      final values = jsonDecode(response['jsonCouchResponse'].toString());
      return Right(values);
    } catch (e) {
      if (e is DioException) {
        return Left(e.message.toString());
      }

      return Left(e.toString());
    }
  }

  Wilt getClientInstance(String databaseName) {
    _wilt.login(_credentials.username, _credentials.password);
    _wilt.db = databaseName;
    _wilt.startChangeNotification();
    return _wilt;
  }
}
