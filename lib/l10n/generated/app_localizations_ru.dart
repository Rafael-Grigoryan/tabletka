import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Рядом';

  @override
  String get onboardingQuestion => 'Как вы будете пользоваться приложением?';

  @override
  String get onboardingHint => 'Режим можно сменить позже в настройках';

  @override
  String get modeFullTitle => 'Я принимаю лекарства и всё настрою сам';

  @override
  String get modeFullSubtitle =>
      'Расписание, запасы, история. Близкого можно позвать позже';

  @override
  String get modeSimpleTitle => 'Мне помогает близкий';

  @override
  String get modeSimpleSubtitle =>
      'Крупно и просто: только что выпить сейчас. Настроит близкий';

  @override
  String get modeCaregiverTitle => 'Я помогаю близкому';

  @override
  String get modeCaregiverSubtitle =>
      'Следить за приёмом у мамы, папы или других родных';

  @override
  String modeName(String mode) {
    String _temp0 = intl.Intl.selectLogic(
      mode,
      {
        'full': 'Полный',
        'simple': 'Простой',
        'caregiver': 'Режим близкого',
        'other': '',
      },
    );
    return '$_temp0';
  }

  @override
  String get actionContinue => 'Продолжить';

  @override
  String get actionBack => '← Назад';

  @override
  String get actionChangeMode => 'Сменить режим';

  @override
  String get navNow => 'Сейчас';

  @override
  String get navPlan => 'План';

  @override
  String get navStock => 'Запасы';

  @override
  String get navMore => 'Ещё';

  @override
  String get navRelatives => 'Близкие';

  @override
  String get navMine => 'Моё';

  @override
  String greeting(String part) {
    String _temp0 = intl.Intl.selectLogic(
      part,
      {
        'morning': 'Доброе утро',
        'day': 'Добрый день',
        'evening': 'Добрый вечер',
        'other': 'Доброй ночи',
      },
    );
    return '$_temp0';
  }

  @override
  String simpleGreeting(String part) {
    String _temp0 = intl.Intl.selectLogic(
      part,
      {
        'morning': 'Доброе утро!',
        'day': 'Добрый день!',
        'evening': 'Добрый вечер!',
        'other': 'Доброй ночи!',
      },
    );
    return '$_temp0';
  }

  @override
  String get nowEmptyTitle => 'Лекарств пока нет';

  @override
  String get nowEmptyText =>
      'Когда вы добавите лекарство, здесь появится то, что нужно принять сейчас.';

  @override
  String get planTitle => 'План на сегодня';

  @override
  String get planEmptyTitle => 'План пока пуст';

  @override
  String get planEmptyText =>
      'Здесь будут все приёмы на день — утром, днём и вечером.';

  @override
  String get stockTitle => 'Запасы';

  @override
  String get stockEmptyTitle => 'Запасов пока нет';

  @override
  String get stockEmptyText =>
      'Покажем, на сколько дней хватит таблеток, и напомним купить заранее.';

  @override
  String get relativesTitle => 'Мои близкие';

  @override
  String get relativesEmptyTitle => 'Пока никого нет';

  @override
  String get relativesEmptyText =>
      'Здесь появятся родные, за приёмом лекарств которых вы следите.';

  @override
  String get mineTitle => 'Мои лекарства';

  @override
  String get mineEmptyTitle => 'Лекарств пока нет';

  @override
  String get mineEmptyText =>
      'Если вы тоже принимаете лекарства, их можно добавить сюда.';

  @override
  String get simpleEmptyTitle => 'Лекарств пока нет';

  @override
  String get simpleEmptyText => 'Их добавит близкий';

  @override
  String get simpleSettingsEntry => 'Настройки для близкого';

  @override
  String get moreTitle => 'Ещё';

  @override
  String get settingsTitle => 'Настройки';

  @override
  String get settingsAppearance => 'Оформление';

  @override
  String get themeSystem => 'Как в телефоне';

  @override
  String get themeLight => 'Светлая';

  @override
  String get themeDark => 'Тёмная';

  @override
  String get settingsMode => 'Режим';

  @override
  String settingsCurrentMode(String mode) {
    return 'Сейчас: $mode';
  }

  @override
  String get medicalDisclaimer =>
      '«Рядом» только напоминает. Дозировку и схему назначает врач — мы их не советуем и не меняем.';
}
