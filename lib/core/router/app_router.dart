import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/home/ui/full/now_screen.dart';
import '../../features/home/ui/mode_shell.dart';
import '../../features/home/ui/simple/simple_home_screen.dart';
import '../../features/home/ui/widgets/placeholder_tab.dart';
import '../../features/onboarding/ui/mode_select_screen.dart';
import '../../features/settings/domain/app_settings.dart';
import '../../features/settings/state/settings_controller.dart';
import '../../features/settings/ui/more_screen.dart';
import '../../features/settings/ui/simple_settings_screen.dart';
import '../../l10n/l10n.dart';
import 'routes.dart';

/// Куда перенаправить пользователя, исходя из выбранного режима.
///
/// - режим не выбран → всегда экран выбора режима;
/// - режим выбран → нельзя попасть на экран первого запуска
///   и в разделы других режимов.
@visibleForTesting
String? redirectFor(AppMode? mode, String location) {
  if (mode == null) {
    return location == Routes.welcome ? null : Routes.welcome;
  }
  if (location == Routes.changeMode) return null;
  final section = Routes.sectionFor(mode);
  if (location == section || location.startsWith('$section/')) return null;
  return Routes.homeFor(mode);
}

final routerProvider = Provider<GoRouter>((ref) {
  // Роутер создаётся один раз; при смене режима только пересчитывается redirect.
  final refresh = ValueNotifier<int>(0);
  ref.listen(appModeProvider, (_, __) => refresh.value++);
  ref.onDispose(refresh.dispose);

  final router = GoRouter(
    initialLocation: Routes.welcome,
    refreshListenable: refresh,
    redirect: (context, state) =>
        redirectFor(ref.read(appModeProvider), state.matchedLocation),
    routes: [
      GoRoute(
        path: Routes.welcome,
        builder: (_, __) => const ModeSelectScreen(isFirstRun: true),
      ),
      GoRoute(
        path: Routes.changeMode,
        builder: (_, __) => const ModeSelectScreen(isFirstRun: false),
      ),

      // ── Полный режим: Сейчас · План · Запасы · Ещё ──
      GoRoute(path: Routes.full, redirect: (_, __) => Routes.fullNow),
      StatefulShellRoute.indexedStack(
        builder: (context, _, shell) => ModeShell(
          navigationShell: shell,
          labels: [
            context.l10n.navNow,
            context.l10n.navPlan,
            context.l10n.navStock,
            context.l10n.navMore,
          ],
        ),
        branches: [
          _branch(Routes.fullNow, (_) => const NowScreen()),
          _branch(
            Routes.fullPlan,
            (c) => PlaceholderTab(
              title: c.l10n.planTitle,
              emptyTitle: c.l10n.planEmptyTitle,
              emptyText: c.l10n.planEmptyText,
            ),
          ),
          _branch(
            Routes.fullStock,
            (c) => PlaceholderTab(
              title: c.l10n.stockTitle,
              emptyTitle: c.l10n.stockEmptyTitle,
              emptyText: c.l10n.stockEmptyText,
            ),
          ),
          _branch(Routes.fullMore, (_) => const MoreScreen()),
        ],
      ),

      // ── Простой режим: без вкладок ──
      GoRoute(
        path: Routes.simple,
        builder: (_, __) => const SimpleHomeScreen(),
        routes: [
          GoRoute(
            path: 'settings',
            builder: (_, __) => const SimpleSettingsScreen(),
          ),
        ],
      ),

      // ── Режим близкого: Близкие · Моё · Ещё ──
      GoRoute(
        path: Routes.caregiver,
        redirect: (_, __) => Routes.caregiverRelatives,
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, _, shell) => ModeShell(
          navigationShell: shell,
          labels: [
            context.l10n.navRelatives,
            context.l10n.navMine,
            context.l10n.navMore,
          ],
        ),
        branches: [
          _branch(
            Routes.caregiverRelatives,
            (c) => PlaceholderTab(
              title: c.l10n.relativesTitle,
              emptyTitle: c.l10n.relativesEmptyTitle,
              emptyText: c.l10n.relativesEmptyText,
            ),
          ),
          _branch(
            Routes.caregiverMine,
            (c) => PlaceholderTab(
              title: c.l10n.mineTitle,
              emptyTitle: c.l10n.mineEmptyTitle,
              emptyText: c.l10n.mineEmptyText,
            ),
          ),
          _branch(Routes.caregiverMore, (_) => const MoreScreen()),
        ],
      ),
    ],
  );
  ref.onDispose(router.dispose);
  return router;
});

StatefulShellBranch _branch(String path, Widget Function(BuildContext) build) =>
    StatefulShellBranch(
      routes: [GoRoute(path: path, builder: (context, _) => build(context))],
    );
