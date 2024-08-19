import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linkaform_access_control/core/services/shared_preferences_service.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/login/domain/entities/login_response.dart';
import '../../features/login/infrastructure/repositories/impl/local_auth_repository_impl.dart';

abstract class DioMethods {
  Future<Either<String, dynamic>> get({required String url});

  Future<Either<String, dynamic>> post({
    required String url,
    required Map<String, dynamic> body,
  });
}

final interceptorProvider = Provider.family<Interceptor, String>(
  (ref, environment) => environment == 'Development'
      ? PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
        )
      : PrettyDioLogger(
          request: false,
          responseBody: false,
          error: false,
          compact: false,
        ),
);

final dioClientProvider = Provider<Dio>(
  (ref) => Dio(
    BaseOptions(
      baseUrl: 'https://app.linkaform.com/api/infosync/',
      headers: {},
    ),
  )..interceptors.add(
      ref.watch(
        interceptorProvider('Development'),
      ),
    ),
);

final apiCallProvider = Provider<DioMethods>(
  (ref) => ApiCallImpl(
    dioClient: ref.read(dioClientProvider),
    sharedPreferences: ref.read(sharedPreferencesProvider),
  ),
);

class ApiCallImpl extends DioMethods {
  ApiCallImpl({
    required this.dioClient,
    required this.sharedPreferences,
  });

  final Dio dioClient;
  final SharedPreferences sharedPreferences;

  Map<String, String> get headers {
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'jwt ${(loginData[0] as ResponseData).jwt}',
      'Cookie': (loginData[1] as HeadersData)
          .setCookie
          .map((element) => element)
          .join(';'),
    };
    return headers;
  }

  List<dynamic> get loginData {
    final savedLoginData =
        sharedPreferences.getString(LocalAuthRepositoryImpl.loginResponseKey);
    final headers =
        sharedPreferences.getString(LocalAuthRepositoryImpl.headersKey);

    final encodedData = LoginResponse(
      response: savedLoginData ?? '',
      headers: headers ?? '',
    );

    final parsedResponse = encodedData.responseData;
    final parsedHeaders = encodedData.headersData;

    return [parsedResponse, parsedHeaders];
  }

  @override
  Future<Either<String, dynamic>> get({required String url}) async {
    try {
      final response = await dioClient.get(url);
      return response.data != null ? Right(response) : const Right('');
    } catch (error) {
      return error is DioException
          ? Left('${error.message! as DioException}')
          : Left(error.toString());
    }
  }

  @override
  Future<Either<String, dynamic>> post({
    required String url,
    required Map<String, dynamic> body,
  }) async {
    try {
      final response = await dioClient.post(
        url,
        data: body,
        options: Options(
          method: 'POST',
          headers: headers,
        ),
      );
      final data = jsonEncode(response.data);
      return Right(data);
    } catch (error) {
      return error is DioException
          ? Left('${error.message! as DioException}')
          : Left(error.toString());
    }
  }
}
