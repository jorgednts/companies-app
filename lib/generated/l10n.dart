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

  /// `Welcome to companies`
  String get loginScreenWelcomeText {
    return Intl.message(
      'Welcome to companies',
      name: 'loginScreenWelcomeText',
      desc: '',
      args: [],
    );
  }

  /// `Lorem ipsum dolor sit amet, contetur adipiscing elit. Nunc accumsan.`
  String get loginScreenIntroductionText {
    return Intl.message(
      'Lorem ipsum dolor sit amet, contetur adipiscing elit. Nunc accumsan.',
      name: 'loginScreenIntroductionText',
      desc: '',
      args: [],
    );
  }

  /// `E-mail`
  String get loginScreenFormEmailLabelText {
    return Intl.message(
      'E-mail',
      name: 'loginScreenFormEmailLabelText',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get loginScreenFormPasswordLabelText {
    return Intl.message(
      'Password',
      name: 'loginScreenFormPasswordLabelText',
      desc: '',
      args: [],
    );
  }

  /// `Sing in`
  String get loginScreenButtonText {
    return Intl.message(
      'Sing in',
      name: 'loginScreenButtonText',
      desc: '',
      args: [],
    );
  }

  /// `Enter a valid email address. Ex: abc@abc.com.br`
  String get loginScreenFormInvalidEmail {
    return Intl.message(
      'Enter a valid email address. Ex: abc@abc.com.br',
      name: 'loginScreenFormInvalidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Fill the field`
  String get loginScreenEmptyFormText {
    return Intl.message(
      'Fill the field',
      name: 'loginScreenEmptyFormText',
      desc: '',
      args: [],
    );
  }

  /// `Password must contain at least 8 characters`
  String get loginScreenFormInvalidPassword {
    return Intl.message(
      'Password must contain at least 8 characters',
      name: 'loginScreenFormInvalidPassword',
      desc: '',
      args: [],
    );
  }

  /// `Ops`
  String get alertDialogTitle {
    return Intl.message(
      'Ops',
      name: 'alertDialogTitle',
      desc: '',
      args: [],
    );
  }

  /// `Ok`
  String get alertDialogButton {
    return Intl.message(
      'Ok',
      name: 'alertDialogButton',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en', countryCode: 'US'),
      Locale.fromSubtags(languageCode: 'es'),
      Locale.fromSubtags(languageCode: 'pt', countryCode: 'BR'),
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
