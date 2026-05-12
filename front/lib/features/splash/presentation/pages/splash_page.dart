import 'package:flutter/material.dart';
import 'package:mind_track/features/onboarning/presentation/pages/onboarning_page.dart';
import 'package:mind_track/shared/widget/app_circle_icon.dart';
import '../../../../shared/pages/app_background_page.dart';
import 'package:mind_track/app/generated/l10n.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text_styles.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    final S translation = S.of(context);

    return AppBackgroundPage(
      child: Column(
        children: <Widget>[
          const Spacer(flex: 2),

          const AppCircleIcon(
            icon: Icons.bolt_rounded,
          ),

          const SizedBox(height: 28),

          Text(
            translation.title_splash,
            style: AppTextStyles.headlineMedium.copyWith(
              fontSize: 30,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
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
                color: AppColors.textSecondary,
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
                color: AppColors.textSecondary,
              ),
            ),
          ),

          const SizedBox(height: 28),

          TextButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(builder: (_) => const OnboarningPage()),
              );
            },
            child: Text(
              translation.start_journey,
              style: AppTextStyles.bodyMedium.copyWith(
                fontSize: 14,
                color: AppColors.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          const SizedBox(height: 40),
        ],
      ),
    );
  }
}