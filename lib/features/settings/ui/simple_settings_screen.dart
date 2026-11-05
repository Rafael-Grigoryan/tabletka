import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/screen_scaffold.dart';
import '../../../l10n/l10n.dart';
import 'settings_sections.dart';

/// Настройки простого режима. Открываются скрытым жестом с главного экрана,
/// рассчитаны на близкого, который настраивает телефон.
class SimpleSettingsScreen extends StatelessWidget {
  const SimpleSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return ScreenScaffold(
      footer: [
        AppButton(
          label: l10n.actionBack,
          variant: AppButtonVariant.outlineStrong,
          onPressed: () => context.pop(),
        ),
      ],
      children: [
        Semantics(
          header: true,
          child: Text(l10n.settingsTitle, style: context.text.headlineSmall),
        ),
        const SettingsSections(),
      ],
    );
  }
}
