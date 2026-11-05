import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_card.dart';

/// Карточка «здесь пока пусто».
class EmptyStateCard extends StatelessWidget {
  const EmptyStateCard({super.key, required this.title, required this.text});

  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: context.text.titleSmall),
          const SizedBox(height: AppSpacing.xxs),
          Text(
            text,
            style: context.text.bodySmall
                ?.copyWith(color: context.colors.textMuted),
          ),
        ],
      ),
    );
  }
}
