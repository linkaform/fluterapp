import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../gen/assets.gen.dart';

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
    return Assets.images.fullLogo.image(
      height: height ?? 30.0,
      width: width,
    );
  }
}
