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
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Color(0xFFE2E8F0))),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Color(0x1A000000),
              blurRadius: 20,
              offset: Offset(0, -6),
            ),
          ],
        ),
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
        child: Row(
          children: List<Widget>.generate(items.length, (int index) {
            final bool isSelected = currentIndex == index;
            final Color color = isSelected
                ? AppColors.primary
                : const Color(0xFF94A3B8);
            return Expanded(
              child: InkWell(
                onTap: () => onTap(index),
                borderRadius: BorderRadius.circular(16),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(items[index].icon, size: 20, color: color),
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
