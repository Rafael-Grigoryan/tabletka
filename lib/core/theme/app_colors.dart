import 'package:flutter/material.dart';

import 'app_palette.dart';
import 'theme_variant.dart';

/// Смысловые цвета приложения. Доступны через `context.colors`.
@immutable
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.background,
    required this.surface,
    required this.surfaceMuted,
    required this.textPrimary,
    required this.textSecondary,
    required this.textMuted,
    required this.border,
    required this.borderStrong,
    required this.divider,
    required this.control,
    required this.primary,
    required this.primaryPressed,
    required this.onPrimary,
    required this.primarySoft,
    required this.onPrimarySoft,
    required this.accentText,
    required this.secondaryButton,
    required this.onSecondaryButton,
    required this.inverse,
    required this.onInverse,
    required this.outlineStrong,
    required this.success,
    required this.soon,
    required this.soonSoft,
    required this.onSoonSoft,
    required this.missed,
    required this.missedSoft,
    required this.onMissedSoft,
  });

  /// Фон экрана («бумага»).
  final Color background;

  /// Карточки.
  final Color surface;

  /// Плашки-пояснения, сегментированные переключатели.
  final Color surfaceMuted;

  final Color textPrimary;
  final Color textSecondary;
  final Color textMuted;

  final Color border;
  final Color borderStrong;
  final Color divider;

  /// Рамка невыбранного переключателя / чекбокса.
  final Color control;

  /// «Принято» и главное действие.
  final Color primary;
  final Color primaryPressed;
  final Color onPrimary;
  final Color primarySoft;
  final Color onPrimarySoft;

  /// Цвет ссылок и текстовых действий («+ Добавить»).
  final Color accentText;

  final Color secondaryButton;
  final Color onSecondaryButton;

  /// Тёмная кнопка («Позвонить», «Купила»).
  final Color inverse;
  final Color onInverse;

  /// Рамка контурных кнопок в простом режиме.
  final Color outlineStrong;

  /// Фон экрана «Готово!» в простом режиме.
  final Color success;

  /// «Скоро» / отложено — янтарный, не красный.
  final Color soon;
  final Color soonSoft;
  final Color onSoonSoft;

  /// Только для реального пропуска.
  final Color missed;
  final Color missedSoft;
  final Color onMissedSoft;

  static AppColors resolve(ThemeVariant variant, Brightness brightness) {
    final simple = variant == ThemeVariant.simple;
    if (brightness == Brightness.light) {
      return AppColors(
        background: simple ? AppPalette.simplePaper : AppPalette.paper,
        surface: AppPalette.white,
        surfaceMuted: AppPalette.sandMuted,
        textPrimary: simple ? AppPalette.simpleInk : AppPalette.ink,
        textSecondary: AppPalette.inkSecondary,
        textMuted: AppPalette.inkMuted,
        border: AppPalette.border,
        borderStrong:
            simple ? AppPalette.simpleBorderStrong : AppPalette.borderStrong,
        divider: AppPalette.divider,
        control: AppPalette.control,
        primary: simple ? AppPalette.simpleGreen : AppPalette.green,
        primaryPressed:
            simple ? AppPalette.simpleGreenPressed : AppPalette.greenPressed,
        onPrimary: AppPalette.white,
        primarySoft: simple ? AppPalette.simpleSuccess : AppPalette.greenSoft,
        onPrimarySoft: AppPalette.greenDeep,
        accentText: AppPalette.green,
        secondaryButton: AppPalette.sand,
        onSecondaryButton: simple ? AppPalette.simpleInk : AppPalette.ink,
        inverse: AppPalette.ink,
        onInverse: AppPalette.white,
        outlineStrong: simple ? AppPalette.simpleInk : AppPalette.ink,
        success: AppPalette.simpleSuccess,
        soon: AppPalette.amber,
        soonSoft: AppPalette.amberSoft,
        onSoonSoft: AppPalette.amberText,
        missed: AppPalette.red,
        missedSoft: AppPalette.redSoft,
        onMissedSoft: AppPalette.redText,
      );
    }
    return AppColors(
      background: simple ? AppPalette.simpleCoal : AppPalette.coal,
      surface: AppPalette.coalSurface,
      surfaceMuted: AppPalette.coalMuted,
      textPrimary: simple ? AppPalette.white : AppPalette.linen,
      textSecondary: AppPalette.linenSecondary,
      textMuted: AppPalette.linenMuted,
      border: AppPalette.coalBorder,
      borderStrong: AppPalette.coalBorderStrong,
      divider: AppPalette.coalBorder,
      control: AppPalette.coalControl,
      primary: simple ? AppPalette.simpleGreenDark : AppPalette.greenDark,
      primaryPressed: simple
          ? AppPalette.simpleGreenDarkPressed
          : AppPalette.greenDarkPressed,
      onPrimary: simple ? AppPalette.simpleOnGreenDark : AppPalette.onGreenDark,
      primarySoft: AppPalette.greenDarkSoft,
      onPrimarySoft: AppPalette.greenDarkText,
      accentText: AppPalette.greenDarkText,
      secondaryButton: AppPalette.coalRaised,
      onSecondaryButton: simple ? AppPalette.white : AppPalette.linen,
      inverse: AppPalette.linen,
      onInverse: AppPalette.coal,
      outlineStrong: simple ? AppPalette.white : AppPalette.linen,
      success: AppPalette.simpleSuccessDark,
      soon: AppPalette.amberDark,
      soonSoft: AppPalette.amberDarkSoft,
      onSoonSoft: AppPalette.amberDark,
      missed: AppPalette.redDark,
      missedSoft: AppPalette.redDarkSoft,
      onMissedSoft: AppPalette.redDarkText,
    );
  }

  @override
  AppColors copyWith() => this;

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    Color l(Color a, Color b) => Color.lerp(a, b, t)!;
    return AppColors(
      background: l(background, other.background),
      surface: l(surface, other.surface),
      surfaceMuted: l(surfaceMuted, other.surfaceMuted),
      textPrimary: l(textPrimary, other.textPrimary),
      textSecondary: l(textSecondary, other.textSecondary),
      textMuted: l(textMuted, other.textMuted),
      border: l(border, other.border),
      borderStrong: l(borderStrong, other.borderStrong),
      divider: l(divider, other.divider),
      control: l(control, other.control),
      primary: l(primary, other.primary),
      primaryPressed: l(primaryPressed, other.primaryPressed),
      onPrimary: l(onPrimary, other.onPrimary),
      primarySoft: l(primarySoft, other.primarySoft),
      onPrimarySoft: l(onPrimarySoft, other.onPrimarySoft),
      accentText: l(accentText, other.accentText),
      secondaryButton: l(secondaryButton, other.secondaryButton),
      onSecondaryButton: l(onSecondaryButton, other.onSecondaryButton),
      inverse: l(inverse, other.inverse),
      onInverse: l(onInverse, other.onInverse),
      outlineStrong: l(outlineStrong, other.outlineStrong),
      success: l(success, other.success),
      soon: l(soon, other.soon),
      soonSoft: l(soonSoft, other.soonSoft),
      onSoonSoft: l(onSoonSoft, other.onSoonSoft),
      missed: l(missed, other.missed),
      missedSoft: l(missedSoft, other.missedSoft),
      onMissedSoft: l(onMissedSoft, other.onMissedSoft),
    );
  }
}
