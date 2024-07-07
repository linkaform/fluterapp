import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_module/core/utils/login_validators.dart';
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
    if (state.loginSuccess) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
            SnackBar(
              content: Text('localizationText.successfully_message'),
              backgroundColor: Colors.green,
            ),
          )
          .closed
          .then((_) => widget.onResultFunction());
    } else if (state.error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('"ocalizationText.failure_message" ${state.error}'),
          backgroundColor: Colors.red,
        ),
      );
    }

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
                      decoration: InputDecoration(
                        labelText: FieldType.Email.name,
                        border: OutlineInputBorder(),
                      ),
                      validator: (_) => validateValue(_, FieldType.Email),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: _isPasswordVisible,
                      decoration: InputDecoration(
                        labelText: FieldType.Password.name,
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
                      validator: (_) => validateValue(_, FieldType.Password),
                    ),
                  ],
                ),
              ),
            ),
            state.isLoading
                ? const CircularProgressIndicator()
                : OutlinedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                'localizationText.validating_credentials_message'),
                          ),
                        );
                        _login;
                      }
                    },
                    child: Text('localizationText.login_button_text'),
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
