import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Нижняя навигация из дизайна: только подписи, у выбранной вкладки —
/// зелёная полоска сверху. Вся ячейка вкладки нажимается.
class AppBottomBar extends StatelessWidget {
  const AppBottomBar({
    super.key,
    required this.labels,
    required this.currentIndex,
    required this.onSelected,
  });

  final List<String> labels;
  final int currentIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final metrics = context.metrics;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.background,
        border: Border(top: BorderSide(color: colors.border)),
      ),
      child: SafeArea(
        top: false,
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: metrics.navBarHeight),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (var i = 0; i < labels.length; i++)
                  Expanded(
                    child: _BarItem(
                      label: labels[i],
                      selected: i == currentIndex,
                      onTap: () => onSelected(i),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BarItem extends StatelessWidget {
  const _BarItem({
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
    final style = context.textStyles.navLabel;

    return Semantics(
      selected: selected,
      button: true,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.s),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 28,
                height: 4,
                decoration: BoxDecoration(
                  color: selected ? colors.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 3),
              Text(
                label,
                textAlign: TextAlign.center,
                style: style.copyWith(
                  color: selected ? colors.accentText : colors.textMuted,
                  fontWeight: selected ? FontWeight.w600 : style.fontWeight,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
