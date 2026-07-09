import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mind_track/app/routes/app_router.dart';
import 'package:mind_track/app/routes/route_names.dart';

void main() {
  group('AppRouter', () {
    test('returns a route for the main application screens', () {
      final List<String> routeNames = <String>[
        RouteNames.splash,
        RouteNames.onboarding,
        RouteNames.signIn,
        RouteNames.signUp,
        RouteNames.home,
        RouteNames.profile,
        RouteNames.dailyMood,
        RouteNames.analytics,
        RouteNames.habits,
        RouteNames.search,
        RouteNames.notifications,
        RouteNames.coach,
        RouteNames.addEmotion,
      ];

      for (final String routeName in routeNames) {
        final Route<dynamic> route = AppRouter.onGenerateRoute(
          RouteSettings(name: routeName),
        );
        expect(route, isA<PageRoute<dynamic>>(), reason: routeName);
      }
    });

    test('returns the emotion detail route when an id is provided', () {
      final Route<dynamic> route = AppRouter.onGenerateRoute(
        const RouteSettings(
          name: RouteNames.emotionDetail,
          arguments: 'emotion-123',
        ),
      );

      expect(route, isA<PageRoute<dynamic>>());
    });

    test('falls back to splash for unknown routes', () {
      final Route<dynamic> route = AppRouter.onGenerateRoute(
        const RouteSettings(name: '/missing'),
      );

      expect(route, isA<PageRoute<dynamic>>());
    });
  });
}
