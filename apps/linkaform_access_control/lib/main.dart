import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/find_locale.dart';
import 'package:linkaform_access_control/features/home/presentation/screens/home_screen.dart';
import 'package:login_module/login/presentation/views/login_screen.dart';
import 'package:ui_look_and_feel_module/ui_look_and_feel_module.dart';

Future<void> main() async {
  await initializeApp();
  runApp(
    ProviderScope(
      child: MaterialAppContainer(
        baseWidget: LoginScreen(
          resultPath: HomeScreen.name,
        ),
      ),
    ),
  );
}

Future<void> initializeApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await findSystemLocale();
}
