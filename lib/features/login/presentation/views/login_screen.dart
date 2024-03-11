import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linkaform/core/common/pages.dart';

import '../../../../core/common/config/app_router.dart';
import '../../domain/entities/login.dart';
import '../providers/login_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends ConsumerState<LoginScreen> {
  var _isPasswordVisible = true;
  var _isLoading = false;
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
            _isLoading ? const CircularProgressIndicator() : OutlinedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Validating credentials...')),
                  );
                 ref.read(loginProvider(LoginCredentials(username: _emailController.text, password: _passwordController.text)))
                     .when(data: (data) {
                       setState(() {
                         _isLoading = false;
                       });

                       ScaffoldMessenger.of(context).showSnackBar(
                         const SnackBar(
                           content: Text('Login successful'),
                           backgroundColor: Colors.green,
                         ),
                       );
                       ref.read(appRouterProvider).pushReplacement(HomeScreen.path);

                 }, error: (error, _) => ScaffoldMessenger.of(context).showSnackBar(
                   SnackBar(
                     content: Text('Error: $error'),
                     backgroundColor: Colors.red,
                   ),
                 ), loading: () => setState(() {
                   _isLoading = true;
                 }));
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

  
}
