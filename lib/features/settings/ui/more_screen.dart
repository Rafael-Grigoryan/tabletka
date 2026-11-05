import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/screen_scaffold.dart';
import '../../../l10n/l10n.dart';
import 'settings_sections.dart';

/// Вкладка «Ещё» в полном режиме и режиме близкого.
/// Позже сюда добавятся «История», «Близкие», «Уведомления».
class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      gap: AppSpacing.m,
      children: [
        Semantics(
          header: true,
          child:
              Text(context.l10n.moreTitle, style: context.text.headlineSmall),
        ),
        const SettingsSections(),
      ],
    );
  }
}
