import 'package:flutter/material.dart';
import 'package:mind_track/app/constants/assets.dart';
import 'package:mind_track/app/routes/route_names.dart';
import 'package:mind_track/shared/widget/app_primary_button.dart';
import '../../../../../shared/pages/app_background_page.dart';
import 'package:mind_track/app/generated/l10n.dart';
import '../../../../../app/theme/app_colors.dart';
import '../../../../../app/theme/app_text_styles.dart';

class OnboarningPage extends StatefulWidget {
  const OnboarningPage({super.key});

  @override
  State<OnboarningPage> createState() => _OnboarningPageState();
}

class _OnboarningPageState extends State<OnboarningPage> {

  final PageController _controller = PageController();
  int currentPage = 0;

  final List<String> images = <String>[
    Assets.onboarding1,
    Assets.onboarding2,
    Assets.onboarding3,
  ];

  void nextPage() {
    if (currentPage < 2) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    } else {
      Navigator.of(context).pushNamed(RouteNames.signIn);
    }
  }

  @override
  Widget build(BuildContext context) {
    final S translation = S.of(context);

    final List<String> titles = <String>[
      translation.onboarding_title_1,
      translation.onboarding_title_2,
      translation.onboarding_title_3,
    ];

    final List<String> descriptions = <String>[
      translation.onboarding_desc_1,
      translation.onboarding_desc_2,
      translation.onboarding_desc_3,
    ];

    return AppBackgroundPage(
      child: Column(
        children: <Widget>[
          const SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TextButton.icon(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back, size: 18, color: Colors.black),
                label: Text(
                  translation.back,
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(RouteNames.signIn);
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                ),
                child: Text(
                  translation.skip,
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),

          /// PageView
          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: 3,
              onPageChanged: (int index) {
                setState(() {
                  currentPage = index;
                });
              },
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: <Widget>[

                    const SizedBox(height: 20),

                    /// Imagen
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 20,
                          )
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: Image.asset(
                          images[index],
                          width: 260,
                          height: 260,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),

                    /// Title
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Text(
                        titles[index],
                        textAlign: TextAlign.center,
                        style: AppTextStyles.headlineMedium.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    /// Description
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Text(
                        descriptions[index],
                        textAlign: TextAlign.center,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                          height: 1.6,
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    /// DOTS
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List<Widget>.generate(
                        3,
                        (int dotIndex) => AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: currentPage == dotIndex ? 20 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: currentPage == dotIndex
                                ? AppColors.primary
                                : Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    ///Next Button
                    AppPrimaryButton(
                      text: currentPage < 2
                          ? translation.next
                          : translation.get_started,
                      icon: Icons.arrow_forward,
                      onPressed: nextPage,
                    ),

                    const SizedBox(height: 16),

                    /// Step text
                    Text(
                      translation.onboarding_step((index + 1).toString(), '3'),
                      style: AppTextStyles.bodySmall.copyWith(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
