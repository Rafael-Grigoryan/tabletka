import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Вариант выбора с круглым переключателем (как «Сергей видит» в дизайне).
class ChoiceTile extends StatelessWidget {
  const ChoiceTile({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final metrics = context.metrics;
    final radius = BorderRadius.circular(AppRadii.sm);
    final ring = metrics.radioSize;

    return Semantics(
      inMutuallyExclusiveGroup: true,
      checked: selected,
      button: true,
      child: Material(
        color: selected ? colors.primarySoft : Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: radius,
          // В простом режиме выбранное выделяется ещё и рамкой (как S3).
          side: switch ((selected, metrics.framedCards)) {
            (true, false) => BorderSide.none,
            (true, true) => BorderSide(
                color: colors.primary,
                width: metrics.cardBorderWidth,
              ),
            (false, _) => BorderSide(
                color: colors.border,
                width: metrics.cardBorderWidth,
              ),
          },
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: metrics.minTapTarget),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.m,
                vertical: AppSpacing.s,
              ),
              child: Row(
                children: [
                  Container(
                    width: ring,
                    height: ring,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: selected ? colors.surface : Colors.transparent,
                      border: Border.all(
                        color: selected ? colors.primary : colors.control,
                        width: selected ? ring * 0.3 : 2,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Text(
                      label,
                      style: context.text.bodyMedium?.copyWith(
                        fontWeight: selected ? FontWeight.w500 : null,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
