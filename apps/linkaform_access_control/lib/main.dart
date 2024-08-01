import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/find_locale.dart';
import 'package:linkaform_access_control/core/router/app_router_provider.dart';
import 'package:linkaform_access_control/features/home/presentation/screens/home_screen.dart';
import 'package:linkaform_access_control/features/login/login_screen.dart';
import 'package:login_module/login/presentation/providers/login_provider.dart';
import 'package:ui_look_and_feel_module/ui_look_and_feel_module.dart';

Future<void> main() async {
  await initializeApp();
  runApp(
    const ProviderScope(
      child: MyApp(),
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
    final loginState = ref.watch(loginNotifierProvider);

    return MaterialAppContainer(
      router: goRouter,
      baseWidget:
          loginState.loginSuccess ? const HomeScreen() : const LoginScreen(),
    );
  }
}
