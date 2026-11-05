import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'features/settings/domain/app_settings.dart';
import 'features/settings/state/settings_controller.dart';
import 'l10n/l10n.dart';

class RyadomApp extends ConsumerWidget {
  const RyadomApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsControllerProvider);
    final router = ref.watch(routerProvider);
    final variant = settings.mode == AppMode.simple
        ? ThemeVariant.simple
        : ThemeVariant.standard;

    return MaterialApp.router(
      onGenerateTitle: (context) => context.l10n.appTitle,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.build(variant, Brightness.light),
      darkTheme: AppTheme.build(variant, Brightness.dark),
      themeMode: settings.themeMode,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: router,
      builder: (context, child) => AnnotatedRegion<SystemUiOverlayStyle>(
        value: AppTheme.overlayStyleFor(Theme.of(context)),
        child: child!,
      ),
    );
  }
}
