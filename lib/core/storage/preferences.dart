import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Локальное хранилище настроек на телефоне.
///
/// Экземпляр создаётся в `main()` до запуска приложения и подставляется
/// через `ProviderScope(overrides: ...)`, поэтому доступен синхронно.
final sharedPreferencesProvider = Provider<SharedPreferences>(
  (ref) => throw UnimplementedError(
    'sharedPreferencesProvider нужно переопределить в ProviderScope',
  ),
);
