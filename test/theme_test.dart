import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rrr/core/theme/app_theme.dart';
import 'package:rrr/core/widgets/app_button.dart';

import 'helpers.dart';

List<TextStyle?> _allStyles(TextTheme t) => [
      t.displayLarge,
      t.displayMedium,
      t.displaySmall,
      t.headlineLarge,
      t.headlineMedium,
      t.headlineSmall,
      t.titleLarge,
      t.titleMedium,
      t.titleSmall,
      t.bodyLarge,
      t.bodyMedium,
      t.bodySmall,
      t.labelLarge,
      t.labelMedium,
      t.labelSmall,
    ];

void main() {
  group('простой режим: правила доступности', () {
    for (final brightness in Brightness.values) {
      test('все стили текста не меньше 22 sp ($brightness)', () {
        final theme = AppTheme.build(ThemeVariant.simple, brightness);
        final styles = [
          ..._allStyles(theme.textTheme),
          ...theme.extension<AppTextStyles>()!.all,
        ];
        for (final s in styles) {
          if (s?.fontSize == null) continue;
          expect(s!.fontSize, greaterThanOrEqualTo(22), reason: '$s');
        }
      });
    }

    test('все нажимаемые размеры не меньше 60 px', () {
      const m = AppMetrics.simple;
      for (final h in [
        m.minTapTarget,
        m.mainActionHeight,
        m.buttonHeight,
        m.secondaryButtonHeight,
        m.navBarHeight,
      ]) {
        expect(h, greaterThanOrEqualTo(60));
      }
    });

    testWidgets('кнопки на экране простого режима не ниже 60 px',
        (tester) async {
      await pumpApp(tester, stored: {'settings.mode': 'simple'});
      final corner = find.bySemanticsLabel('Настройки для близкого');
      final hold = await tester.startGesture(tester.getCenter(corner));
      await tester.pump(const Duration(seconds: 5));
      await hold.up();
      await tester.pumpAndSettle();

      final buttons = find.byType(AppButton);
      expect(buttons, findsWidgets);
      for (final e in buttons.evaluate()) {
        expect(tester.getSize(find.byWidget(e.widget)).height,
            greaterThanOrEqualTo(60));
      }
    });
  });

  test('светлая и тёмная темы собираются для обоих вариантов', () {
    for (final v in ThemeVariant.values) {
      for (final b in Brightness.values) {
        final t = AppTheme.build(v, b);
        expect(t.brightness, b);
        expect(t.extension<AppColors>(), isNotNull);
        expect(t.extension<AppMetrics>(), isNotNull);
        expect(t.extension<AppTextStyles>(), isNotNull);
      }
    }
  });
}
