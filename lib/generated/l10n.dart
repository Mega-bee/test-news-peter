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

  /// `Filter by date:`
  String get filterByDate {
    return Intl.message(
      'Filter by date:',
      name: 'filterByDate',
      desc: '',
      args: [],
    );
  }

  /// `to:`
  String get to {
    return Intl.message(
      'to:',
      name: 'to',
      desc: '',
      args: [],
    );
  }

  /// `from:`
  String get from {
    return Intl.message(
      'from:',
      name: 'from',
      desc: '',
      args: [],
    );
  }

  /// `Popularity:`
  String get Popularity {
    return Intl.message(
      'Popularity:',
      name: 'Popularity',
      desc: '',
      args: [],
    );
  }

  /// `PublishedAt:`
  String get PublishedAt {
    return Intl.message(
      'PublishedAt:',
      name: 'PublishedAt',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get Search {
    return Intl.message(
      'Search',
      name: 'Search',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get Language {
    return Intl.message(
      'Language',
      name: 'Language',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get English {
    return Intl.message(
      'English',
      name: 'English',
      desc: '',
      args: [],
    );
  }

  /// `Arabic`
  String get Arabic {
    return Intl.message(
      'Arabic',
      name: 'Arabic',
      desc: '',
      args: [],
    );
  }

  /// `Search news...`
  String get SearchNews {
    return Intl.message(
      'Search news...',
      name: 'SearchNews',
      desc: '',
      args: [],
    );
  }

  /// `Sort By`
  String get SortBy {
    return Intl.message(
      'Sort By',
      name: 'SortBy',
      desc: '',
      args: [],
    );
  }

  /// `Required *`
  String get Required {
    return Intl.message(
      'Required *',
      name: 'Required',
      desc: '',
      args: [],
    );
  }

  /// `Invalid api key`
  String get InvalidKey {
    return Intl.message(
      'Invalid api key',
      name: 'InvalidKey',
      desc: '',
      args: [],
    );
  }

  /// `Log In`
  String get LogIn {
    return Intl.message(
      'Log In',
      name: 'LogIn',
      desc: '',
      args: [],
    );
  }

  /// `Api Key`
  String get ApiKey {
    return Intl.message(
      'Api Key',
      name: 'ApiKey',
      desc: '',
      args: [],
    );
  }

  /// `Theme`
  String get Theme {
    return Intl.message(
      'Theme',
      name: 'Theme',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get Settings {
    return Intl.message(
      'Settings',
      name: 'Settings',
      desc: '',
      args: [],
    );
  }

  /// `Log Out`
  String get LogOut {
    return Intl.message(
      'Log Out',
      name: 'LogOut',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get Yes {
    return Intl.message(
      'Yes',
      name: 'Yes',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get No {
    return Intl.message(
      'No',
      name: 'No',
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
      Locale.fromSubtags(languageCode: 'ar'),
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
