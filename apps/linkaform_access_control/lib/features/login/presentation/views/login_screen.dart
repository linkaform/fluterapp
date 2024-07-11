import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_module/login/presentation/views/login_module_screen.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});
  static String path = '/';
  static String name = 'login';

  @override
  Widget build(BuildContext context, WidgetRef ref) =>
      const LoginModuleScreen();
}
