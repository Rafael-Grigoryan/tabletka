import 'package:flutter/painting.dart';

/// Сырые цвета из дизайна «Рядом» (Claude Design, `Рядом.dc.html`).
///
/// Это единственное место в приложении, где допустимы hex-значения.
/// Экраны используют не палитру, а смысловые цвета из [AppColors]
/// (`context.colors`), которые собираются из этих значений.
///
/// Роли цветов из дизайна: тёплая бумага — фон, глубокий зелёный — «принято»,
/// янтарный — «скоро / отложено», красный — только для настоящих пропусков.
abstract final class AppPalette {
  // ── Светлая тема, обычный вид (полный режим и режим близкого) ──
  static const paper = Color(0xFFF7F2EB);
  static const white = Color(0xFFFFFFFF);
  static const ink = Color(0xFF2A2420);
  static const inkSecondary = Color(0xFF3D342D);
  static const inkMuted = Color(0xFF6B5F55);
  static const border = Color(0xFFE4DACD);
  static const borderStrong = Color(0xFFD9CFC2);
  static const divider = Color(0xFFF1EADF);
  static const sand = Color(0xFFF1EADF); // фон второстепенной кнопки
  static const sandMuted = Color(0xFFEFE7DC); // плашка-пояснение, сегменты
  static const control = Color(0xFFA89B8D); // рамка невыбранного переключателя

  static const green = Color(0xFF2F6B57); // «принято», главное действие
  static const greenPressed = Color(0xFF27594A);
  static const greenDeep = Color(0xFF1F4A3C);
  static const greenSoft = Color(0xFFDCEBE2);

  static const amber = Color(0xFFC9862B); // «скоро», отложено
  static const amberSoft = Color(0xFFF6E7C8);
  static const amberText = Color(0xFF8A5A14);

  static const red = Color(0xFFB8392A); // только реальный пропуск
  static const redSoft = Color(0xFFF7DED8);
  static const redText = Color(0xFF8E2A1F);

  // ── Светлая тема, простой режим ──
  static const simplePaper = Color(0xFFFFFDF8);
  static const simpleInk = Color(0xFF1A1512);
  static const simpleGreen = Color(0xFF24584A);
  static const simpleGreenPressed = Color(0xFF1B4539);
  static const simpleSuccess = Color(0xFFEEF5F0);
  static const simpleBorderStrong = Color(0xFFCFC4B6);

  // ── Тёмная тема: «тёплый уголь вместо чистого чёрного» ──
  static const coal = Color(0xFF1C1916);
  static const coalSurface = Color(0xFF27231F);
  static const coalRaised = Color(0xFF332E29);
  static const coalMuted = Color(0xFF2A2622);
  static const coalBorder = Color(0xFF3A342E);
  static const coalBorderStrong = Color(0xFF4A423A);
  static const coalControl = Color(0xFF7A6F64); // нет в дизайне, подобран
  static const linen = Color(0xFFF2EBE2);
  static const linenSecondary = Color(0xFFD8CDBF);
  static const linenMuted = Color(0xFFB5A99C);

  static const greenDark = Color(0xFF7FC3A6);
  static const greenDarkPressed = Color(0xFF6FB396); // нет в дизайне, подобран
  static const greenDarkText = Color(0xFF9FD6BD);
  static const greenDarkSoft = Color(0xFF23382F);
  static const onGreenDark = Color(0xFF10261D);

  static const amberDark = Color(0xFFE8B86A);
  static const amberDarkSoft = Color(0xFF3A2F1F); // нет в дизайне, подобран

  static const redDark = Color(0xFFE5735F);
  static const redDarkText = Color(0xFFF4A493);
  static const redDarkSoft = Color(0xFF3E231E);

  // ── Тёмная тема, простой режим ──
  static const simpleCoal = Color(0xFF14110F);
  static const simpleGreenDark = Color(0xFF8FD3B5);
  static const simpleGreenDarkPressed = Color(0xFF7CC2A3); // подобран
  static const simpleOnGreenDark = Color(0xFF0B1F17);
  static const simpleSuccessDark = Color(0xFF18241F); // подобран
}
