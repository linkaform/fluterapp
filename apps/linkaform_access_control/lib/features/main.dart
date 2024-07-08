import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/find_locale.dart';
import 'package:ui_look_and_feel_module/ui_look_and_feel_module.dart';

Future<void> main() async {
  await initializeApp();
  runApp(
    ProviderScope(
      child: MaterialAppContainer(
        baseWidget: Container(),
      ),
    ),
  );
}

Future<void> initializeApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await findSystemLocale();
}
