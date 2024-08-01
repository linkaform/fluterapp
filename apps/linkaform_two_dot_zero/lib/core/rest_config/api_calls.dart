import 'package:dartz/dartz.dart';

abstract class ApiCalls {
  Future<Either<String, dynamic>> get(String url,
      {Map<String, String>? headers});
}
