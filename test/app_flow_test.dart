import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rrr/core/router/app_router.dart';
import 'package:rrr/core/router/routes.dart';
import 'package:rrr/features/home/ui/simple/simple_home_screen.dart';
import 'package:rrr/features/onboarding/ui/mode_select_screen.dart';
import 'package:rrr/features/settings/domain/app_settings.dart';

import 'helpers.dart';

void main() {
  group('первый запуск', () {
    testWidgets('открывается выбор режима, «Продолжить» неактивна без выбора',
        (tester) async {
      final prefs = await pumpApp(tester);

      expect(find.byType(ModeSelectScreen), findsOneWidget);
      expect(
          find.text('Как вы будете пользоваться приложением?'), findsOneWidget);

      // Нажатие без выбора ничего не делает.
      await tester.tap(find.text('Продолжить'));
      await tester.pumpAndSettle();
      expect(find.byType(ModeSelectScreen), findsOneWidget);
      expect(prefs.getString('settings.mode'), isNull);
    });

    testWidgets('выбор простого режима сохраняется и ведёт на его экран',
        (tester) async {
      final prefs = await pumpApp(tester);

      await tester.tap(find.text('Мне помогает близкий'));
      await tester.pump();
      await tester.tap(find.text('Продолжить'));
      await tester.pumpAndSettle();

      expect(find.byType(SimpleHomeScreen), findsOneWidget);
      expect(prefs.getString('settings.mode'), 'simple');
    });

    testWidgets('выбор режима близкого открывает вкладку «Близкие»',
        (tester) async {
      await pumpApp(tester);

      await tester.tap(find.text('Я помогаю близкому'));
      await tester.pump();
      await tester.tap(find.text('Продолжить'));
      await tester.pumpAndSettle();

      expect(find.text('Мои близкие'), findsOneWidget);
      expect(find.text('Моё'), findsOneWidget);
    });
  });

  group('повторный запуск', () {
    testWidgets('сохранённый полный режим сразу открывает «Сейчас»',
        (tester) async {
      await pumpApp(tester, stored: {'settings.mode': 'full'});

      expect(find.byType(ModeSelectScreen), findsNothing);
      for (final tab in ['Сейчас', 'План', 'Запасы', 'Ещё']) {
        expect(find.text(tab), findsOneWidget);
      }
      expect(find.text('Лекарств пока нет'), findsOneWidget);
    });

    testWidgets('вкладки полного режима переключаются', (tester) async {
      await pumpApp(tester, stored: {'settings.mode': 'full'});

      await tester.tap(find.text('Запасы'));
      await tester.pumpAndSettle();
      expect(find.text('Запасов пока нет'), findsOneWidget);
    });
  });

  group('настройки', () {
    testWidgets('тёмная тема выбирается и сохраняется', (tester) async {
      final prefs = await pumpApp(tester, stored: {'settings.mode': 'full'});

      await tester.tap(find.text('Ещё'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Тёмная'));
      await tester.pumpAndSettle();

      expect(prefs.getString('settings.themeMode'), 'dark');
      final app = tester.widget<MaterialApp>(find.byType(MaterialApp));
      expect(app.themeMode, ThemeMode.dark);
    });

    testWidgets('режим можно сменить из «Ещё»', (tester) async {
      final prefs = await pumpApp(tester, stored: {'settings.mode': 'full'});

      await tester.tap(find.text('Ещё'));
      await tester.pumpAndSettle();
      await tester.ensureVisible(find.text('Сменить режим'));
      await tester.tap(find.text('Сменить режим'));
      await tester.pumpAndSettle();

      expect(find.byType(ModeSelectScreen), findsOneWidget);
      await tester.tap(find.text('Я помогаю близкому'));
      await tester.pump();
      await tester.tap(find.text('Продолжить'));
      await tester.pumpAndSettle();

      expect(prefs.getString('settings.mode'), 'caregiver');
      expect(find.text('Мои близкие'), findsOneWidget);
    });

    testWidgets('в простом режиме настройки открываются удержанием 5 секунд',
        (tester) async {
      await pumpApp(tester, stored: {'settings.mode': 'simple'});

      final corner = find.bySemanticsLabel('Настройки для близкого');
      // Короткое удержание не открывает настройки.
      final gesture = await tester.startGesture(tester.getCenter(corner));
      await tester.pump(const Duration(seconds: 2));
      await gesture.up();
      await tester.pumpAndSettle();
      expect(find.text('Настройки'), findsNothing);

      final hold = await tester.startGesture(tester.getCenter(corner));
      await tester.pump(SimpleHomeScreen.settingsHoldDuration);
      await hold.up();
      await tester.pumpAndSettle();
      expect(find.text('Настройки'), findsOneWidget);
    });
  });

  group('redirect', () {
    test('без режима всё ведёт на выбор режима', () {
      expect(redirectFor(null, Routes.fullNow), Routes.welcome);
      expect(redirectFor(null, Routes.welcome), isNull);
    });

    test('нельзя попасть в раздел другого режима', () {
      expect(redirectFor(AppMode.simple, Routes.fullNow), Routes.simple);
      expect(redirectFor(AppMode.full, Routes.welcome), Routes.fullNow);
      expect(redirectFor(AppMode.full, Routes.fullStock), isNull);
      expect(redirectFor(AppMode.simple, Routes.simpleSettings), isNull);
      expect(redirectFor(AppMode.caregiver, Routes.changeMode), isNull);
    });
  });
}
