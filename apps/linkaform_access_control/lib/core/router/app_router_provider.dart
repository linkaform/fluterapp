import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:linkaform_access_control/features/home/presentation/screens/home_screen.dart';
import 'package:linkaform_access_control/features/login/presentation/screens/login_screen.dart';
import 'package:linkaform_access_control/features/scanner/presentation/screens/entry_passes_screen.dart';
import 'package:linkaform_access_control/features/scanner/presentation/screens/scan_qr_screen.dart';
import 'package:linkaform_access_control/features/start_turn/presentation/screens/start_turn_screen.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: LoginScreen.path,
    routes: [
      GoRoute(
        path: LoginScreen.path,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: HomeScreen.path,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: StartTurnScreen.path,
        builder: (context, state) => const StartTurnScreen(),
      ),
      GoRoute(
        path: ScanQrScreen.path,
        builder: (context, state) => const ScanQrScreen(),
      ),
      GoRoute(
        path: EntryPassesScreen.path,
        name: EntryPassesScreen.name,
        builder: (context, state) => const EntryPassesScreen(
          // code: state.pathParameters['code'] ?? '2',
        ),
      ),
    ],
  );
});
