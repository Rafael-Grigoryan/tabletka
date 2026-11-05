import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import 'generated/app_localizations.dart';

export 'generated/app_localizations.dart';

/// Доступ к текстам: `context.l10n.someKey`.
///
/// Все тексты интерфейса живут в `lib/l10n/app_ru.arb`.
/// Строковые литералы прямо в виджетах не используем.
extension L10nContext on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);

  /// «Среда, 5 ноября» — в формате текущего языка.
  String formatLongDate(DateTime date) {
    final locale = Localizations.localeOf(this).toLanguageTag();
    final s = DateFormat('EEEE, d MMMM', locale).format(date);
    return s.isEmpty ? s : s[0].toUpperCase() + s.substring(1);
  }
}

/// Часть дня — для приветствий. Значения совпадают с ключами `select` в ARB.
enum DayPart {
  morning,
  day,
  evening,
  night;

  static DayPart of(DateTime time) => switch (time.hour) {
        >= 5 && < 12 => DayPart.morning,
        >= 12 && < 17 => DayPart.day,
        >= 17 && < 23 => DayPart.evening,
        _ => DayPart.night,
      };
}
