import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/settings_repository.dart';
import '../domain/app_settings.dart';

class SettingsController extends Notifier<AppSettings> {
  @override
  AppSettings build() => ref.watch(settingsRepositoryProvider).load();

  Future<void> setMode(AppMode mode) async {
    state = state.copyWith(mode: mode);
    await ref.read(settingsRepositoryProvider).saveMode(mode);
  }

  Future<void> setThemeMode(ThemeMode themeMode) async {
    state = state.copyWith(themeMode: themeMode);
    await ref.read(settingsRepositoryProvider).saveThemeMode(themeMode);
  }
}

final settingsControllerProvider =
    NotifierProvider<SettingsController, AppSettings>(SettingsController.new);

/// Текущий режим; `null` — ещё не выбран.
final appModeProvider = Provider<AppMode?>(
  (ref) => ref.watch(settingsControllerProvider.select((s) => s.mode)),
);
