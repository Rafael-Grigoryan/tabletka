import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/routes.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/screen_scaffold.dart';
import '../../../../l10n/l10n.dart';

/// Простой режим, главный экран (S1). Без нижней навигации:
/// одно действие на экран, крупный текст.
///
/// Настройки спрятаны (так в дизайне): удержание правого верхнего угла
/// 5 секунд. Позже сюда добавится PIN близкого.
class SimpleHomeScreen extends StatelessWidget {
  const SimpleHomeScreen({super.key});

  static const settingsHoldDuration = Duration(seconds: 5);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final now = DateTime.now();

    return Stack(
      children: [
        ScreenScaffold(
          children: [
            Semantics(
              header: true,
              child: Text(
                l10n.simpleGreeting(DayPart.of(now).name),
                style: context.text.titleLarge,
              ),
            ),
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(l10n.simpleEmptyTitle, style: context.text.titleSmall),
                  const SizedBox(height: AppSpacing.s),
                  Text(l10n.simpleEmptyText, style: context.text.bodyLarge),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: 0,
          right: 0,
          child: SafeArea(
            child: _HiddenSettingsCorner(
              label: l10n.simpleSettingsEntry,
              onTriggered: () => context.push(Routes.simpleSettings),
            ),
          ),
        ),
      ],
    );
  }
}

/// Невидимая зона в правом верхнем углу: открывает настройки
/// после долгого удержания.
class _HiddenSettingsCorner extends StatelessWidget {
  const _HiddenSettingsCorner({required this.label, required this.onTriggered});

  final String label;
  final VoidCallback onTriggered;

  @override
  Widget build(BuildContext context) {
    final size = context.metrics.minTapTarget;
    return Semantics(
      label: label,
      child: RawGestureDetector(
        behavior: HitTestBehavior.opaque,
        gestures: {
          LongPressGestureRecognizer:
              GestureRecognizerFactoryWithHandlers<LongPressGestureRecognizer>(
            () => LongPressGestureRecognizer(
              duration: SimpleHomeScreen.settingsHoldDuration,
            ),
            (r) => r.onLongPress = onTriggered,
          ),
        },
        child: SizedBox(width: size, height: size),
      ),
    );
  }
}
