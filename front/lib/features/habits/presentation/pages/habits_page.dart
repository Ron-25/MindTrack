import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mind_track/app/generated/l10n.dart';
import 'package:mind_track/app/injector.dart';
import 'package:mind_track/app/routes/route_names.dart';
import 'package:mind_track/app/theme/app_colors.dart';
import 'package:mind_track/features/analytics/presentation/cubit/analytics_cubit.dart';
import 'package:mind_track/features/habits/domain/entities/habit_tracker.dart';
import 'package:mind_track/features/habits/presentation/cubit/habit_cubit.dart';
import 'package:mind_track/features/habits/presentation/cubit/habit_state.dart';
import 'package:mind_track/features/habits/presentation/pages/add_habit_page.dart';
import 'package:mind_track/features/home/presentation/cubit/home_cubit.dart';
import 'package:mind_track/shared/pages/main_shell_page.dart';
import 'package:mind_track/shared/widget/mindtrack_app_bar.dart';

class HabitsPage extends StatelessWidget {
  const HabitsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HabitCubit>(
      create: (_) => Injector.get<HabitCubit>()..loadHabits(),
      child: const _HabitsView(),
    );
  }
}

class _HabitsView extends StatelessWidget {
  const _HabitsView();

  @override
  Widget build(BuildContext context) {
    final S translations = S.of(context);
    return BlocListener<HabitCubit, HabitState>(
      listenWhen: (HabitState previous, HabitState current) {
        return previous.errorMessage != current.errorMessage ||
            previous.successMessage != current.successMessage;
      },
      listener: (BuildContext context, HabitState state) {
        if (state.errorMessage != null) {
          final ScaffoldMessengerState messenger = ScaffoldMessenger.of(
            context,
          );
          messenger
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(state.errorMessage!)));
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (context.mounted) {
              context.read<HabitCubit>().clearFeedback();
            }
          });
          return;
        }
        if (state.successMessage != null) {
          final ScaffoldMessengerState messenger = ScaffoldMessenger.of(
            context,
          );
          messenger
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(state.successMessage!)));
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (context.mounted) {
              context.read<HabitCubit>().clearFeedback();
            }
          });
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF6FAFC),
        appBar: MindTrackAppBar(title: translations.habits_title),
        body: SafeArea(
          child: BlocBuilder<HabitCubit, HabitState>(
            builder: (BuildContext context, HabitState state) {
              if (state.isLoading && state.habits.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state.errorMessage != null && state.habits.isEmpty) {
                return _ErrorState(
                  message: state.errorMessage!,
                  onRetry: context.read<HabitCubit>().loadHabits,
                );
              }
              return Stack(
                children: <Widget>[
                  RefreshIndicator(
                    color: AppColors.primary,
                    onRefresh: context.read<HabitCubit>().loadHabits,
                    child: state.habits.isEmpty
                        ? _buildEmptyState(context, translations)
                        : _buildContent(context, state, translations),
                  ),
                  if (state.isSaving)
                    const Positioned.fill(
                      child: IgnorePointer(
                        child: ColoredBox(
                          color: Color(0x440F172A),
                          child: Center(child: CircularProgressIndicator()),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, S translations) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(24),
      children: <Widget>[
        const SizedBox(height: 120),
        const Icon(Icons.checklist_rounded, size: 56, color: AppColors.primary),
        const SizedBox(height: 16),
        Text(
          translations.habits_empty_title,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 8),
        Text(
          translations.habits_empty_description,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Color(0xFF64748B), height: 1.4),
        ),
        const SizedBox(height: 24),
        Center(child: _AddHabitButton(onTap: () => _openCreateHabit(context))),
      ],
    );
  }

  Widget _buildContent(BuildContext context, HabitState state, S translations) {
    final int total = state.habits.length;
    final int completed = state.habits
        .where((HabitTracker habit) => habit.completedToday)
        .length;
    final String locale = Localizations.localeOf(context).languageCode;

    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
      children: <Widget>[
        _DailyProgressCard(
          completed: completed,
          total: total,
          onInsightsTap: () {
            final MainShellPageState? shell = MainShellPage.of(context);
            if (shell != null) {
              shell.goToTab(MainShellPage.analyticsTab);
              return;
            }
            Navigator.of(context).pushNamed(RouteNames.analytics);
          },
        ),
        const SizedBox(height: 24),
        Row(
          children: <Widget>[
            Expanded(
              child: Text(
                translations.habits_today_title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.45,
                  color: Color(0xFF0F172A),
                ),
              ),
            ),
            Text(
              DateFormat.yMMMMd(locale).format(DateTime.now()),
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ...state.habits.map(
          (HabitTracker habit) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _HabitCard(
              habit: habit,
              onToggle: () async {
                await context.read<HabitCubit>().toggleHabit(habit);
                _refreshDependentTabs();
              },
              onTap: () => _openEditHabit(context, habit),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Center(child: _AddHabitButton(onTap: () => _openCreateHabit(context))),
      ],
    );
  }

  Future<void> _openCreateHabit(BuildContext context) async {
    final CreateHabitInput? input = await Navigator.of(context)
        .push<CreateHabitInput>(
          MaterialPageRoute<CreateHabitInput>(
            builder: (_) => const AddHabitPage(),
          ),
        );

    if (input == null || !context.mounted) {
      return;
    }
    await context.read<HabitCubit>().createHabit(input);
    _refreshDependentTabs();
  }

  Future<void> _openEditHabit(BuildContext context, HabitTracker habit) async {
    final CreateHabitInput? input = await Navigator.of(context)
        .push<CreateHabitInput>(
          MaterialPageRoute<CreateHabitInput>(
            builder: (_) => AddHabitPage(habit: habit),
          ),
        );

    if (input == null || !context.mounted) {
      return;
    }
    await context.read<HabitCubit>().updateHabit(
      habit.id,
      UpdateHabitInput(
        name: input.name,
        description: input.description,
        category: input.category,
        targetDaysWeek: input.targetDaysWeek,
      ),
    );
    _refreshDependentTabs();
  }

  void _refreshDependentTabs() {
    Injector.get<HomeCubit>().loadDashboard();
    Injector.get<AnalyticsCubit>().loadSnapshot();
  }
}

class _DailyProgressCard extends StatelessWidget {
  const _DailyProgressCard({
    required this.completed,
    required this.total,
    required this.onInsightsTap,
  });

  final int completed;
  final int total;
  final VoidCallback onInsightsTap;

  @override
  Widget build(BuildContext context) {
    final S translations = S.of(context);
    final double progress = total > 0 ? completed / total : 0;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.1)),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 1,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AspectRatio(
            aspectRatio: 16 / 6,
            child: DecoratedBox(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Color(0xFF5FA9D3), Color(0xFFAED9E0)],
                ),
              ),
              child: Center(
                child: Container(
                  width: 62,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: const Icon(
                    Icons.trending_up_rounded,
                    color: Colors.white,
                    size: 26,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        translations.habits_daily_progress_title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF0F172A),
                        ),
                      ),
                    ),
                    Text(
                      '${(progress * 100).round()}%',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(999),
                  child: LinearProgressIndicator(
                    value: progress.clamp(0, 1),
                    minHeight: 8,
                    color: AppColors.primary,
                    backgroundColor: const Color(0xFFF1F5F9),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            translations.habits_daily_progress_message(
                              completed,
                              total,
                            ),
                            style: const TextStyle(
                              fontSize: 14,
                              height: 1.45,
                              color: Color(0xFF475569),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            translations.habits_daily_progress_subtitle,
                            style: const TextStyle(
                              fontSize: 12,
                              height: 1.35,
                              color: Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    FilledButton(
                      onPressed: onInsightsTap,
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(84, 36),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Text(
                        translations.habits_insights_button,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HabitCard extends StatelessWidget {
  const _HabitCard({
    required this.habit,
    required this.onToggle,
    required this.onTap,
  });

  final HabitTracker habit;
  final VoidCallback onToggle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final Color accent = _colorFromHex(habit.colorHex);
    final S translations = S.of(context);
    final String subtitle = habit.description?.trim().isNotEmpty == true
        ? habit.description!
        : translations.habits_weekly_target(habit.targetDaysWeek);

    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(24),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: const Color(0xFFF1F5F9)),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Color(0x0D000000),
                blurRadius: 1,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: Row(
            children: <Widget>[
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(_habitIcon(habit), size: 22, color: accent),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      habit.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              InkWell(
                onTap: onToggle,
                customBorder: const CircleBorder(),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  width: 26,
                  height: 26,
                  decoration: BoxDecoration(
                    color: habit.completedToday
                        ? AppColors.primary
                        : Colors.transparent,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: habit.completedToday
                          ? AppColors.primary
                          : const Color(0xFFCBD5E1),
                    ),
                  ),
                  child: habit.completedToday
                      ? const Icon(
                          Icons.check_rounded,
                          size: 16,
                          color: Colors.white,
                        )
                      : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _colorFromHex(String? hex) {
    if (hex == null || hex.isEmpty) {
      return AppColors.primary;
    }
    return Color(int.parse('FF${hex.replaceFirst('#', '')}', radix: 16));
  }

  IconData _habitIcon(HabitTracker habit) {
    final String value = '${habit.iconKey ?? ''} ${habit.name.toLowerCase()}';
    if (value.contains('medit')) {
      return Icons.self_improvement_rounded;
    }
    if (value.contains('water') ||
        value.contains('hydr') ||
        value.contains('agua')) {
      return Icons.water_drop_outlined;
    }
    if (value.contains('journal') ||
        value.contains('write') ||
        value.contains('diario')) {
      return Icons.menu_book_outlined;
    }
    if (value.contains('sleep') || value.contains('dorm')) {
      return Icons.nightlight_round;
    }
    if (value.contains('run') ||
        value.contains('exercise') ||
        value.contains('ejerc') ||
        value.contains('gym')) {
      return Icons.directions_run_rounded;
    }
    return Icons.checklist_rounded;
  }
}

class _AddHabitButton extends StatelessWidget {
  const _AddHabitButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onTap,
      icon: const Icon(
        Icons.add_circle_outline_rounded,
        size: 20,
        color: AppColors.primary,
      ),
      label: Text(
        S.of(context).habits_new_button,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.primary,
        ),
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: onRetry,
              child: Text(S.of(context).home_retry),
            ),
          ],
        ),
      ),
    );
  }
}
