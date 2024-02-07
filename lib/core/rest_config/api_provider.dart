import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'api_calls.dart';

final apiProvider = Provider<ApiProvider>((ref) {
  // Create an instance of Dio
  return ApiProvider(dio: Dio());
});

class ApiProvider implements ApiCalls {
  final Dio _dio;

  ApiProvider({required Dio dio}) : _dio = dio;

  @override
  Future<Either<String, dynamic>> get(String url,
      {Map<String, String>? headers}) async {
    try {
      var response = await _dio.get(url, options: Options(headers: headers));
      return Right(response.data);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
