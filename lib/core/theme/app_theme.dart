import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';
import 'app_metrics.dart';
import 'app_typography.dart';
import 'theme_variant.dart';

export 'app_colors.dart';
export 'app_metrics.dart';
export 'app_typography.dart';
export 'theme_variant.dart';

/// Сборка [ThemeData] для варианта оформления и яркости.
abstract final class AppTheme {
  static ThemeData build(ThemeVariant variant, Brightness brightness) {
    final colors = AppColors.resolve(variant, brightness);
    final metrics = AppMetrics.resolve(variant);
    final textStyles = AppTextStyles.resolve(variant);
    final textTheme = AppTypography.textTheme(variant, colors.textPrimary);

    final scheme = ColorScheme(
      brightness: brightness,
      primary: colors.primary,
      onPrimary: colors.onPrimary,
      primaryContainer: colors.primarySoft,
      onPrimaryContainer: colors.onPrimarySoft,
      secondary: colors.soon,
      onSecondary: colors.onPrimary,
      secondaryContainer: colors.secondaryButton,
      onSecondaryContainer: colors.onSecondaryButton,
      error: colors.missed,
      onError: colors.onPrimary,
      errorContainer: colors.missedSoft,
      onErrorContainer: colors.onMissedSoft,
      background: colors.background,
      onBackground: colors.textPrimary,
      surface: colors.surface,
      onSurface: colors.textPrimary,
      onSurfaceVariant: colors.textMuted,
      outline: colors.borderStrong,
      outlineVariant: colors.border,
      inverseSurface: colors.inverse,
      onInverseSurface: colors.onInverse,
      surfaceTint: Colors.transparent,
      shadow: Colors.black,
    );

    final buttonShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(metrics.buttonRadius),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      fontFamily: AppFonts.ui,
      textTheme: textTheme,
      scaffoldBackgroundColor: colors.background,
      canvasColor: colors.background,
      dividerColor: colors.divider,
      splashFactory: InkSparkle.splashFactory,
      materialTapTargetSize: MaterialTapTargetSize.padded,
      extensions: [colors, metrics, textStyles],
      appBarTheme: AppBarTheme(
        backgroundColor: colors.background,
        foregroundColor: colors.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: textTheme.headlineSmall,
        systemOverlayStyle: _overlayStyle(brightness, colors.background),
      ),
      dividerTheme: DividerThemeData(
        color: colors.divider,
        thickness: 1,
        space: 1,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: colors.primary,
          foregroundColor: colors.onPrimary,
          minimumSize: Size(metrics.minTapTarget, metrics.buttonHeight),
          shape: buttonShape,
          textStyle: textStyles.buttonPrimary,
          elevation: 0,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colors.accentText,
          minimumSize: Size(metrics.minTapTarget, metrics.buttonHeight),
          shape: buttonShape,
          side: BorderSide(color: colors.primary, width: 2),
          textStyle: textStyles.buttonSecondary,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colors.accentText,
          minimumSize: Size(metrics.minTapTarget, metrics.minTapTarget),
          textStyle:
              textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: colors.inverse,
        contentTextStyle:
            textTheme.bodyMedium?.copyWith(color: colors.onInverse),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  /// Стиль системной строки состояния и навигационной панели.
  static SystemUiOverlayStyle overlayStyleFor(ThemeData theme) =>
      _overlayStyle(theme.brightness, theme.scaffoldBackgroundColor);

  static SystemUiOverlayStyle _overlayStyle(
    Brightness brightness,
    Color background,
  ) {
    final base = brightness == Brightness.dark
        ? SystemUiOverlayStyle.light
        : SystemUiOverlayStyle.dark;
    return base.copyWith(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: background,
      systemNavigationBarIconBrightness:
          brightness == Brightness.dark ? Brightness.light : Brightness.dark,
    );
  }
}

/// Короткий доступ к токенам темы из виджетов.
extension AppThemeContext on BuildContext {
  AppColors get colors => Theme.of(this).extension<AppColors>()!;
  AppMetrics get metrics => Theme.of(this).extension<AppMetrics>()!;
  AppTextStyles get textStyles => Theme.of(this).extension<AppTextStyles>()!;
  TextTheme get text => Theme.of(this).textTheme;
}
