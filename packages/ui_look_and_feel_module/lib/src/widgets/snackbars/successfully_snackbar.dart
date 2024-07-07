import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui_look_and_feel_module/src/providers/translation_providers.dart';

class SuccessfullySnackbar extends ConsumerWidget {
  const SuccessfullySnackbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final translation = ref.watch(translationWidgetStateProvider).translations;
    return SnackBar(
      content: Text(translation.successfullyMessage),
      backgroundColor: Colors.green,
    );
  }
}
