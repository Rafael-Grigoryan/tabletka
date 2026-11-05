import '../../features/settings/domain/app_settings.dart';

/// Пути экранов. Используйте эти константы вместо строк.
abstract final class Routes {
  /// Выбор режима при первом запуске.
  static const welcome = '/welcome';

  /// Смена режима из настроек (тот же экран, с кнопкой «Назад»).
  static const changeMode = '/mode';

  // Полный режим
  static const full = '/full';
  static const fullNow = '/full/now';
  static const fullPlan = '/full/plan';
  static const fullStock = '/full/stock';
  static const fullMore = '/full/more';

  // Простой режим
  static const simple = '/simple';
  static const simpleSettings = '/simple/settings';

  // Режим близкого
  static const caregiver = '/care';
  static const caregiverRelatives = '/care/relatives';
  static const caregiverMine = '/care/mine';
  static const caregiverMore = '/care/more';

  /// Главный экран режима.
  static String homeFor(AppMode mode) => switch (mode) {
        AppMode.full => fullNow,
        AppMode.simple => simple,
        AppMode.caregiver => caregiverRelatives,
      };

  /// Раздел, в котором должен находиться пользователь этого режима.
  static String sectionFor(AppMode mode) => switch (mode) {
        AppMode.full => full,
        AppMode.simple => simple,
        AppMode.caregiver => caregiver,
      };
}
