import 'package:flutter/material.dart';
import 'package:mind_track/features/analytics/presentation/pages/analytics_page.dart';
import 'package:mind_track/features/coach/presentation/pages/coach_page.dart';
import 'package:mind_track/features/daily_mood/presentation/pages/daily_mood_page.dart';
import 'package:mind_track/features/emotion_tracker/presentation/pages/add_emotion_page.dart';
import 'package:mind_track/features/emotion_tracker/presentation/pages/emotion_detail_page.dart';
import 'package:mind_track/features/habits/presentation/pages/habits_page.dart';
import 'package:mind_track/features/home/presentation/pages/home_page.dart';
import 'package:mind_track/features/login/presentation/pages/sign_in_page.dart';
import 'package:mind_track/features/login/presentation/pages/sign_up_page.dart';
import 'package:mind_track/features/notifications/presentation/pages/notifications_page.dart';
import 'package:mind_track/features/onboarning/presentation/pages/onboarning_page.dart';
import 'package:mind_track/features/profile/presentation/pages/profile_settings_page.dart';
import 'package:mind_track/features/splash/presentation/pages/splash_page.dart';
import 'route_names.dart';

class AppRouter {
  AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splash:
        return _fade(const SplashPage());
      case RouteNames.onboarding:
        return _slide(const OnboarningPage());
      case RouteNames.signIn:
        return _slide(const SignInPage());
      case RouteNames.signUp:
        return _slide(const SignUp());
      case RouteNames.home:
        return _fade(const HomePage());
      case RouteNames.profile:
        return _slide(const ProfileSettingsPage());
      case RouteNames.dailyMood:
        return _slide(const DailyMoodPage());
      case RouteNames.analytics:
        return _slide(const AnalyticsPage());
      case RouteNames.habits:
        return _slide(const HabitsPage());
      case RouteNames.search:
        return _slide(const DailyMoodPage(searchMode: true));
      case RouteNames.notifications:
        return _slide(const NotificationsPage());
      case RouteNames.coach:
        return _slide(const CoachPage());
      case RouteNames.addEmotion:
        return _slide(const AddEmotionPage());
      case RouteNames.emotionDetail:
        return _slide(
          EmotionDetailPage(emotionId: settings.arguments as String?),
        );
      default:
        return _fade(const SplashPage());
    }
  }

  static PageRoute<T> _fade<T>(Widget page) {
    return PageRouteBuilder<T>(
      pageBuilder: (_, _, _) => page,
      transitionsBuilder: (_, Animation<double> animation, _, Widget child) =>
          FadeTransition(opacity: animation, child: child),
      transitionDuration: const Duration(milliseconds: 220),
    );
  }

  static PageRoute<T> _slide<T>(Widget page) {
    return PageRouteBuilder<T>(
      pageBuilder: (_, _, _) => page,
      transitionsBuilder: (_, Animation<double> animation, _, Widget child) {
        final Animatable<Offset> tween = Tween<Offset>(
          begin: const Offset(1.0, 0.0),
          end: Offset.zero,
        ).chain(CurveTween(curve: Curves.easeOutCubic));
        return SlideTransition(position: animation.drive(tween), child: child);
      },
      transitionDuration: const Duration(milliseconds: 280),
    );
  }
}
