import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ru.dart';

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('ru')];

  /// No description provided for @appTitle.
  ///
  /// In ru, this message translates to:
  /// **'Рядом'**
  String get appTitle;

  /// No description provided for @onboardingQuestion.
  ///
  /// In ru, this message translates to:
  /// **'Как вы будете пользоваться приложением?'**
  String get onboardingQuestion;

  /// No description provided for @onboardingHint.
  ///
  /// In ru, this message translates to:
  /// **'Режим можно сменить позже в настройках'**
  String get onboardingHint;

  /// No description provided for @modeFullTitle.
  ///
  /// In ru, this message translates to:
  /// **'Я принимаю лекарства и всё настрою сам'**
  String get modeFullTitle;

  /// No description provided for @modeFullSubtitle.
  ///
  /// In ru, this message translates to:
  /// **'Расписание, запасы, история. Близкого можно позвать позже'**
  String get modeFullSubtitle;

  /// No description provided for @modeSimpleTitle.
  ///
  /// In ru, this message translates to:
  /// **'Мне помогает близкий'**
  String get modeSimpleTitle;

  /// No description provided for @modeSimpleSubtitle.
  ///
  /// In ru, this message translates to:
  /// **'Крупно и просто: только что выпить сейчас. Настроит близкий'**
  String get modeSimpleSubtitle;

  /// No description provided for @modeCaregiverTitle.
  ///
  /// In ru, this message translates to:
  /// **'Я помогаю близкому'**
  String get modeCaregiverTitle;

  /// No description provided for @modeCaregiverSubtitle.
  ///
  /// In ru, this message translates to:
  /// **'Следить за приёмом у мамы, папы или других родных'**
  String get modeCaregiverSubtitle;

  /// Короткое название режима в настройках
  ///
  /// In ru, this message translates to:
  /// **'{mode, select, full{Полный} simple{Простой} caregiver{Режим близкого} other{}}'**
  String modeName(String mode);

  /// No description provided for @actionContinue.
  ///
  /// In ru, this message translates to:
  /// **'Продолжить'**
  String get actionContinue;

  /// No description provided for @actionBack.
  ///
  /// In ru, this message translates to:
  /// **'← Назад'**
  String get actionBack;

  /// No description provided for @actionChangeMode.
  ///
  /// In ru, this message translates to:
  /// **'Сменить режим'**
  String get actionChangeMode;

  /// No description provided for @navNow.
  ///
  /// In ru, this message translates to:
  /// **'Сейчас'**
  String get navNow;

  /// No description provided for @navPlan.
  ///
  /// In ru, this message translates to:
  /// **'План'**
  String get navPlan;

  /// No description provided for @navStock.
  ///
  /// In ru, this message translates to:
  /// **'Запасы'**
  String get navStock;

  /// No description provided for @navMore.
  ///
  /// In ru, this message translates to:
  /// **'Ещё'**
  String get navMore;

  /// No description provided for @navRelatives.
  ///
  /// In ru, this message translates to:
  /// **'Близкие'**
  String get navRelatives;

  /// No description provided for @navMine.
  ///
  /// In ru, this message translates to:
  /// **'Моё'**
  String get navMine;

  /// Приветствие на главном экране полного режима
  ///
  /// In ru, this message translates to:
  /// **'{part, select, morning{Доброе утро} day{Добрый день} evening{Добрый вечер} other{Доброй ночи}}'**
  String greeting(String part);

  /// Приветствие в простом режиме
  ///
  /// In ru, this message translates to:
  /// **'{part, select, morning{Доброе утро!} day{Добрый день!} evening{Добрый вечер!} other{Доброй ночи!}}'**
  String simpleGreeting(String part);

  /// No description provided for @nowEmptyTitle.
  ///
  /// In ru, this message translates to:
  /// **'Лекарств пока нет'**
  String get nowEmptyTitle;

  /// No description provided for @nowEmptyText.
  ///
  /// In ru, this message translates to:
  /// **'Когда вы добавите лекарство, здесь появится то, что нужно принять сейчас.'**
  String get nowEmptyText;

  /// No description provided for @planTitle.
  ///
  /// In ru, this message translates to:
  /// **'План на сегодня'**
  String get planTitle;

  /// No description provided for @planEmptyTitle.
  ///
  /// In ru, this message translates to:
  /// **'План пока пуст'**
  String get planEmptyTitle;

  /// No description provided for @planEmptyText.
  ///
  /// In ru, this message translates to:
  /// **'Здесь будут все приёмы на день — утром, днём и вечером.'**
  String get planEmptyText;

  /// No description provided for @stockTitle.
  ///
  /// In ru, this message translates to:
  /// **'Запасы'**
  String get stockTitle;

  /// No description provided for @stockEmptyTitle.
  ///
  /// In ru, this message translates to:
  /// **'Запасов пока нет'**
  String get stockEmptyTitle;

  /// No description provided for @stockEmptyText.
  ///
  /// In ru, this message translates to:
  /// **'Покажем, на сколько дней хватит таблеток, и напомним купить заранее.'**
  String get stockEmptyText;

  /// No description provided for @relativesTitle.
  ///
  /// In ru, this message translates to:
  /// **'Мои близкие'**
  String get relativesTitle;

  /// No description provided for @relativesEmptyTitle.
  ///
  /// In ru, this message translates to:
  /// **'Пока никого нет'**
  String get relativesEmptyTitle;

  /// No description provided for @relativesEmptyText.
  ///
  /// In ru, this message translates to:
  /// **'Здесь появятся родные, за приёмом лекарств которых вы следите.'**
  String get relativesEmptyText;

  /// No description provided for @mineTitle.
  ///
  /// In ru, this message translates to:
  /// **'Мои лекарства'**
  String get mineTitle;

  /// No description provided for @mineEmptyTitle.
  ///
  /// In ru, this message translates to:
  /// **'Лекарств пока нет'**
  String get mineEmptyTitle;

  /// No description provided for @mineEmptyText.
  ///
  /// In ru, this message translates to:
  /// **'Если вы тоже принимаете лекарства, их можно добавить сюда.'**
  String get mineEmptyText;

  /// No description provided for @simpleEmptyTitle.
  ///
  /// In ru, this message translates to:
  /// **'Лекарств пока нет'**
  String get simpleEmptyTitle;

  /// No description provided for @simpleEmptyText.
  ///
  /// In ru, this message translates to:
  /// **'Их добавит близкий'**
  String get simpleEmptyText;

  /// No description provided for @simpleSettingsEntry.
  ///
  /// In ru, this message translates to:
  /// **'Настройки для близкого'**
  String get simpleSettingsEntry;

  /// No description provided for @moreTitle.
  ///
  /// In ru, this message translates to:
  /// **'Ещё'**
  String get moreTitle;

  /// No description provided for @settingsTitle.
  ///
  /// In ru, this message translates to:
  /// **'Настройки'**
  String get settingsTitle;

  /// No description provided for @settingsAppearance.
  ///
  /// In ru, this message translates to:
  /// **'Оформление'**
  String get settingsAppearance;

  /// No description provided for @themeSystem.
  ///
  /// In ru, this message translates to:
  /// **'Как в телефоне'**
  String get themeSystem;

  /// No description provided for @themeLight.
  ///
  /// In ru, this message translates to:
  /// **'Светлая'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In ru, this message translates to:
  /// **'Тёмная'**
  String get themeDark;

  /// No description provided for @settingsMode.
  ///
  /// In ru, this message translates to:
  /// **'Режим'**
  String get settingsMode;

  /// No description provided for @settingsCurrentMode.
  ///
  /// In ru, this message translates to:
  /// **'Сейчас: {mode}'**
  String settingsCurrentMode(String mode);

  /// No description provided for @medicalDisclaimer.
  ///
  /// In ru, this message translates to:
  /// **'«Рядом» только напоминает. Дозировку и схему назначает врач — мы их не советуем и не меняем.'**
  String get medicalDisclaimer;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ru':
      return AppLocalizationsRu();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
