import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linkaform/core/rest_config/api_provider.dart';

final getDBDocsProvider = FutureProvider.family<dynamic, String>(
  (ref, params) => ref.watch(apiProvider).get(params),
);
