import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui_look_and_feel_module/module_exports.dart';
import '../providers/login_provider.dart';

class LoginModuleScreen extends ConsumerStatefulWidget {
  static String path = '/';
  static String name = 'login';

  const LoginModuleScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends ConsumerState<LoginModuleScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(loginNotifierProvider);
    final translation = ref.watch(translationWidgetStateProvider).translations;

    /// Possible issue, when this toast is display, the controllers are clear
    if (state.loginSuccess) {
      SchedulerBinding.instance.addPersistentFrameCallback((_) {
        _showSnackBar(context, translation.successfullyMessage, Colors.green);
      });
    } else if (state.error != null && !state.errorShown) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        _showSnackBar(context, translation.failureMessage, Colors.red);
        ref.read(loginNotifierProvider.notifier).markErrorAsShown();
      });
    }

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LinkaformLogoWidget(),
            LoginFormWidget(
                formKey: _formKey,
                emailController: _emailController,
                passwordController: _passwordController),
            LoginProgressButtonWidget(
                isLoading: state.isLoading,
                formKey: _formKey,
                function: () => (_emailController.text.isNotEmpty == true &&
                        _passwordController.text.isNotEmpty == true)
                    ? ref
                        .watch(loginNotifierProvider.notifier)
                        .login(_emailController.text, _passwordController.text)
                    : ())
          ],
        ),
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context)
        .showSnackBar(buildSuccessSnackBar(message, color));
  }
}
