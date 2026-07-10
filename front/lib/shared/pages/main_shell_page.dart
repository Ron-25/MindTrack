import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mind_track/features/analytics/presentation/pages/analytics_page.dart';
import 'package:mind_track/features/daily_mood/presentation/pages/daily_mood_page.dart';
import 'package:mind_track/features/habits/presentation/pages/habits_page.dart';
import 'package:mind_track/features/home/presentation/pages/home_page.dart';
import 'package:mind_track/features/profile/presentation/pages/profile_settings_page.dart';
import 'package:mind_track/shared/widget/mindtrack_bottom_nav.dart';

/// Contenedor principal de la app: mantiene la barra de navegación inferior
/// visible en todas las tabs y conserva el estado de cada una.
class MainShellPage extends StatefulWidget {
  const MainShellPage({super.key, this.initialIndex = 0});

  final int initialIndex;

  static const int homeTab = 0;
  static const int historyTab = 1;
  static const int analyticsTab = 2;
  static const int habitsTab = 3;
  static const int profileTab = 4;

  /// Permite a las páginas hijas cambiar de tab sin apilar rutas.
  static MainShellPageState? of(BuildContext context) {
    return context.findAncestorStateOfType<MainShellPageState>();
  }

  @override
  State<MainShellPage> createState() => MainShellPageState();
}

class MainShellPageState extends State<MainShellPage> {
  late int _currentIndex = widget.initialIndex;

  void goToTab(int index) {
    if (index == _currentIndex) {
      return;
    }
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarContrastEnforced: false,
      ),
      child: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: const <Widget>[
            HomePage(),
            DailyMoodPage(),
            AnalyticsPage(),
            HabitsPage(),
            ProfileSettingsPage(),
          ],
        ),
        bottomNavigationBar: MindTrackBottomNav(
          currentIndex: _currentIndex,
          onTap: goToTab,
        ),
      ),
    );
  }
}
