import 'package:flutter/material.dart';
import 'package:fluttercnam/pages/fragment.dart';
import 'package:fluttercnam/pages/reclamation.dart';
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
  String get loginLabelText{
    return Intl.message(
        'app\'s loginLabelText',
        name: 'loginLabelText',
        desc: 'the app\'s loginLabelText message it is also pretty'
    );
  }

   String get loginConnect{
    return Intl.message(
        'app\'s loginConnect',
        name: 'loginConnect',
        desc: 'the app\'s loginConnect message it is also pretty'
    );
  }
String get suivi{
    return Intl.message(
        'app\'s suivi',
        name: 'suivi',
        desc: 'the app\'s suivi message it is also pretty'
    );
  }
String get gerstionRecla{
    return Intl.message(
        'app\'s gerstionRecla',
        name: 'gerstionRecla',
        desc: 'the app\'s gerstionRecla message it is also pretty'
    );
  }
  String get fragment{
    return Intl.message(
        'app\'s fragment',
        name: 'fragment',
        desc: 'the app\'s fragment message it is also pretty'
    );
  }
    String get deconnecter{
    return Intl.message(
        'app\'s deconnecter',
        name: 'deconnecter',
        desc: 'the app\'s deconnecter message it is also pretty'
    );
  }
 String get choisir{
    return Intl.message(
        'app\'s choisi',
        name: 'choisir',
        desc: 'the app\'s choisi message it is also pretty'
    );
  }

  String get choiDossier{
    return Intl.message(
        'app\'s choiDossier',
        name: 'choiDossier',
        desc: 'the app\'s choiDossier message it is also pretty'
    );
  }
  String get choiRecla{
    return Intl.message(
        'app\'s choiRecla',
        name: 'choiRecla',
        desc: 'the app\'s choiRecla message it is also pretty'
    );
  }
  String get hintRecu{
    return Intl.message(
        'app\'s hintRecu',
        name: 'hintRecu',
        desc: 'the app\'s hintRecu message it is also pretty'
    );
  }
  String get hintRecuFalse{
    return Intl.message(
        'app\'s hintRecuFalse',
        name: 'hintRecuFalse',
        desc: 'the app\'s hintRecuFalse message it is also pretty'
    );
  }
  String get suiviButton{
    return Intl.message(
        'app\'s suiviButton',
        name: 'suiviButton',
        desc: 'the app\'s suiviButton message it is also pretty'
    );
  }
  String get demandeInfos{
    return Intl.message(
        'app\'s demandeInfos',
        name: 'demandeInfos',
        desc: 'the app\'s demandeInfos message it is also pretty'
    );
  }
  String get demandePropos{
    return Intl.message(
        'app\'s demandePropos',
        name: 'demandePropos',
        desc: 'the app\'s demandePropos message it is also pretty'
    );
  }
  String get reponse{
    return Intl.message(
        'app\'s reponse',
        name: 'reponse',
        desc: 'the app\'s reponse message it is also pretty'
    );
  }
  String get matricule{
    return Intl.message(
        'app\'s matricule',
        name: 'matricule',
        desc: 'the app\'s matricule message it is also pretty'
    );
  }
  String get recu{
    return Intl.message(
        'app\'s recu',
        name: 'recu',
        desc: 'the app\'s recu message it is also pretty'
    );
  }
  String get rembourser{
    return Intl.message(
        'app\'s rembourser',
        name: 'rembourser',
        desc: 'the app\'s rembourser message it is also pretty'
    );
  }
  String get alertNotRecu{
    return Intl.message(
        'app\'s alertNotRecu',
        name: 'alertNotRecu',
        desc: 'the app\'s alertNotRecu message it is also pretty'
    );
  }
  String get alertNotrecu10{
    return Intl.message(
        'app\'s alertNotrecu10',
        name: 'alertNotrecu10',
        desc: 'the app\'s alertNotrecu10 message it is also pretty'
    );
  }
  String get alertNotRecuOk{
    return Intl.message(
        'app\'s alertNotRecuOk',
        name: 'alertNotRecuOk',
        desc: 'the app\'s alertNotRecuOk message it is also pretty'
    );
  }
  String get alertNotInam{
    return Intl.message(
        'app\'s alertNotInam',
        name: 'alertNotInam',
        desc: 'the app\'s alertNotInam message it is also pretty'
    );
  }
  String get hitLoginNotCorrect{
    return Intl.message(
        'app\'s hitLoginNotCorrect',
        name: 'hitLoginNotCorrect',
        desc: 'the app\'s hitLoginNotCorrect message it is also pretty'
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