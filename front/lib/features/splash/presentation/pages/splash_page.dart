import 'package:flutter/material.dart';
import 'package:mind_track/app/theme/mt_colors.dart';
import 'package:mind_track/app/injector.dart';
import 'package:mind_track/app/routes/route_names.dart';
import 'package:mind_track/core/services/token_storage_service.dart';
import 'package:mind_track/shared/widget/app_circle_icon.dart';
import '../../../../shared/pages/app_background_page.dart';
import 'package:mind_track/app/generated/l10n.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text_styles.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool _showButton = false;

  @override
  void initState() {
    super.initState();
    _checkSession();
  }

  Future<void> _checkSession() async {
    // Pausa mínima para mostrar el splash
    await Future<void>.delayed(const Duration(milliseconds: 1500));

    if (!mounted) return;

    final TokenStorageService storage = Injector.get<TokenStorageService>();
    final String? token = await storage.getAccessToken();

    if (!mounted) return;

    if (token != null && token.isNotEmpty) {
      Navigator.of(context).pushReplacementNamed(RouteNames.home);
    } else {
      setState(() => _showButton = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final S translation = S.of(context);

    return AppBackgroundPage(
      child: Column(
        children: <Widget>[
          const Spacer(flex: 2),

          const AppCircleIcon(icon: Icons.bolt_rounded),

          const SizedBox(height: 28),

          Text(
            translation.title_splash,
            style: AppTextStyles.headlineMedium.copyWith(
              fontSize: 30,
              fontWeight: FontWeight.w700,
              color: context.mtColors.textPrimary,
            ),
          ),

          const SizedBox(height: 18),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48),
            child: Text(
              translation.splash_message,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyMedium.copyWith(
                fontSize: 16,
                height: 1.7,
                color: context.mtColors.textSecondary,
              ),
            ),
          ),

          const Spacer(flex: 3),

          Center(
            child: Text(
              translation.splash_message_part2,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodySmall.copyWith(
                fontSize: 10,
                color: context.mtColors.textSecondary,
              ),
            ),
          ),

          const SizedBox(height: 28),

          AnimatedOpacity(
            opacity: _showButton ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 300),
            child: TextButton(
              onPressed: _showButton
                  ? () => Navigator.of(context).pushNamed(RouteNames.onboarding)
                  : null,
              child: Text(
                translation.start_journey,
                style: AppTextStyles.bodyMedium.copyWith(
                  fontSize: 14,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),

          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
