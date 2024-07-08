import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:linkaform_access_control/features/home/presentation/screens/home_screen.dart';
import 'package:login_module/login/presentation/views/login_screen.dart';

final appRouterProvider = Provider((ref) => AppRoutes._appRouter);

class AppRoutes {
  static final _appRouter = GoRouter(
    initialLocation: LoginScreen.path,
    routes: [
      GoRoute(
          path: LoginScreen.path,
          name: LoginScreen.name,
          builder: (context, state) =>
              LoginScreen(resultPath: HomeScreen.path)),
      GoRoute(
        path: HomeScreen.path,
        name: HomeScreen.name,
        builder: (context, state) => const HomeScreen(),
      ),
    ],
  );
}
