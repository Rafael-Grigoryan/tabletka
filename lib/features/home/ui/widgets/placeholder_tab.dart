import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/screen_scaffold.dart';
import 'empty_state_card.dart';

/// Вкладка-заготовка: заголовок экрана и пустое состояние.
/// Наполнение появится на следующих этапах.
class PlaceholderTab extends StatelessWidget {
  const PlaceholderTab({
    super.key,
    required this.title,
    required this.emptyTitle,
    required this.emptyText,
  });

  final String title;
  final String emptyTitle;
  final String emptyText;

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      gap: AppSpacing.m,
      children: [
        Semantics(
          header: true,
          child: Text(title, style: context.text.headlineSmall),
        ),
        EmptyStateCard(title: emptyTitle, text: emptyText),
      ],
    );
  }
}
