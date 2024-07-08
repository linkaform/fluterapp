import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui_look_and_feel_module/module_exports.dart';
import '../providers/login_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static String path = '/login';
  final Function() onResultFunction;

  const LoginScreen({
    super.key,
    required this.onResultFunction,
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
          .then((_) => widget.onResultFunction());
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
