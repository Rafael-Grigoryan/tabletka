import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/app_bottom_bar.dart';

/// Каркас режима с нижней навигацией (полный режим и режим близкого).
/// Каждая вкладка хранит своё состояние и историю переходов.
class ModeShell extends StatelessWidget {
  const ModeShell({
    super.key,
    required this.navigationShell,
    required this.labels,
  });

  final StatefulNavigationShell navigationShell;
  final List<String> labels;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: AppBottomBar(
        labels: labels,
        currentIndex: navigationShell.currentIndex,
        onSelected: (i) => navigationShell.goBranch(
          i,
          initialLocation: i == navigationShell.currentIndex,
        ),
      ),
    );
  }
}
