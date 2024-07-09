import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:linkaform_access_control/features/home/presentation/screens/home_screen.dart';
import 'package:linkaform_access_control/features/login/presentation/views/login_screen.dart';
import 'package:login_module/login/presentation/providers/login_provider.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final loginState = ref.watch(loginNotifierProvider);

  return GoRouter(
    initialLocation:
        loginState.loginSuccess ? HomeScreen.path : LoginScreen.path,
    routes: [
      GoRoute(
        path: LoginScreen.path,
        pageBuilder: (context, state) => CustomTransitionPage(
          child: const LoginScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return _createScaleRotateTransition(animation, child);
          },
        ),
        redirect: (context, state) {
          if (loginState.loginSuccess && state.path == LoginScreen.path) {
            return HomeScreen.path;
          }
          return null;
        },
      ),
      GoRoute(
        path: HomeScreen.path,
        pageBuilder: (context, state) => CustomTransitionPage(
          child: const HomeScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return _createSlideTransition(animation, child);
          },
        ),
        redirect: (context, state) {
          if (!loginState.loginSuccess && state.path == HomeScreen.path) {
            return LoginScreen.path;
          }
          return null;
        },
      ),
    ],
  );
});

Widget _createScaleRotateTransition(Animation<double> animation, Widget child) {
  return ScaleTransition(
    scale: Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animation,
        curve: Curves.easeInOut,
      ),
    ),
    child: RotationTransition(
      turns: Tween<double>(begin: 0.5, end: 1.0).animate(
        CurvedAnimation(
          parent: animation,
          curve: Curves.easeInOut,
        ),
      ),
      child: child,
    ),
  );
}

Widget _createSlideTransition(Animation<double> animation, Widget child) {
  return SlideTransition(
    position: Tween<Offset>(
      begin: const Offset(1, 0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: animation,
        curve: Curves.easeInOut,
      ),
    ),
    child: child,
  );
}
