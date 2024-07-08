import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui_look_and_feel_module/constants/images_constants.dart';
import 'package:ui_look_and_feel_module/src/providers/translation_providers.dart';

class LinkaformLogoWidget extends ConsumerWidget {
  final double? height;
  final double? width;
  const LinkaformLogoWidget({
    super.key,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final translations = ref.watch(translationWidgetStateProvider).translations;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          LogosConstants.linkaformLogo,
          height: height ?? 100.0,
          width: width,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Text(translations.linkaformAppTitle),
        )
      ],
    );
  }
}
