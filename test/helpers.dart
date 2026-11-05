import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rrr/app.dart';
import 'package:rrr/core/storage/preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Запускает приложение с заданными сохранёнными настройками.
Future<SharedPreferences> pumpApp(
  WidgetTester tester, {
  Map<String, Object> stored = const {},
  Size size = const Size(360, 760),
}) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);

  SharedPreferences.setMockInitialValues(stored);
  final prefs = await SharedPreferences.getInstance();
  await tester.pumpWidget(
    ProviderScope(
      overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
      child: const RyadomApp(),
    ),
  );
  await tester.pumpAndSettle();
  return prefs;
}
