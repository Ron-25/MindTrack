import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:form_builder_validators/localization/l10n.dart';
import 'package:mind_track/app/generated/l10n.dart';

class AppLocalizationsSetup {
  static final List<Locale> supportedLocales = const <Locale>[
    Locale('en', ''),
    Locale('es', ''),
  ];

  static final Iterable<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    S.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    FormBuilderLocalizations.delegate,
  ];
}
