import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:translations_module/generated/l10n.dart';
import 'package:translations_module/provider/translations_provider.dart';

class MaterialAppContainer extends ConsumerStatefulWidget {
  final Widget baseWidget;
  final GoRouter router;
  const MaterialAppContainer({
    Key? key,
    required this.baseWidget,
    required this.router,
  }) : super(key: key);

  @override
  ConsumerState createState() => _MaterialAppContainerState();
}

class _MaterialAppContainerState extends ConsumerState<MaterialAppContainer> {
  @override
  Widget build(BuildContext context) {
    final locale = ref.watch(localeProvider);
    final futureTranslations = ref.watch(translationProvider.future);

    return FutureBuilder(
      future: futureTranslations,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildLoadingScreen();
        } else if (snapshot.hasError) {
          return _buildErrorScreen(snapshot.error);
        } else if (snapshot.hasData) {
          final translationDelegate = snapshot.data!;
          return _buildMaterialApp(context, locale, translationDelegate);
        } else {
          return _buildErrorScreen('Unknown error occurred');
        }
      },
    );
  }

  Widget _buildMaterialApp(
    BuildContext context,
    Locale? locale,
    S translationDelegate,
  ) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: MaterialApp.router(
        locale: locale,
        localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        routerDelegate: widget.router.routerDelegate,
        routeInformationParser: widget.router.routeInformationParser,
        routeInformationProvider: widget.router.routeInformationProvider,
      ),
    );
  }

  Widget _buildLoadingScreen() {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  Widget _buildErrorScreen(Object? error) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        body: Center(
          child: Text('Error: $error'),
        ),
      ),
    );
  }
}
