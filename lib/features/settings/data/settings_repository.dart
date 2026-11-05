import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/storage/preferences.dart';
import '../domain/app_settings.dart';

/// Чтение и запись настроек в локальное хранилище телефона.
class SettingsRepository {
  SettingsRepository(this._prefs);

  final SharedPreferences _prefs;

  static const _modeKey = 'settings.mode';
  static const _themeModeKey = 'settings.themeMode';

  AppSettings load() => AppSettings(
        mode: _byName(AppMode.values, _prefs.getString(_modeKey)),
        themeMode: _byName(ThemeMode.values, _prefs.getString(_themeModeKey)) ??
            ThemeMode.system,
      );

  Future<void> saveMode(AppMode mode) => _prefs.setString(_modeKey, mode.name);

  Future<void> saveThemeMode(ThemeMode mode) =>
      _prefs.setString(_themeModeKey, mode.name);

  static T? _byName<T extends Enum>(List<T> values, String? name) {
    for (final v in values) {
      if (v.name == name) return v;
    }
    return null;
  }
}

final settingsRepositoryProvider = Provider<SettingsRepository>(
  (ref) => SettingsRepository(ref.watch(sharedPreferencesProvider)),
);
