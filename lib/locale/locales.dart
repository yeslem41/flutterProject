import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fluttercnam/l10n/messages_all.dart';
import 'dart:async';


class AppLocalization{
  static Future<AppLocalization> load(Locale locale){
    final String name = locale.countryCode.isNotEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_){
      Intl.defaultLocale = localeName;
      return AppLocalization();
    });
  }
  static AppLocalization of(BuildContext context){
    return Localizations.of<AppLocalization>(context, AppLocalization);
  }
  String get AppName{
    return Intl.message(
        'app name',
        name: 'AppName',
        desc: 'the name of our app it is pretty'
    );
  }

  String get welcome{
    return Intl.message(
        'app\'s welcome',
        name: 'welcome',
        desc: 'the app\'s welcome message it is also pretty'
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalization> {
  @override
  bool isSupported(Locale locale) {
    // TODO: implement isSupported
    return ['fr','ar'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalization> load(Locale locale) {
    // TODO: implement load
    return AppLocalization.load(locale);
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalization> old) {
    // TODO: implement shouldReload
    return false;
  }
  
}