// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Linkaform`
  String get linkaformAppTitle {
    return Intl.message(
      'Linkaform',
      name: 'linkaformAppTitle',
      desc: '',
      args: [],
    );
  }

  /// `Please enter an email`
  String get enterEmailErrorMessage {
    return Intl.message(
      'Please enter an email',
      name: 'enterEmailErrorMessage',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a password`
  String get enterPasswordErrorMessage {
    return Intl.message(
      'Please enter a password',
      name: 'enterPasswordErrorMessage',
      desc: '',
      args: [],
    );
  }

  /// `Did you miss the password?`
  String get missedPasswordLabel {
    return Intl.message(
      'Did you miss the password?',
      name: 'missedPasswordLabel',
      desc: '',
      args: [],
    );
  }

  /// `Login was successfully`
  String get successfullyMessage {
    return Intl.message(
      'Login was successfully',
      name: 'successfullyMessage',
      desc: '',
      args: [],
    );
  }

  /// `Ops! There's an error when we try to login: `
  String get failureMessage {
    return Intl.message(
      'Ops! There\'s an error when we try to login: ',
      name: 'failureMessage',
      desc: '',
      args: [],
    );
  }

  /// `Validating $...`
  String get validatingMessage {
    return Intl.message(
      r'Validating $...',
      name: 'validatingMessage',
      desc: '',
      args: [],
    );
  }

  /// `Credentials`
  String get credentialsLabel {
    return Intl.message(
      'Credentials',
      name: 'credentialsLabel',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get loginButtonText {
    return Intl.message(
      'Login',
      name: 'loginButtonText',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'es'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
