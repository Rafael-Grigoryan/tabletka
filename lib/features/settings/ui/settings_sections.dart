import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/routes.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/choice_tile.dart';
import '../../../l10n/l10n.dart';
import '../state/settings_controller.dart';

/// Общие разделы настроек: оформление, режим и медицинское пояснение.
/// Используются во вкладке «Ещё» и в настройках простого режима.
class SettingsSections extends ConsumerWidget {
  const SettingsSections({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final colors = context.colors;
    final settings = ref.watch(settingsControllerProvider);
    final controller = ref.read(settingsControllerProvider.notifier);
    final sectionStyle =
        context.text.labelMedium?.copyWith(color: colors.textMuted);

    Widget themeOption(ThemeMode mode, String label) => ChoiceTile(
          label: label,
          selected: settings.themeMode == mode,
          onTap: () => controller.setThemeMode(mode),
        );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(l10n.settingsAppearance, style: sectionStyle),
        const SizedBox(height: AppSpacing.s),
        AppCard(
          child: Column(
            children: [
              themeOption(ThemeMode.system, l10n.themeSystem),
              const SizedBox(height: AppSpacing.xs),
              themeOption(ThemeMode.light, l10n.themeLight),
              const SizedBox(height: AppSpacing.xs),
              themeOption(ThemeMode.dark, l10n.themeDark),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.l),
        Text(l10n.settingsMode, style: sectionStyle),
        const SizedBox(height: AppSpacing.s),
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (settings.mode != null)
                Text(
                  l10n.settingsCurrentMode(l10n.modeName(settings.mode!.name)),
                  style: context.text.bodyLarge,
                ),
              const SizedBox(height: AppSpacing.m),
              AppButton(
                label: l10n.actionChangeMode,
                variant: AppButtonVariant.secondary,
                onPressed: () => context.push(Routes.changeMode),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.l),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.m,
            vertical: AppSpacing.sm,
          ),
          decoration: BoxDecoration(
            color: colors.surfaceMuted,
            borderRadius: BorderRadius.circular(AppRadii.sm),
          ),
          child: Text(
            l10n.medicalDisclaimer,
            style: context.textStyles.caption.copyWith(color: colors.textMuted),
          ),
        ),
      ],
    );
  }
}
