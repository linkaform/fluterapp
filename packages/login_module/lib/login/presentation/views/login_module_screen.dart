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
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailController.text = const String.fromEnvironment('username') ?? '';
    _passwordController.text = const String.fromEnvironment('password') ?? '';
  }


  @override
  Widget build(BuildContext context) {
    final state = ref.watch(loginNotifierProvider);
    final translation = ref.watch(translationWidgetStateProvider).translations;

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
                bottom: 30.0,
                right: 20.0,
              ),
              child: Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  style: LinkaformSecurityStyles.textHoveredButtonStyle,
                  child: Text(translation.missedPasswordLabel),
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

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
