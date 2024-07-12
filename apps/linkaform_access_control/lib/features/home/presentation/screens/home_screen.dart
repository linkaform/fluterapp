import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui_look_and_feel_module/module_exports.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});
  static String path = '/home';
  static String name = 'home';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final translations = ref.watch(translationWidgetStateProvider).translations;
    return Scaffold(
      appBar: AppBar(
        title: Text(translations.linkaformAppTitle),
      ),
    );
  }
}
