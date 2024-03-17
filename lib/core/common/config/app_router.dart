import '../core_exports.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final sharedPreferences = ref.read(sharedPreferencesProvider);
  final isLoggedIn = sharedPreferences.getStringList('credentials') ?? [];
  return GoRouter(
    initialLocation: isLoggedIn.isEmpty ? LoginScreen.path : HomeScreen.path,
    routes: [
      GoRoute(
        path: LoginScreen.path,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: HomeScreen.path,
        builder: (context, state) => const HomeScreen(),
        routes: [
          GoRoute(
            path: DatabaseDocsScreen.path,
            name: DatabaseDocsScreen.name,
            builder: (context, state) => DatabaseDocsScreen(
              dbName: state.pathParameters['db'] ?? '',
            ),
          ),
        ],
      ),
    ],
  );
});
