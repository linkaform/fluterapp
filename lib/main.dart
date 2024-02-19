import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linkaform/core/common/config/app_shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/common/core_exports.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Future.wait([
    SharedPreferences.getInstance(),
  ]).then((value) => runApp(
        ProviderScope(
          overrides: [
            sharedPreferencesProvider.overrideWithValue(value[0]),
          ],
          child: const MyApp(),
        ),
      ));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      theme: AppTheme.themeData,
      routerConfig: ref.read(appRouterProvider),
    );
  }
}
