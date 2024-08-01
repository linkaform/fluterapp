import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linkaform/core/rest_config/api_provider.dart';

final getAllDBProvider = FutureProvider((ref) => ref.watch(apiProvider).getAllDatabases());