import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/screen_scaffold.dart';
import '../../../../l10n/l10n.dart';
import '../widgets/empty_state_card.dart';

/// Полный режим, вкладка «Сейчас» (F1). Пока — шапка с датой
/// и приветствием и пустое состояние.
class NowScreen extends StatelessWidget {
  const NowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final now = DateTime.now();

    return ScreenScaffold(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.formatLongDate(now),
              style: context.text.bodySmall
                  ?.copyWith(color: context.colors.textMuted),
            ),
            Semantics(
              header: true,
              child: Text(
                l10n.greeting(DayPart.of(now).name),
                style: context.text.headlineSmall,
              ),
            ),
          ],
        ),
        EmptyStateCard(title: l10n.nowEmptyTitle, text: l10n.nowEmptyText),
      ],
    );
  }
}
