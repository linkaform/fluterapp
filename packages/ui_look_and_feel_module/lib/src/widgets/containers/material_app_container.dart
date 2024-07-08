import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:translations_module/generated/l10n.dart';
import 'package:translations_module/provider/translations_provider.dart';
import 'package:ui_look_and_feel_module/src/providers/translation_providers.dart';

class MaterialAppContainer extends ConsumerStatefulWidget {
  final Widget baseWidget;
  const MaterialAppContainer({
    Key? key,
    required this.baseWidget,
  }) : super(key: key);

  @override
  ConsumerState createState() => _MaterialAppContainerState();
}

class _MaterialAppContainerState extends ConsumerState<MaterialAppContainer> {
  @override
  Widget build(BuildContext context) {
    final widgetState = ref.watch(translationWidgetStateProvider);
    final widgetStateNotifier =
        ref.watch(translationWidgetStateProvider.notifier);

    ref.listen<AsyncValue<S>>(
      translationProvider,
      (previous, next) {
        next.when(
          loading: () => widgetStateNotifier.changeWidgetState(
            widgetState: TranslationWidgetState.Loading,
          ),
          data: (translations) => widgetStateNotifier.changeWidgetState(
            widgetState: TranslationWidgetState.Success,
            translations: translations,
          ),
          error: (error, stack) => widgetStateNotifier.changeWidgetState(
            widgetState: TranslationWidgetState.Error,
            errorText: error.toString(),
          ),
        );
      },
    );

    return _buildContainer(
      state: widgetState,
      rootWidget: widget.baseWidget,
    );
  }

  Widget _buildContainer({
    required TranslationState state,
    required Widget rootWidget,
  }) {
    switch (state.widgetState) {
      case TranslationWidgetState.Success:
        return _buildMaterialApp(
          locale: ref.watch(localeProvider),
          localizationsDelegates: [
            state.translationDelegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: state.translationDelegate.supportedLocales,
          home: rootWidget,
        );
      case TranslationWidgetState.Error:
        return _buildMaterialApp(
          home: Scaffold(
            body: Center(
              child: Text(state.errorText ?? 'Error'),
            ),
          ),
        );
      case TranslationWidgetState.Loading:
      default:
        return _buildMaterialApp(
          home: Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
    }
  }

  Widget _buildMaterialApp({
    Locale? locale,
    List<LocalizationsDelegate>? localizationsDelegates,
    List<Locale>? supportedLocales,
    required Widget home,
  }) {
    return MaterialApp(
      locale: locale,
      localizationsDelegates: localizationsDelegates ??
          [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            S.delegate,
          ],
      supportedLocales: supportedLocales ?? [Locale('es')],
      home: home,
    );
  }
}
