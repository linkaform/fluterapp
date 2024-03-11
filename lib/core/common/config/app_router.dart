import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../features/users/presentation/screens/user_db_screen.dart';
import '../pages.dart';
import 'app_shared_preferences.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final sharedPreferences = ref.read(sharedPreferencesProvider);
  final isLoggedIn = sharedPreferences.getStringList('credentials') ?? [];
  return GoRouter(
    initialLocation: isLoggedIn.isEmpty ? '/' : HomeScreen.path,
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: HomeScreen.path,
        builder: (context, state) => const HomeScreen(),
        routes: [
          GoRoute(
            path: 'user_db/:db',
            name: 'user_db',
            builder: (context, state) => UserDBScreen(
              dbName: state.pathParameters['db'] ?? '',
            ),
          ),
        ],
      ),
    ],
  );
});
