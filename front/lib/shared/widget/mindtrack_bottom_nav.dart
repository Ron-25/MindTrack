import 'package:flutter/material.dart';
import 'package:mind_track/app/generated/l10n.dart';
import 'package:mind_track/app/theme/app_colors.dart';

class MindTrackBottomNav extends StatelessWidget {
  const MindTrackBottomNav({
    required this.currentIndex,
    required this.onTap,
    super.key,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    final S translations = S.of(context);
    final ColorScheme colors = Theme.of(context).colorScheme;
    final List<_NavItem> items = <_NavItem>[
      _NavItem(label: translations.home_nav_home, icon: Icons.home_outlined),
      _NavItem(
        label: translations.home_nav_history,
        icon: Icons.history_toggle_off_rounded,
      ),
      _NavItem(
        label: translations.home_nav_analytics,
        icon: Icons.insights_outlined,
      ),
      _NavItem(
        label: translations.home_nav_habits,
        icon: Icons.calendar_today_outlined,
      ),
      _NavItem(
        label: translations.home_nav_profile,
        icon: Icons.person_outline_rounded,
      ),
    ];

    return SafeArea(
      top: false,
      minimum: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      child: Container(
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(28),
          boxShadow: const <BoxShadow>[
            BoxShadow(
              color: Color(0x1F000000),
              blurRadius: 24,
              offset: Offset(0, 10),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        child: Row(
          children: List<Widget>.generate(items.length, (int index) {
            final bool isSelected = currentIndex == index;
            final Color color = isSelected
                ? AppColors.primary
                : colors.onSurfaceVariant;
            return Expanded(
              child: InkWell(
                onTap: () => onTap(index),
                borderRadius: BorderRadius.circular(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeOut,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.primary.withValues(alpha: 0.14)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(items[index].icon, size: 20, color: color),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      items[index].label,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.3,
                        color: color,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class _NavItem {
  const _NavItem({required this.label, required this.icon});

  final String label;
  final IconData icon;
}
