import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:translations_module/generated/l10n.dart';

/// This provider allows you to **change the translation language**
/// into every app that use the texts from lkf context.
final localeProvider = StateProvider<Locale>(
  (ref) => Locale(Intl.getCurrentLocale()),
);

/// This class is the base to return the translations generated
class TranslationNotifier extends AsyncNotifier<S> {
  @override
  FutureOr<S> build() async {
    final locale = ref.watch(localeProvider);
    return S.load(locale);
  }
}

/// This provider allows you to **get the message translated in the language of
/// the device** into every app that use the texts from lkf context.
final translationProvider = AsyncNotifierProvider<TranslationNotifier, S>(() {
  return TranslationNotifier();
});
