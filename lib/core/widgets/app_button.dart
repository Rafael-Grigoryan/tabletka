import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

enum AppButtonVariant {
  /// Зелёная кнопка главного действия.
  primary,

  /// Светлая песочная кнопка («Напомнить позже»).
  secondary,

  /// Контур цвета «принято» («Отчёт для врача», «+ Пригласить»).
  outline,

  /// Тёмный контур — второстепенные действия в простом режиме.
  outlineStrong,

  /// Тёмная кнопка («Позвонить»).
  inverse,
}

enum AppButtonSize {
  /// Обычная кнопка.
  regular,

  /// Главное действие экрана — самая крупная кнопка («Выпила»).
  main,
}

/// Кнопка в стиле дизайна. Размеры и цвета берутся из темы,
/// поэтому в простом режиме кнопка автоматически крупнее.
///
/// Высота задаётся как минимальная: при увеличенном системном шрифте
/// кнопка растёт, а не обрезает текст.
class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.size = AppButtonSize.regular,
    this.expand = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final AppButtonSize size;

  /// Растянуть на всю ширину.
  final bool expand;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final metrics = context.metrics;
    final styles = context.textStyles;
    final enabled = onPressed != null;

    final (Color bg, Color fg, BorderSide side) = switch (variant) {
      AppButtonVariant.primary => (
          colors.primary,
          colors.onPrimary,
          BorderSide.none
        ),
      AppButtonVariant.secondary => (
          colors.secondaryButton,
          colors.onSecondaryButton,
          BorderSide.none,
        ),
      AppButtonVariant.outline => (
          Colors.transparent,
          colors.accentText,
          BorderSide(color: colors.primary, width: 2),
        ),
      AppButtonVariant.outlineStrong => (
          Colors.transparent,
          colors.outlineStrong,
          BorderSide(color: colors.outlineStrong, width: 2),
        ),
      AppButtonVariant.inverse => (
          colors.inverse,
          colors.onInverse,
          BorderSide.none
        ),
    };

    final double height = switch ((size, variant)) {
      (AppButtonSize.main, _) => metrics.mainActionHeight,
      (_, AppButtonVariant.secondary) => metrics.secondaryButtonHeight,
      (_, AppButtonVariant.outlineStrong) => metrics.secondaryButtonHeight,
      _ => metrics.buttonHeight,
    };

    final TextStyle style = switch ((size, variant)) {
      (AppButtonSize.main, _) => styles.buttonMain,
      (_, AppButtonVariant.primary) => styles.buttonPrimary,
      (_, AppButtonVariant.outline) =>
        styles.buttonSecondary.copyWith(fontWeight: FontWeight.w600),
      _ => styles.buttonSecondary,
    };

    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(
        size == AppButtonSize.main
            ? metrics.buttonRadius + 6
            : metrics.buttonRadius,
      ),
      side: side,
    );

    final button = Material(
      color: bg,
      shape: shape,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onPressed,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: height,
            minWidth: metrics.minTapTarget,
          ),
          child: Center(
            widthFactor: expand ? null : 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.xl,
                vertical: AppSpacing.s,
              ),
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: style.copyWith(color: fg),
              ),
            ),
          ),
        ),
      ),
    );

    return Semantics(
      button: true,
      enabled: enabled,
      child: Opacity(
        opacity: enabled ? 1 : 0.4,
        child:
            expand ? SizedBox(width: double.infinity, child: button) : button,
      ),
    );
  }
}
