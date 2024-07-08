import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:linkaform_access_control/features/home/presentation/screens/home_screen.dart';
import 'package:login_module/login/presentation/providers/login_provider.dart';
import 'package:login_module/login_module.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final loginState = ref.read(loginNotifierProvider);

  return GoRouter(
    initialLocation:
        loginState.loginSuccess ? HomeScreen.path : LoginScreen.path,
    routes: [
      GoRoute(
        path: LoginScreen.path,
        name: LoginScreen.name,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: HomeScreen.path,
        name: HomeScreen.name,
        builder: (context, state) => const HomeScreen(),
      ),
    ],
    redirect: (context, state) {
      final loggedIn = loginState.loginSuccess;
      final goingToLogin = state.uri.path == LoginScreen.path;

      if (!loggedIn && !goingToLogin) return LoginScreen.path;
      if (loggedIn && goingToLogin) return HomeScreen.path;
      return null;
    },
  );
});
