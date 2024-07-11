import 'package:flutter/material.dart';
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

    ref.listen(loginNotifierProvider, (previous, next) {
      if (next.loginSuccess) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _showSnackBar(context, translation.successfullyMessage, Colors.green);
        });
      } else if (next.error != null && !next.errorShown) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _showSnackBar(context, translation.failureMessage, Colors.red);
          ref.read(loginNotifierProvider.notifier).markErrorAsShown();
        });
      }
    });

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: LinkaformLogoWidget(),
            ),
            LoginFormWidget(
                formKey: _formKey,
                emailController: _emailController,
                passwordController: _passwordController),
            Padding(
              padding: const EdgeInsets.only(
                top: 5.0,
                bottom: 40.0,
                right: 20.0,
              ),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  translation.missedPasswordLabel,
                ),
              ),
            ),
            LoginProgressButtonWidget(
                isLoading: state.isLoading,
                formKey: _formKey,
                function: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    ref
                        .watch(loginNotifierProvider.notifier)
                        .login(_emailController.text, _passwordController.text);
                  }
                }),
          ],
        ),
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context)
        .showSnackBar(buildSuccessSnackBar(message, color));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
