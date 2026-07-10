import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mind_track/app/generated/l10n.dart';
import 'package:mind_track/app/theme/mt_colors.dart';
import 'package:mind_track/app/injector.dart';
import 'package:mind_track/app/routes/route_names.dart';
import 'package:mind_track/app/theme/app_colors.dart';
import 'package:mind_track/core/utils/toast_utils.dart';
import 'package:mind_track/features/home/domain/entities/home_dashboard.dart';
import 'package:mind_track/features/home/presentation/cubit/home_cubit.dart';
import 'package:mind_track/features/home/presentation/cubit/home_state.dart';
import 'package:mind_track/features/login/presentation/blocs/login_bloc.dart';
import 'package:mind_track/features/login/presentation/blocs/login_event.dart';
import 'package:mind_track/features/login/presentation/blocs/login_state.dart';
import 'package:mind_track/shared/pages/main_shell_page.dart';
import 'package:mind_track/shared/widget/mindtrack_app_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeCubit _homeCubit = Injector.get<HomeCubit>();
  final LoginBloc _loginBloc = Injector.get<LoginBloc>();

  @override
  void initState() {
    super.initState();
    _homeCubit.loadDashboard();
  }

  @override
  Widget build(BuildContext context) {
    final S translations = S.of(context);

    return MultiBlocListener(
      listeners: <BlocListenerBase<dynamic, dynamic>>[
        BlocListener<LoginBloc, LoginState>(
          bloc: _loginBloc,
          listenWhen: (LoginState previous, LoginState current) {
            return previous.isFailure != current.isFailure ||
                previous.logIn != current.logIn ||
                previous.signUp != current.signUp;
          },
          listener: (BuildContext context, LoginState state) {
            if (state.isFailure) {
              ThToast.error(
                context: context,
                title: translations.auth_error_title,
                description:
                    state.errorMessage ?? translations.auth_error_description,
                applyBlurEffect: false,
              );
              _loginBloc.add(const LoginStatusReset());
              return;
            }

            if (state.signUp) {
              ThToast.success(
                context: context,
                title: translations.auth_success_title,
                description: translations.auth_signup_success_toast,
                applyBlurEffect: false,
              );
              _loginBloc.add(const LoginStatusReset());
              return;
            }

            if (state.logIn || state.isSuccess) {
              ThToast.success(
                context: context,
                title: translations.auth_success_title,
                description: translations.auth_login_success_toast,
                applyBlurEffect: false,
              );
              _loginBloc.add(const LoginStatusReset());
            }
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: MindTrackAppBar(title: S.of(context).title),
        floatingActionButton: _buildManagerIaButton(context),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: SafeArea(
          child: BlocBuilder<HomeCubit, HomeState>(
            bloc: _homeCubit,
            builder: (BuildContext context, HomeState state) {
              if (state.isLoading && state.dashboard == null) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state.errorMessage != null && state.dashboard == null) {
                return _HomeErrorState(
                  message: state.errorMessage!,
                  onRetry: _homeCubit.loadDashboard,
                );
              }

              final HomeDashboard dashboard = state.dashboard!;
              return RefreshIndicator(
                color: AppColors.primary,
                onRefresh: _homeCubit.loadDashboard,
                child: CustomScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  slivers: <Widget>[
                    SliverPadding(
                      padding: const EdgeInsets.fromLTRB(16, 10, 16, 172),
                      sliver: SliverList(
                        delegate: SliverChildListDelegate(<Widget>[
                          Text(
                            _greetingForTime(context, dashboard.userName),
                            style: TextStyle(
                              fontSize: 30,
                              height: 1.25,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -0.8,
                              color: context.mtColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _subtitleForLocale(context),
                            style: const TextStyle(
                              fontSize: 16,
                              height: 1.5,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 20),
                          _buildLogEmotionButton(context, translations),
                          const SizedBox(height: 24),
                          _SectionCard(
                            child: _buildTodayMoodSection(
                              context,
                              dashboard.todayMood,
                              translations,
                            ),
                          ),
                          const SizedBox(height: 20),
                          _SectionCard(
                            child: _buildWeeklyOverviewSection(
                              context,
                              dashboard.weeklyOverview,
                              translations,
                            ),
                          ),
                          const SizedBox(height: 20),
                          _SectionCard(
                            child: _buildHabitsSection(
                              context,
                              dashboard.habits,
                            ),
                          ),
                          const SizedBox(height: 28),
                          _buildRecentEntriesSection(
                            context,
                            dashboard.recentEntries,
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
      ),
    );
  }

  Widget _buildLogEmotionButton(BuildContext context, S translations) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {
          Navigator.of(context).pushNamed(RouteNames.addEmotion);
        },
        icon: const Icon(Icons.add_circle_outline_rounded, size: 20),
        label: Text(
          translations.home_log_emotion_button,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 56),
          backgroundColor: AppColors.primary,
          elevation: 0,
          shadowColor: const Color(0x665FA9D3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
      ),
    );
  }

  Widget _buildTodayMoodSection(
    BuildContext context,
    TodayMoodSummary mood,
    S translations,
  ) {
    final Color accentColor = _colorFromHex(mood.colorHex, AppColors.primary);
    final bool isEmptyMood = mood.totalEntries == 0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Text(
                translations.home_today_mood_title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: context.mtColors.textPrimary,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: _statusBackgroundColor(mood.statusLabel),
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                _localizedMoodStatus(
                  translations,
                  mood.statusLabel,
                ).toUpperCase(),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: _statusForegroundColor(mood.statusLabel),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: accentColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                _emotionIcon(mood.iconKey, mood.primaryEmotionName),
                color: accentColor,
                size: 30,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    isEmptyMood
                        ? translations.home_today_empty_title
                        : mood.primaryEmotionName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    isEmptyMood
                        ? translations.home_today_empty_description
                        : translations.home_today_entries_description(
                            mood.totalEntries,
                            _localizedEnergyLevel(
                              translations,
                              mood.energyLevelKey,
                            ),
                          ),
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.45,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: FilledButton(
            onPressed: () => _goToTab(context, MainShellPage.analyticsTab),
            style: FilledButton.styleFrom(
              backgroundColor: context.mtColors.surfaceSubtle,
              foregroundColor: AppColors.primary,
              elevation: 0,
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Text(translations.home_view_detailed_analysis),
          ),
        ),
      ],
    );
  }

  Widget _buildWeeklyOverviewSection(
    BuildContext context,
    WeeklyOverview overview,
    S translations,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          translations.home_weekly_overview_title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: context.mtColors.textPrimary,
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 140,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: overview.bars.map((WeeklyOverviewBar bar) {
              final double maxValue = overview.bars.fold<double>(
                1,
                (double value, WeeklyOverviewBar item) =>
                    math.max(value, item.value),
              );
              final double barHeight = math.max(24, bar.value);
              // Intensidad del color proporcional al valor del día (0.2-0.9).
              final double alpha = 0.2 + 0.7 * (bar.value / maxValue);
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 350),
                        curve: Curves.easeOutCubic,
                        height: barHeight,
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(
                            alpha: alpha.clamp(0.2, 0.9),
                          ),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        bar.label.toUpperCase(),
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.5,
                          color: context.mtColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          overview.insightText,
          style: const TextStyle(
            fontSize: 14,
            height: 1.45,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildHabitsSection(BuildContext context, List<HabitOverview> habits) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          S.of(context).home_daily_habits_title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: context.mtColors.textPrimary,
          ),
        ),
        const SizedBox(height: 16),
        if (habits.isEmpty)
          Text(
            S.of(context).home_empty_habits_message,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          )
        else
          ...habits.map((HabitOverview habit) {
            final Color accent = _colorFromHex(
              habit.colorHex,
              AppColors.primary,
            );
            return Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: Row(
                children: <Widget>[
                  Icon(
                    _habitIcon(habit.iconKey, habit.name),
                    color: accent,
                    size: 18,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      habit.name,
                      style: TextStyle(
                        fontSize: 14,
                        color: context.mtColors.textPrimary,
                      ),
                    ),
                  ),
                  Icon(
                    habit.isCompletedToday
                        ? Icons.check_circle_rounded
                        : Icons.radio_button_unchecked_rounded,
                    color: habit.isCompletedToday
                        ? AppColors.primary
                        : context.mtColors.controlBorder,
                    size: 20,
                  ),
                ],
              ),
            );
          }),
      ],
    );
  }

  Widget _buildManagerIaButton(BuildContext context) {
    final S translations = S.of(context);
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => Navigator.of(context).pushNamed(RouteNames.chat),
        borderRadius: BorderRadius.circular(999),
        child: Container(
          width: 200,
          height: 56,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(999),
            border: Border.all(
              color: Theme.of(context).scaffoldBackgroundColor,
              width: 4,
            ),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Color(0x665FA9D3),
                blurRadius: 18,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                translations.home_manager_ai,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 8),
              const Icon(
                Icons.chat_bubble_rounded,
                color: Colors.white,
                size: 22,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecentEntriesSection(
    BuildContext context,
    List<RecentEmotionEntry> entries,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Text(
                S.of(context).home_recent_entries_title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: context.mtColors.textPrimary,
                ),
              ),
            ),
            TextButton(
              onPressed: () => _goToTab(context, MainShellPage.historyTab),
              child: Text(
                S.of(context).home_see_all,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        if (entries.isEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              S.of(context).home_empty_entries_message,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
            ),
          )
        else
          ...entries.map((RecentEmotionEntry entry) {
            final Color accent = _colorFromHex(
              entry.colorHex,
              AppColors.primary,
            );
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Material(
                color: context.mtColors.card,
                borderRadius: BorderRadius.circular(24),
                child: InkWell(
                  borderRadius: BorderRadius.circular(24),
                  onTap: () {
                    Navigator.of(
                      context,
                    ).pushNamed(RouteNames.emotionDetail, arguments: entry.id);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: context.mtColors.borderSubtle),
                    ),
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: accent.withValues(alpha: 0.12),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            _emotionIcon(entry.iconKey, entry.emotionName),
                            color: accent,
                            size: 22,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                '${entry.emotionName} • ${_entryTimeLabel(context, entry.loggedAt)}',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: context.mtColors.textPrimary,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                _entryPreview(entry.note, context),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Icon(
                          Icons.chevron_right_rounded,
                          color: context.mtColors.controlBorder,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
      ],
    );
  }

  void _goToTab(BuildContext context, int tabIndex) {
    final MainShellPageState? shell = MainShellPage.of(context);
    if (shell != null) {
      shell.goToTab(tabIndex);
      return;
    }
    // Fuera del shell (deep link): navega por ruta como antes.
    final String route = switch (tabIndex) {
      MainShellPage.historyTab => RouteNames.dailyMood,
      MainShellPage.analyticsTab => RouteNames.analytics,
      MainShellPage.habitsTab => RouteNames.habits,
      MainShellPage.profileTab => RouteNames.profile,
      _ => RouteNames.home,
    };
    Navigator.of(context).pushNamed(route);
  }

  String _greetingForTime(BuildContext context, String userName) {
    final S translations = S.of(context);
    final int hour = DateTime.now().hour;
    return switch (hour) {
      < 12 => translations.home_greeting_morning(userName),
      < 18 => translations.home_greeting_afternoon(userName),
      _ => translations.home_greeting_evening(userName),
    };
  }

  String _subtitleForLocale(BuildContext context) {
    return S.of(context).home_subtitle_default;
  }

  String _entryPreview(String? note, BuildContext context) {
    if (note != null && note.trim().isNotEmpty) {
      return note.trim();
    }
    return S.of(context).home_entry_no_note;
  }

  String _entryTimeLabel(BuildContext context, DateTime dateTime) {
    final DateTime now = DateTime.now();
    final DateTime today = DateTime(now.year, now.month, now.day);
    final DateTime date = DateTime(dateTime.year, dateTime.month, dateTime.day);
    if (date == today) {
      return MaterialLocalizations.of(context).formatTimeOfDay(
        TimeOfDay.fromDateTime(dateTime),
        alwaysUse24HourFormat: false,
      );
    }
    if (date == today.subtract(const Duration(days: 1))) {
      return S.of(context).home_entry_yesterday;
    }
    return '${date.month}/${date.day}';
  }

  String _localizedMoodStatus(S translations, String statusLabel) {
    switch (statusLabel.toLowerCase()) {
      case 'new_day':
        return translations.home_status_new_day;
      case 'elevated':
        return translations.home_status_elevated;
      case 'gentle':
        return translations.home_status_gentle;
      default:
        return translations.home_mood_status_stable;
    }
  }

  String _localizedEnergyLevel(S translations, String? energyLevelKey) {
    switch (energyLevelKey) {
      case 'high':
        return translations.home_energy_high;
      case 'low':
        return translations.home_energy_low;
      default:
        return translations.home_energy_balanced;
    }
  }

  Color _statusBackgroundColor(String statusLabel) {
    switch (statusLabel.toLowerCase()) {
      case 'elevated':
        return const Color(0xFFFEE2E2);
      case 'gentle':
        return const Color(0xFFFEF3C7);
      default:
        return const Color(0xFFDCFCE7);
    }
  }

  Color _statusForegroundColor(String statusLabel) {
    switch (statusLabel.toLowerCase()) {
      case 'elevated':
        return const Color(0xFFDC2626);
      case 'gentle':
        return const Color(0xFFD97706);
      default:
        return const Color(0xFF16A34A);
    }
  }

  Color _colorFromHex(String? hex, Color fallback) {
    if (hex == null || hex.isEmpty) {
      return fallback;
    }
    final String normalized = hex.replaceFirst('#', '');
    if (normalized.length != 6) {
      return fallback;
    }
    return Color(int.parse('FF$normalized', radix: 16));
  }

  IconData _emotionIcon(String? iconKey, String emotionName) {
    final String value = '${iconKey ?? ''} ${emotionName.toLowerCase()}';
    if (value.contains('joy') ||
        value.contains('happy') ||
        value.contains('feliz')) {
      return Icons.wb_sunny_outlined;
    }
    if (value.contains('calm') ||
        value.contains('peace') ||
        value.contains('neutral')) {
      return Icons.cloud_outlined;
    }
    if (value.contains('sad') || value.contains('triste')) {
      return Icons.water_drop_outlined;
    }
    if (value.contains('angry') || value.contains('enoj')) {
      return Icons.local_fire_department_outlined;
    }
    return Icons.mood_rounded;
  }

  IconData _habitIcon(String? iconKey, String habitName) {
    final String value = '${iconKey ?? ''} ${habitName.toLowerCase()}';
    if (value.contains('medit')) {
      return Icons.self_improvement_rounded;
    }
    if (value.contains('water') || value.contains('hydr')) {
      return Icons.water_drop_outlined;
    }
    if (value.contains('journal') || value.contains('write')) {
      return Icons.menu_book_outlined;
    }
    if (value.contains('sleep')) {
      return Icons.nightlight_round;
    }
    return Icons.checklist_rounded;
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: context.mtColors.card,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: context.mtColors.borderSubtle),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x0D0F172A),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _HomeErrorState extends StatelessWidget {
  const _HomeErrorState({required this.message, required this.onRetry});

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
              Icons.cloud_off_rounded,
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
