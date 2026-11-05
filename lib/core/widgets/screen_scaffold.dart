import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Основа экрана: фон, безопасные зоны и прокрутка.
///
/// Содержимое растягивается на всю высоту (можно использовать `Spacer`,
/// чтобы прижать кнопку к низу), а если не помещается — например, при
/// увеличенном системном шрифте — прокручивается.
///
/// [footer] закреплён внизу и не прокручивается: главное действие экрана
/// всегда на виду.
class ScreenScaffold extends StatelessWidget {
  const ScreenScaffold({
    super.key,
    required this.children,
    this.padding,
    this.gap,
    this.backgroundColor,
    this.bottomBar,
    this.footer = const [],
    this.crossAxisAlignment = CrossAxisAlignment.stretch,
  });

  final List<Widget> children;
  final EdgeInsets? padding;
  final double? gap;
  final Color? backgroundColor;
  final Widget? bottomBar;
  final List<Widget> footer;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    final metrics = context.metrics;
    final spacing = gap ?? metrics.sectionGap;
    final base = padding ?? metrics.screenPadding;
    final scrollPadding = footer.isEmpty ? base : base.copyWith(bottom: 0);

    final scrollArea = LayoutBuilder(
      builder: (context, constraints) => SingleChildScrollView(
        padding: scrollPadding,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: constraints.maxHeight - scrollPadding.vertical,
          ),
          child: IntrinsicHeight(
            child: Column(
              crossAxisAlignment: crossAxisAlignment,
              children: _withGaps(children, spacing),
            ),
          ),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: backgroundColor,
      bottomNavigationBar: bottomBar,
      body: SafeArea(
        bottom: bottomBar == null,
        child: footer.isEmpty
            ? scrollArea
            : Column(
                children: [
                  Expanded(child: scrollArea),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                      base.left,
                      spacing,
                      base.right,
                      base.bottom,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: _withGaps(footer, spacing),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  static List<Widget> _withGaps(List<Widget> children, double gap) => [
        for (var i = 0; i < children.length; i++) ...[
          if (i > 0 && children[i] is! Spacer) SizedBox(height: gap),
          children[i],
        ],
      ];
}

/// Текстовая ссылка «← Назад» из дизайна.
class BackLink extends StatelessWidget {
  const BackLink({super.key, required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Semantics(
        button: true,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppRadii.s),
          child: ConstrainedBox(
            constraints:
                BoxConstraints(minHeight: context.metrics.minTapTarget),
            child: Padding(
              padding: const EdgeInsets.only(right: AppSpacing.m),
              child: Align(
                alignment: Alignment.centerLeft,
                widthFactor: 1,
                child: Text(
                  label,
                  style: context.text.bodyMedium
                      ?.copyWith(color: context.colors.textMuted),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
