import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ui_look_and_feel_module/module_exports.dart';
import '../providers/login_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static String path = '/';
  static String name = 'login';
  final String resultPath;

  const LoginScreen({
    super.key,
    required this.resultPath,
  });

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(loginNotifierProvider);
    final translation = ref.watch(translationWidgetStateProvider).translations;
    //SuccessfullySnackbar()
    if (state.loginSuccess) {
      ScaffoldMessenger.of(context)
          .showSnackBar(buildSuccessSnackBar(
              translation.successfullyMessage, Colors.green))
          .closed
          .then((_) => context.push(widget.resultPath));
    } else if (state.error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
          buildSuccessSnackBar(translation.failureMessage, Colors.red));
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
                function: () async => await ref
                    .watch(loginNotifierProvider.notifier)
                    //.login(_emailController.text, _passwordController.text),
                    .login(_emailController.text, _passwordController.text))
          ],
        ),
      ),
    );
  }
}
