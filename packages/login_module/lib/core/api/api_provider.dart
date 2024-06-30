import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

///
/// This class is the base for every petition that we want to implement in
/// our project. Don't change the implementation here if you want to change
/// the behavior of the call. Insted extend and override the method in your own class.
///
abstract class ApiCalls {
  ///  This method are the base for ***retrieve*** data from data-rest.
  Future<Either<String, dynamic>> get(
    String url, {
    Map<String, String>? headers,
  });
}

final interceptorProvider = Provider.family<Interceptor, String>(
  (ref, environment) => environment == 'Development'
      ? PrettyDioLogger(
          request: true,
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: true,
          maxWidth: 90)
      : PrettyDioLogger(
          request: false,
          requestHeader: false,
          requestBody: false,
          responseBody: false,
          responseHeader: false,
          error: false,
          compact: false,
        ),
);

/// * This provider is the easy way to use client and his properties to consume the data.
final dioClientProvider = Provider<Dio>(
  (ref) => Dio(
    BaseOptions(
      baseUrl: '',
      headers: {},
    ),
  )..interceptors.add(
      ref.watch(
        interceptorProvider('Development'),
      ),
    ),
);

/// * This provider is the easy way to use the apiCalls methods using dio and this class.
final apiCallProvider = Provider<ApiCalls>(
  (ref) => ApiCallImpl(
    dioClient: ref.read(dioClientProvider),
  ),
);

class ApiCallImpl extends ApiCalls {
  final Dio dioClient;
  ApiCallImpl({required this.dioClient});
  @override
  Future<Either<String, dynamic>> get(String url,
      {Map<String, String>? headers}) async {
    try {
      /// TODO: Replace this implementation for the original api implementation.
      //final response = await dioClient.get(url);
      //return response.data != null ? Right(response) : Right('');
      return Right('Success');
    } catch (error) {
      return error is DioException
          ? Left('${error.message as DioException}')
          : Left('${error.toString()}');
    }
  }
}
