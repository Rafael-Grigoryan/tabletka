import 'package:flutter/material.dart';

/// Режим работы приложения. Выбирается при первом запуске.
enum AppMode {
  /// Человек сам принимает лекарства и сам всё настраивает.
  full,

  /// Для пожилых: только «что выпить сейчас», крупно. Настраивает близкий.
  simple,

  /// Близкий следит за приёмом лекарств у родных.
  caregiver,
}

@immutable
class AppSettings {
  const AppSettings({this.mode, this.themeMode = ThemeMode.system});

  /// `null` — режим ещё не выбран (первый запуск).
  final AppMode? mode;
  final ThemeMode themeMode;

  bool get isOnboarded => mode != null;

  AppSettings copyWith({AppMode? mode, ThemeMode? themeMode}) => AppSettings(
        mode: mode ?? this.mode,
        themeMode: themeMode ?? this.themeMode,
      );
}
