import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/routes.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/screen_scaffold.dart';
import '../../../l10n/l10n.dart';
import '../../settings/domain/app_settings.dart';
import '../../settings/state/settings_controller.dart';
import 'mode_option_card.dart';

/// Выбор режима (O1). Показывается при первом запуске и при смене режима.
///
/// Всегда в обычном оформлении — даже если сейчас включён простой режим.
class ModeSelectScreen extends ConsumerStatefulWidget {
  const ModeSelectScreen({super.key, required this.isFirstRun});

  /// При первом запуске нет кнопки «Назад» и ничего не выбрано заранее.
  final bool isFirstRun;

  @override
  ConsumerState<ModeSelectScreen> createState() => _ModeSelectScreenState();
}

class _ModeSelectScreenState extends ConsumerState<ModeSelectScreen> {
  AppMode? _selected;

  @override
  void initState() {
    super.initState();
    if (!widget.isFirstRun) _selected = ref.read(appModeProvider);
  }

  Future<void> _continue() async {
    final mode = _selected;
    if (mode == null) return;
    await ref.read(settingsControllerProvider.notifier).setMode(mode);
    if (mounted) context.go(Routes.homeFor(mode));
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Theme(
      data: AppTheme.build(ThemeVariant.standard, brightness),
      child: Builder(builder: _buildContent),
    );
  }

  Widget _buildContent(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.colors;

    Widget option(AppMode mode, String title, String subtitle) =>
        ModeOptionCard(
          title: title,
          subtitle: subtitle,
          selected: _selected == mode,
          onTap: () => setState(() => _selected = mode),
        );

    return ScreenScaffold(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.xl,
        AppSpacing.xl,
        AppSpacing.xl,
        AppSpacing.l,
      ),
      gap: AppSpacing.m,
      footer: [
        Text(
          l10n.onboardingHint,
          textAlign: TextAlign.center,
          style: context.textStyles.caption.copyWith(color: colors.textMuted),
        ),
        AppButton(
          label: l10n.actionContinue,
          onPressed: _selected == null ? null : _continue,
        ),
      ],
      children: [
        if (!widget.isFirstRun)
          BackLink(label: l10n.actionBack, onTap: () => context.pop()),
        Text(
          l10n.appTitle,
          style: context.textStyles.brand.copyWith(color: colors.accentText),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.xxs),
          child: Text(
            l10n.onboardingQuestion,
            style: context.text.titleLarge,
          ),
        ),
        option(AppMode.full, l10n.modeFullTitle, l10n.modeFullSubtitle),
        option(AppMode.simple, l10n.modeSimpleTitle, l10n.modeSimpleSubtitle),
        option(
          AppMode.caregiver,
          l10n.modeCaregiverTitle,
          l10n.modeCaregiverSubtitle,
        ),
      ],
    );
  }
}
