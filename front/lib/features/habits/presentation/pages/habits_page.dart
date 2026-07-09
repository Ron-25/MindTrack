import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mind_track/app/generated/l10n.dart';
import 'package:mind_track/app/injector.dart';
import 'package:mind_track/app/theme/app_colors.dart';
import 'package:mind_track/features/habits/domain/entities/habit_tracker.dart';
import 'package:mind_track/features/habits/presentation/cubit/habit_cubit.dart';
import 'package:mind_track/features/habits/presentation/cubit/habit_state.dart';

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
    return BlocListener<HabitCubit, HabitState>(
      listenWhen: (HabitState previous, HabitState current) {
        return previous.errorMessage != current.errorMessage ||
            previous.successMessage != current.successMessage;
      },
      listener: (BuildContext context, HabitState state) {
        if (state.errorMessage != null) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
          context.read<HabitCubit>().clearFeedback();
          return;
        }
        if (state.successMessage != null) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.successMessage!)));
          context.read<HabitCubit>().clearFeedback();
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF8FAFC),
        appBar: AppBar(
          title: Text(S.of(context).habits_title),
          backgroundColor: const Color(0xFFF8FAFC),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => _openCreateHabit(context),
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          icon: const Icon(Icons.add_rounded),
          label: Text(S.of(context).habits_new_button),
        ),
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
                    onRefresh: context.read<HabitCubit>().loadHabits,
                    child: state.habits.isEmpty
                        ? ListView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            padding: const EdgeInsets.all(24),
                            children: <Widget>[
                              const SizedBox(height: 120),
                              const Icon(
                                Icons.checklist_rounded,
                                size: 56,
                                color: AppColors.primary,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                S.of(context).habits_empty_title,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                S.of(context).habits_empty_description,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Color(0xFF64748B),
                                  height: 1.4,
                                ),
                              ),
                            ],
                          )
                        : ListView.separated(
                            physics: const AlwaysScrollableScrollPhysics(),
                            padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
                            itemCount: state.habits.length,
                            separatorBuilder: (_, _) =>
                                const SizedBox(height: 12),
                            itemBuilder: (BuildContext context, int index) {
                              final HabitTracker habit = state.habits[index];
                              return _HabitCard(
                                habit: habit,
                                onToggle: () {
                                  context.read<HabitCubit>().toggleHabit(habit);
                                },
                              );
                            },
                          ),
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

  Future<void> _openCreateHabit(BuildContext context) async {
    final S translations = S.of(context);
    final TextEditingController nameController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    final TextEditingController categoryController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    double days = 3;

    final CreateHabitInput? input =
        await showModalBottomSheet<CreateHabitInput>(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          builder: (BuildContext context) {
            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setModalState) {
                return Padding(
                  padding: EdgeInsets.fromLTRB(
                    20,
                    20,
                    20,
                    MediaQuery.of(context).viewInsets.bottom + 20,
                  ),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          translations.habits_create_title,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: nameController,
                          decoration: InputDecoration(
                            labelText: translations.habits_name_label,
                            border: const OutlineInputBorder(),
                          ),
                          validator: (String? value) {
                            if (value == null || value.trim().isEmpty) {
                              return translations.habits_name_error;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 12),
                        TextField(
                          controller: descriptionController,
                          decoration: InputDecoration(
                            labelText: translations.habits_description_label,
                            border: const OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 12),
                        TextField(
                          controller: categoryController,
                          decoration: InputDecoration(
                            labelText: translations.habits_category_label,
                            border: const OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          translations.habits_days_per_week(days.round()),
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                        Slider(
                          value: days,
                          min: 1,
                          max: 7,
                          divisions: 6,
                          activeColor: AppColors.primary,
                          onChanged: (double value) {
                            setModalState(() => days = value);
                          },
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          child: FilledButton(
                            onPressed: () {
                              if (formKey.currentState?.validate() != true) {
                                return;
                              }
                              Navigator.of(context).pop(
                                CreateHabitInput(
                                  name: nameController.text.trim(),
                                  description: descriptionController.text
                                      .trim(),
                                  category: categoryController.text.trim(),
                                  targetDaysWeek: days.round(),
                                ),
                              );
                            },
                            child: Text(translations.habits_save),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        );

    nameController.dispose();
    descriptionController.dispose();
    categoryController.dispose();

    if (input == null || !context.mounted) {
      return;
    }
    await context.read<HabitCubit>().createHabit(input);
  }
}

class _HabitCard extends StatelessWidget {
  const _HabitCard({required this.habit, required this.onToggle});

  final HabitTracker habit;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final Color accent = _colorFromHex(habit.colorHex);
    final S translations = S.of(context);
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(_habitIcon(habit), color: accent),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      habit.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    if (habit.description?.trim().isNotEmpty == true)
                      Text(
                        habit.description!,
                        style: const TextStyle(color: Color(0xFF64748B)),
                      ),
                  ],
                ),
              ),
              Switch(
                value: habit.completedToday,
                onChanged: (_) => onToggle(),
                activeColor: AppColors.primary,
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  translations.habits_weekly_target(habit.targetDaysWeek),
                  style: const TextStyle(color: Color(0xFF475569)),
                ),
              ),
              Text(
                '${habit.completedDays}/${habit.targetDaysWeek}',
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              value: (habit.completionPct / 100).clamp(0, 1),
              minHeight: 10,
              color: accent,
              backgroundColor: const Color(0xFFE2E8F0),
            ),
          ),
        ],
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
