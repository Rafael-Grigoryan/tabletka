import 'package:flutter/material.dart';

import 'theme_variant.dart';

/// Шрифты из дизайна: Onest — интерфейс, Lora — заголовки и «тёплые моменты».
/// Оба вложены в приложение (assets/fonts), интернет для них не нужен.
abstract final class AppFonts {
  static const ui = 'Onest';
  static const display = 'Lora';
}

/// Типографика. Как роли Material соответствуют дизайну:
///
/// | роль           | обычный вид                    | простой режим        |
/// |----------------|--------------------------------|----------------------|
/// | displaySmall   | Lora 36 — итоги дня            | Lora 48 — «Готово!»  |
/// | headlineSmall  | Lora 24 — заголовок экрана     | 30/700 — «Сегодня»   |
/// | titleLarge     | 24/600 — вопрос на экране      | 26/600 — приветствие |
/// | titleMedium    | 22/600 — название лекарства    | 34/700               |
/// | titleSmall     | 17/600 — заголовок карточки    | 24/700               |
/// | bodyLarge      | 16                             | 26                   |
/// | bodyMedium     | 15                             | 24                   |
/// | bodySmall      | 14 — пояснения                 | 22                   |
/// | labelLarge     | 17/600 — кнопка                | 28/700               |
/// | labelMedium    | 13/600 — подписи разделов      | 22/600               |
/// | labelSmall     | 12/600 — надстрочные подписи   | 22/600               |
///
/// В простом режиме ни один стиль не меньше 22 sp — это проверяется тестом.
abstract final class AppTypography {
  static TextTheme textTheme(ThemeVariant variant, Color color) {
    final t = variant == ThemeVariant.simple ? _simple : _standard;
    return t.apply(bodyColor: color, displayColor: color);
  }

  static TextStyle _ui(double size, FontWeight weight, [double height = 1.3]) =>
      TextStyle(
        fontFamily: AppFonts.ui,
        fontSize: size,
        fontWeight: weight,
        height: height,
      );

  static TextStyle _display(double size, [double height = 1.2]) => TextStyle(
        fontFamily: AppFonts.display,
        fontSize: size,
        fontWeight: FontWeight.w600,
        height: height,
      );

  static const _regular = FontWeight.w400;
  static const _medium = FontWeight.w500;
  static const _semi = FontWeight.w600;
  static const _bold = FontWeight.w700;

  static final _standard = TextTheme(
    displaySmall: _display(36, 1.15),
    headlineSmall: _display(24, 1.25),
    titleLarge: _ui(24, _semi, 1.2),
    titleMedium: _ui(22, _semi, 1.25),
    titleSmall: _ui(17, _semi, 1.3),
    bodyLarge: _ui(16, _regular, 1.4),
    bodyMedium: _ui(15, _regular, 1.4),
    bodySmall: _ui(14, _regular, 1.4),
    labelLarge: _ui(17, _semi),
    labelMedium: _ui(13, _semi),
    labelSmall: _ui(12, _semi).copyWith(letterSpacing: 0.72),
  );

  static final _simple = TextTheme(
    displaySmall: _display(48, 1.1),
    headlineSmall: _ui(30, _bold, 1.2),
    titleLarge: _ui(26, _semi, 1.2),
    titleMedium: _ui(34, _bold, 1.1),
    titleSmall: _ui(24, _bold, 1.25),
    bodyLarge: _ui(26, _regular, 1.3),
    bodyMedium: _ui(24, _regular, 1.35),
    bodySmall: _ui(22, _regular, 1.35),
    labelLarge: _ui(28, _bold),
    labelMedium: _ui(22, _semi),
    labelSmall: _ui(22, _semi),
  );
}

/// Стили, которых нет среди ролей Material. Доступны через `context.textStyles`.
@immutable
class AppTextStyles extends ThemeExtension<AppTextStyles> {
  const AppTextStyles({
    required this.brand,
    required this.caption,
    required this.navLabel,
    required this.buttonMain,
    required this.buttonPrimary,
    required this.buttonSecondary,
  });

  /// Название «Рядом» в шапке.
  final TextStyle brand;

  /// Мелкие подписи и подсказки.
  final TextStyle caption;

  /// Подписи нижней навигации.
  final TextStyle navLabel;

  /// Главное действие («Выпила»).
  final TextStyle buttonMain;

  /// Основная кнопка («Продолжить»).
  final TextStyle buttonPrimary;

  /// Второстепенная и контурная кнопка.
  final TextStyle buttonSecondary;

  static AppTextStyles resolve(ThemeVariant variant) {
    if (variant == ThemeVariant.simple) {
      return AppTextStyles(
        brand: AppTypography._display(26),
        caption: AppTypography._ui(22, AppTypography._regular, 1.35),
        navLabel: AppTypography._ui(22, AppTypography._semi),
        buttonMain: AppTypography._ui(32, AppTypography._bold, 1.15),
        buttonPrimary: AppTypography._ui(28, AppTypography._bold, 1.15),
        buttonSecondary: AppTypography._ui(22, AppTypography._semi),
      );
    }
    return AppTextStyles(
      brand: AppTypography._display(22),
      caption: AppTypography._ui(13, AppTypography._regular, 1.45),
      navLabel: AppTypography._ui(12, AppTypography._medium),
      buttonMain: AppTypography._ui(18, AppTypography._semi),
      buttonPrimary: AppTypography._ui(17, AppTypography._semi),
      buttonSecondary: AppTypography._ui(16, AppTypography._medium),
    );
  }

  /// Все стили — для проверки минимального размера в тестах.
  List<TextStyle> get all =>
      [brand, caption, navLabel, buttonMain, buttonPrimary, buttonSecondary];

  @override
  AppTextStyles copyWith() => this;

  @override
  AppTextStyles lerp(ThemeExtension<AppTextStyles>? other, double t) {
    if (other is! AppTextStyles) return this;
    TextStyle l(TextStyle a, TextStyle b) => TextStyle.lerp(a, b, t)!;
    return AppTextStyles(
      brand: l(brand, other.brand),
      caption: l(caption, other.caption),
      navLabel: l(navLabel, other.navLabel),
      buttonMain: l(buttonMain, other.buttonMain),
      buttonPrimary: l(buttonPrimary, other.buttonPrimary),
      buttonSecondary: l(buttonSecondary, other.buttonSecondary),
    );
  }
}
