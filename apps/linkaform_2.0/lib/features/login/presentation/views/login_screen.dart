import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linkaform/core/common/pages.dart';

import '../../../../core/common/config/app_router.dart';
import '../providers/login_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static String path = '/';

  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends ConsumerState<LoginScreen> {
  var _isPasswordVisible = true;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(loginNotifierProvider);
    ref.listen(loginNotifierProvider, (previous, next) {
      next.loginSuccess
          ? ScaffoldMessenger.of(context)
              .showSnackBar(
                const SnackBar(
                  content: Text('Login successful'),
                  backgroundColor: Colors.green,
                ),
              )
              .closed
              .then((reason) async {
              await ref
                  .read(appRouterProvider)
                  .pushReplacement(HomeScreen.path);
            })
          : next.error != null
              ? ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(next.error!),
                    backgroundColor: Colors.red,
                  ),
                )
              : null;
    });

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo_colored.jpeg',
              height: 100,
            ),
            const SizedBox(height: 20),
            const Text(
              'Linkaform',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) => value == null || value.isEmpty
                          ? 'Please enter your email address'
                          : null,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: _isPasswordVisible,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () => showPassword(),
                        ),
                      ),
                      validator: (value) => value == null || value.isEmpty
                          ? 'Please enter your password'
                          : null,
                    ),
                  ],
                ),
              ),
            ),
            state.isLoading
                ? const CircularProgressIndicator()
                : OutlinedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Validating credentials...')),
                        );
                        _login();
                      }
                    },
                    child: const Text('Login'),
                  ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void showPassword() =>
      setState(() => _isPasswordVisible = !_isPasswordVisible);

  Future<void> _login() async {
    await ref
        .watch(loginNotifierProvider.notifier)
        .login(_emailController.text, _passwordController.text);
  }
}
