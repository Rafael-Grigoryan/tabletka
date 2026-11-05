import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';
import 'core/storage/preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _registerFontLicenses();
  final prefs = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
      child: const RyadomApp(),
    ),
  );
}

/// Шрифты Onest и Lora распространяются по лицензии SIL OFL —
/// показываем её на системном экране лицензий.
void _registerFontLicenses() {
  LicenseRegistry.addLicense(() async* {
    for (final (family, file) in [
      ('Onest', 'assets/fonts/OFL-Onest.txt'),
      ('Lora', 'assets/fonts/OFL-Lora.txt'),
    ]) {
      yield LicenseEntryWithLineBreaks(
          [family], await rootBundle.loadString(file));
    }
  });
}
