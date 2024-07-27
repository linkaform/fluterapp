import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:linkaform_access_control/features/home/presentation/screens/home_screen.dart';
import 'package:linkaform_access_control/features/login/presentation/views/login_screen.dart';
import 'package:linkaform_access_control/features/scanner/presentation/screens/scan_qr_screen.dart';
import 'package:linkaform_access_control/features/scanner/presentation/screens/scan_result_screen.dart';
import 'package:linkaform_access_control/features/start_tour/presentation/screens/start_tour_screen.dart';

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
        path: StartTourScreen.path,
        builder: (context, state) => const StartTourScreen(),
      ),
      GoRoute(
        path: ScanQrScreen.path,
        builder: (context, state) => const ScanQrScreen(),
      ),
      GoRoute(
        path: ScanResultScreen.path,
        name: ScanResultScreen.name,
        builder: (context, state) => ScanResultScreen(
          code: state.pathParameters['code'] ?? '2',
        ),
      ),
    ],
  );
});
