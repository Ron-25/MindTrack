import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mind_track/app/generated/l10n.dart';
import 'package:mind_track/app/injector.dart';
import 'package:mind_track/app/routes/route_names.dart';
import 'package:mind_track/app/theme/app_colors.dart';
import 'package:mind_track/core/services/device_intent_service.dart';
import 'package:mind_track/core/services/token_storage_service.dart';
import 'package:mind_track/core/utils/toast_utils.dart';
import 'package:mind_track/features/login/presentation/blocs/login_bloc.dart';
import 'package:mind_track/features/login/presentation/blocs/login_event.dart';
import 'package:mind_track/features/profile/domain/entities/profile_settings_data.dart';
import 'package:mind_track/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:mind_track/features/profile/presentation/cubit/profile_state.dart';

class ProfileSettingsPage extends StatefulWidget {
  const ProfileSettingsPage({super.key});

  @override
  State<ProfileSettingsPage> createState() => _ProfileSettingsPageState();
}

class _ProfileSettingsPageState extends State<ProfileSettingsPage> {
  final ProfileCubit _profileCubit = Injector.get<ProfileCubit>();
  final DeviceIntentService _deviceIntentService =
      Injector.get<DeviceIntentService>();
  final TokenStorageService _tokenStorage = Injector.get<TokenStorageService>();
  final LoginBloc _loginBloc = Injector.get<LoginBloc>();
  int _selectedIndex = 4;

  @override
  void initState() {
    super.initState();
    _profileCubit.loadProfile();
  }

  @override
  Widget build(BuildContext context) {
    final S translations = S.of(context);
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F8),
      bottomNavigationBar: _buildBottomArea(context),
      body: SafeArea(
        child: BlocBuilder<ProfileCubit, ProfileState>(
          bloc: _profileCubit,
          builder: (BuildContext context, ProfileState state) {
            if (state.isLoading && state.profile == null) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.errorMessage != null && state.profile == null) {
              return _ProfileErrorState(
                message: state.errorMessage!,
                onRetry: _profileCubit.loadProfile,
              );
            }

            final ProfileSettingsData profile = state.profile!;
            return RefreshIndicator(
              color: AppColors.primary,
              onRefresh: _profileCubit.loadProfile,
              child: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: <Widget>[
                  SliverToBoxAdapter(
                    child: _buildHeader(context, translations),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(16, 24, 16, 120),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate(<Widget>[
                        _buildProfileHero(context, profile),
                        const SizedBox(height: 28),
                        _buildSectionLabel(
                          translations.profile_account_settings,
                        ),
                        const SizedBox(height: 12),
                        _SettingsCard(
                          children: <Widget>[
                            _SettingsTile(
                              icon: Icons.tune_rounded,
                              title: translations.profile_preferences,
                              onTap: _showSoonToast,
                            ),
                            _SettingsTile(
                              icon: Icons.notifications_none_rounded,
                              title: translations.profile_notification_settings,
                              onTap: _openNotificationSettings,
                            ),
                            _SettingsTile(
                              icon: Icons.language_rounded,
                              title: translations.profile_language,
                              trailingText: _languageLabel(
                                translations,
                                profile.languageCode,
                              ),
                              onTap: _openLanguageSettings,
                            ),
                            _SettingsTile(
                              icon: Icons.lock_outline_rounded,
                              title: translations.profile_privacy_security,
                              onTap: _openPrivacyPolicy,
                              isLast: true,
                            ),
                          ],
                        ),
                        const SizedBox(height: 28),
                        OutlinedButton.icon(
                          onPressed: () => _handleLogout(context),
                          icon: const Icon(
                            Icons.logout_rounded,
                            color: Color(0xFFEF4444),
                          ),
                          label: Text(
                            translations.profile_logout,
                            style: const TextStyle(
                              color: Color(0xFFEF4444),
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 58),
                            side: const BorderSide(color: Color(0xFFFECACA)),
                            backgroundColor: const Color(0x80FEF2F2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Center(
                          child: Text(
                            translations.profile_footer_caption,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFF94A3B8),
                            ),
                          ),
                        ),
                      ]),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, S translations) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 17),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFF1F5F9))),
      ),
      child: Row(
        children: <Widget>[
          _HeaderButton(
            icon: Icons.arrow_back_rounded,
            onTap: () => Navigator.of(context).pop(),
          ),
          Expanded(
            child: Center(
              child: Text(
                translations.profile_title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.45,
                  color: Color(0xFF0F172A),
                ),
              ),
            ),
          ),
          _HeaderButton(icon: Icons.settings_outlined, onTap: _showSoonToast),
        ],
      ),
    );
  }

  Widget _buildProfileHero(BuildContext context, ProfileSettingsData profile) {
    return Column(
      children: <Widget>[
        Stack(
          clipBehavior: Clip.none,
          children: <Widget>[
            Container(
              width: 128,
              height: 128,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 4),
                boxShadow: const <BoxShadow>[
                  BoxShadow(
                    color: Color(0x14000000),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
                gradient: const LinearGradient(
                  colors: <Color>[Color(0xFFD9E0E6), Color(0xFFEEF2F6)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                _initials(profile.name),
                style: const TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF475569),
                ),
              ),
            ),
            Positioned(
              right: 4,
              bottom: 4,
              child: Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: const Icon(
                  Icons.edit_rounded,
                  size: 14,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          profile.name,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.6,
            color: Color(0xFF0F172A),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          profile.email,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF64748B),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionLabel(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.2,
          color: Color(0xFF94A3B8),
        ),
      ),
    );
  }

  Widget _buildBottomArea(BuildContext context) {
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
            final bool isSelected = _selectedIndex == index;
            final Color color = isSelected
                ? AppColors.primary
                : const Color(0xFF94A3B8);
            return Expanded(
              child: InkWell(
                onTap: () => _onBottomNavTap(index),
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

  void _onBottomNavTap(int index) {
    if (index == 0) {
      Navigator.of(context).pushReplacementNamed(RouteNames.home);
      return;
    }
    if (index == 4) {
      return;
    }
    setState(() => _selectedIndex = index);
    _showSoonToast();
    setState(() => _selectedIndex = 4);
  }

  Future<void> _handleLogout(BuildContext context) async {
    final S translations = S.of(context);
    await _tokenStorage.clearTokens();
    _loginBloc.add(const LoginStatusReset());
    if (!context.mounted) {
      return;
    }
    ThToast.success(
      context: context,
      title: translations.auth_success_title,
      description: translations.home_logout_success,
      applyBlurEffect: false,
    );
    Navigator.of(context).pushNamedAndRemoveUntil(
      RouteNames.signIn,
      (Route<dynamic> route) => false,
    );
  }

  void _showSoonToast() {
    final S translations = S.of(context);
    ThToast.info(
      context: context,
      title: 'MindTrack',
      description: translations.home_section_soon_description,
      applyBlurEffect: false,
    );
  }

  Future<void> _openNotificationSettings() async {
    final bool launched = await _deviceIntentService.openNotificationSettings();
    if (!mounted) {
      return;
    }
    if (!launched) {
      _showIntentUnavailableToast(S.of(context).profile_intent_android_only);
    }
  }

  Future<void> _openLanguageSettings() async {
    final bool launched = await _deviceIntentService.openLanguageSettings();
    if (!mounted) {
      return;
    }
    if (!launched) {
      _showIntentUnavailableToast(S.of(context).profile_intent_android_only);
    }
  }

  Future<void> _openPrivacyPolicy() async {
    final bool launched = await _deviceIntentService.openPrivacyPolicy();
    if (!mounted) {
      return;
    }
    if (!launched) {
      _showIntentUnavailableToast(
        S.of(context).profile_intent_link_unavailable,
      );
    }
  }

  void _showIntentUnavailableToast(String description) {
    ThToast.info(
      context: context,
      title: 'MindTrack',
      description: description,
      applyBlurEffect: false,
    );
  }

  String _initials(String name) {
    final List<String> parts = name
        .trim()
        .split(RegExp(r'\s+'))
        .where((String part) => part.isNotEmpty)
        .toList();
    if (parts.isEmpty) {
      return 'MT';
    }
    if (parts.length == 1) {
      return parts.first.substring(0, 1).toUpperCase();
    }
    return '${parts.first.substring(0, 1)}${parts.last.substring(0, 1)}'
        .toUpperCase();
  }

  String _languageLabel(S translations, String? languageCode) {
    switch (languageCode?.toLowerCase()) {
      case 'es':
        return translations.profile_language_spanish;
      case 'en':
      default:
        return translations.profile_language_english;
    }
  }
}

class _SettingsCard extends StatelessWidget {
  const _SettingsCard({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFF1F5F9)),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x0D0F172A),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.onTap,
    this.trailingText,
    this.isLast = false,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final String? trailingText;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: isLast
          ? const BorderRadius.only(
              bottomLeft: Radius.circular(24),
              bottomRight: Radius.circular(24),
            )
          : null,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: <Widget>[
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.10),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(icon, color: AppColors.primary, size: 20),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                ),
                if (trailingText != null) ...<Widget>[
                  Text(
                    trailingText!,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF94A3B8),
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
                const Icon(
                  Icons.chevron_right_rounded,
                  color: Color(0xFF94A3B8),
                ),
              ],
            ),
          ),
          if (!isLast)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Divider(height: 1, color: Color(0xFFF1F5F9)),
            ),
        ],
      ),
    );
  }
}

class _HeaderButton extends StatelessWidget {
  const _HeaderButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: SizedBox(
        width: 40,
        height: 40,
        child: Icon(icon, color: const Color(0xFF0F172A), size: 22),
      ),
    );
  }
}

class _ProfileErrorState extends StatelessWidget {
  const _ProfileErrorState({required this.message, required this.onRetry});

  final String message;
  final Future<void> Function() onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Icon(
              Icons.person_off_rounded,
              size: 52,
              color: AppColors.textSecondary,
            ),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 15,
                height: 1.5,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: onRetry,
              child: Text(S.of(context).home_retry),
            ),
          ],
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
