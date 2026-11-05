import 'package:flutter/material.dart';

import 'theme_variant.dart';

/// Шкала отступов из дизайна. Одинакова для всех режимов.
abstract final class AppSpacing {
  static const double xxs = 4;
  static const double xs = 6;
  static const double s = 8;
  static const double sm = 10;
  static const double m = 12;
  static const double ml = 14;
  static const double l = 16;
  static const double xl = 20;
  static const double xxl = 24;
  static const double xxxl = 28;
}

/// Шкала радиусов скругления из дизайна.
abstract final class AppRadii {
  static const double xs = 8;
  static const double s = 10;
  static const double sm = 12;
  static const double m = 14;
  static const double ml = 16;
  static const double l = 18;
  static const double xl = 22;
  static const double xxl = 24;
  static const double pill = 999;
}

/// Размеры, которые зависят от режима. Доступны через `context.metrics`.
///
/// В простом режиме все нажимаемые элементы не ниже [minTapTarget] (≥ 60 px).
@immutable
class AppMetrics extends ThemeExtension<AppMetrics> {
  const AppMetrics({
    required this.screenPadding,
    required this.sectionGap,
    required this.minTapTarget,
    required this.mainActionHeight,
    required this.buttonHeight,
    required this.secondaryButtonHeight,
    required this.buttonRadius,
    required this.cardRadius,
    required this.cardPadding,
    required this.cardBorderWidth,
    required this.framedCards,
    required this.radioSize,
    required this.navBarHeight,
  });

  /// Отступы содержимого экрана от краёв.
  final EdgeInsets screenPadding;

  /// Расстояние между блоками на экране.
  final double sectionGap;

  /// Минимальный размер любого нажимаемого элемента.
  final double minTapTarget;

  /// Главное действие экрана («Выпила»).
  final double mainActionHeight;

  /// Обычная основная кнопка («Продолжить», «Сохранить»).
  final double buttonHeight;

  /// Второстепенная кнопка («Напомнить позже»).
  final double secondaryButtonHeight;

  final double buttonRadius;
  final double cardRadius;
  final EdgeInsets cardPadding;
  final double cardBorderWidth;

  /// Карточки всегда с рамкой (простой режим: выше контраст).
  final bool framedCards;
  final double radioSize;
  final double navBarHeight;

  static const standard = AppMetrics(
    screenPadding: EdgeInsets.fromLTRB(18, 14, 18, 12),
    sectionGap: AppSpacing.ml,
    minTapTarget: 48,
    mainActionHeight: 56,
    buttonHeight: 52,
    secondaryButtonHeight: 48,
    buttonRadius: AppRadii.ml,
    cardRadius: AppRadii.l,
    cardPadding: EdgeInsets.all(AppSpacing.ml),
    cardBorderWidth: 1,
    framedCards: false,
    radioSize: 20,
    navBarHeight: 60,
  );

  static const simple = AppMetrics(
    screenPadding: EdgeInsets.fromLTRB(20, 16, 20, 18),
    sectionGap: AppSpacing.l,
    minTapTarget: 64,
    mainActionHeight: 96,
    buttonHeight: 80,
    secondaryButtonHeight: 64,
    buttonRadius: AppRadii.xl,
    cardRadius: AppRadii.xxl,
    cardPadding: EdgeInsets.all(AppSpacing.ml),
    cardBorderWidth: 2,
    framedCards: true,
    radioSize: 28,
    navBarHeight: 72,
  );

  static AppMetrics resolve(ThemeVariant variant) =>
      variant == ThemeVariant.simple ? simple : standard;

  @override
  AppMetrics copyWith() => this;

  @override
  AppMetrics lerp(ThemeExtension<AppMetrics>? other, double t) =>
      t < 0.5 ? this : (other as AppMetrics? ?? this);
}
