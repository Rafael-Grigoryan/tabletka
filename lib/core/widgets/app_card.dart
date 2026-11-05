import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Белая карточка на «бумажном» фоне.
class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.padding,
    this.borderColor,
    this.color,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;

  /// Рамка карточки. В простом режиме карточки по дизайну всегда с рамкой.
  final Color? borderColor;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final metrics = context.metrics;
    final colors = context.colors;
    final border = borderColor ?? (metrics.framedCards ? colors.border : null);

    return Container(
      width: double.infinity,
      padding: padding ?? metrics.cardPadding,
      decoration: BoxDecoration(
        color: color ?? colors.surface,
        borderRadius: BorderRadius.circular(metrics.cardRadius),
        border: border == null
            ? null
            : Border.all(color: border, width: metrics.cardBorderWidth),
      ),
      child: child,
    );
  }
}
