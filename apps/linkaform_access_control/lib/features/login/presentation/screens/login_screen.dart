import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linkaform_access_control/core/router/app_router_provider.dart';
import 'package:linkaform_access_control/features/login/presentation/providers/auth_providers.dart';
import 'package:linkaform_access_control/features/start_turn/presentation/screens/start_turn_screen.dart';
import 'package:login_module/login/presentation/providers/login_provider.dart';
import 'package:login_module/login/presentation/providers/state/login_state.dart';
import 'package:login_module/login/presentation/views/login_module_screen.dart';
import 'package:ui_look_and_feel_module/ui_look_and_feel_module.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  static const String path = '/';
  static const String name = 'login';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final translation = ref.watch(translationWidgetStateProvider).translations;

    ref.listen<LoginState>(loginNotifierProvider, (previous, next) {
      if (next.loginSuccess) {
        _showSnackBar(
          context,
          translation.successfullyMessage,
          Colors.green,
          ref,
        );
      } else if (next.error != null && !next.errorShown) {
        _showSnackBar(context, translation.failureMessage, Colors.red, ref);
        ref.read(loginNotifierProvider.notifier).markErrorAsShown();
      }
    });

    return const LoginModuleScreen();
  }

  void _showSnackBar(
    BuildContext context,
    String message,
    Color color,
    WidgetRef ref,
  ) {
    ScaffoldMessenger.of(context)
        .showSnackBar(buildSuccessSnackBar(message, color))
        .closed
        .then((_) async {
      final result = ref.read(loginNotifierProvider);
      if (result.loginSuccess) {
        await ref.read(authRepositoryProvider).login(result.response);
        await ref.read(appRouterProvider).pushReplacement(StartTurnScreen.path);
      }
    });
  }
}
