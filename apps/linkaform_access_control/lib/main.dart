import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/find_locale.dart';
import 'package:linkaform_access_control/core/router/app_router_provider.dart';
import 'package:linkaform_access_control/core/services/shared_preferences_service.dart';
import 'package:linkaform_access_control/features/login/presentation/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ui_look_and_feel_module/ui_look_and_feel_module.dart';

Future<void> main() async {
  await initializeApp();
  final sharedPreferences = await SharedPreferences.getInstance();
  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
      ],
      child: const MyApp(),
    ),
  );
}

Future<void> initializeApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await findSystemLocale();
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.watch(appRouterProvider);

    return MaterialAppContainer(
      router: goRouter,
      baseWidget: const LoginScreen(),
    );
  }
}
