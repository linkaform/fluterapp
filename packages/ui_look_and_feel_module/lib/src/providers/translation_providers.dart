import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:translations_module/generated/l10n.dart';

enum TranslationWidgetState { Loading, Success, Error }

final translationWidgetStateProvider =
    StateNotifierProvider<TranslationStateNotifier, TranslationState>(
        (ref) => TranslationStateNotifier());

class TranslationStateNotifier extends StateNotifier<TranslationState> {
  TranslationStateNotifier() : super(TranslationState.initial());

  changeWidgetState({
    TranslationWidgetState? widgetState,
    String? errorText,
    S? translations,
  }) =>
      state = state.copyWith(
        widgetState: widgetState,
        errorText: errorText,
        translations: translations,
      );
}

class TranslationState {
  final TranslationWidgetState? widgetState;
  final String? errorText;
  final S translations;

  TranslationState({
    this.widgetState,
    this.errorText,
    required this.translations,
  });

  factory TranslationState.initial() {
    return TranslationState(
      widgetState: TranslationWidgetState.Loading,
      translations: S(),
    );
  }

  AppLocalizationDelegate get translationDelegate => S.delegate;

  TranslationState copyWith({
    String? errorText,
    TranslationWidgetState? widgetState,
    S? translations,
  }) =>
      TranslationState(
        widgetState: widgetState ?? this.widgetState,
        errorText: errorText ?? this.errorText,
        translations: translations ?? this.translations,
      );
}
