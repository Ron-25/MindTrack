import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mind_track/app/generated/l10n.dart';
import 'package:mind_track/app/injector.dart';
import 'package:mind_track/app/routes/route_names.dart';
import 'package:mind_track/app/theme/app_colors.dart';
import 'package:mind_track/shared/widget/mindtrack_app_bar.dart';
import 'package:mind_track/features/analytics/domain/entities/analytics_snapshot.dart';
import 'package:mind_track/features/analytics/presentation/cubit/analytics_cubit.dart';
import 'package:mind_track/features/analytics/presentation/cubit/analytics_state.dart';

class AnalyticsPage extends StatelessWidget {
  const AnalyticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AnalyticsCubit>(
      create: (_) => Injector.get<AnalyticsCubit>()..loadSnapshot(),
      child: const _AnalyticsView(),
    );
  }
}

class _AnalyticsView extends StatelessWidget {
  const _AnalyticsView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: MindTrackAppBar(title: S.of(context).analytics_title),
      body: SafeArea(
        child: BlocBuilder<AnalyticsCubit, AnalyticsState>(
          builder: (BuildContext context, AnalyticsState state) {
            if (state.isLoading && state.snapshot == null) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.errorMessage != null && state.snapshot == null) {
              return _ErrorState(
                message: state.errorMessage!,
                onRetry: context.read<AnalyticsCubit>().loadSnapshot,
              );
            }

            final AnalyticsSnapshot snapshot = state.snapshot!;
            return RefreshIndicator(
              onRefresh: context.read<AnalyticsCubit>().loadSnapshot,
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                children: <Widget>[
                  _SummaryHero(summary: snapshot.weeklySummary),
                  const SizedBox(height: 18),
                  _SectionCard(
                    title: S.of(context).analytics_frequency_title,
                    child: Column(
                      children: snapshot.frequency.isEmpty
                          ? <Widget>[
                              Text(
                                S.of(context).analytics_frequency_empty,
                                style: const TextStyle(
                                  color: Color(0xFF64748B),
                                ),
                              ),
                            ]
                          : snapshot.frequency
                                .map((EmotionFrequencyItem item) {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 14),
                                    child: _FrequencyRow(item: item),
                                  );
                                })
                                .toList(growable: false),
                    ),
                  ),
                  const SizedBox(height: 18),
                  _SectionCard(
                    title: S.of(context).analytics_habits_mood_title,
                    child: _CorrelationChart(points: snapshot.correlation),
                  ),
                  const SizedBox(height: 18),
                  FilledButton.icon(
                    onPressed: () {
                      Navigator.of(context).pushNamed(RouteNames.habits);
                    },
                    icon: const Icon(Icons.checklist_rounded),
                    label: Text(S.of(context).analytics_view_habits),
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      minimumSize: const Size(double.infinity, 52),
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
}

class _SummaryHero extends StatelessWidget {
  const _SummaryHero({required this.summary});

  final WeeklySummaryData summary;

  @override
  Widget build(BuildContext context) {
    final Color accent = _colorFromHex(summary.dominantEmotionColorHex);
    final S translations = S.of(context);
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            accent.withValues(alpha: 0.92),
            const Color(0xFF16324F),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            translations.analytics_weekly_summary_title,
            style: const TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            summary.dominantEmotionName ??
                translations.analytics_no_dominant_emotion,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            summary.insightText?.trim().isNotEmpty == true
                ? summary.insightText!
                : translations.analytics_default_insight,
            style: const TextStyle(color: Colors.white, height: 1.4),
          ),
          const SizedBox(height: 18),
          Row(
            children: <Widget>[
              _MetricChip(
                label: translations.analytics_metric_logs,
                value: '${summary.totalLogs}',
              ),
              const SizedBox(width: 10),
              _MetricChip(
                label: translations.analytics_metric_intensity,
                value: summary.avgIntensity?.toStringAsFixed(1) ?? '--',
              ),
              const SizedBox(width: 10),
              _MetricChip(
                label: translations.analytics_metric_habits,
                value: summary.habitsCompletionPct != null
                    ? '${summary.habitsCompletionPct!.round()}%'
                    : '--',
              ),
            ],
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
}

class _MetricChip extends StatelessWidget {
  const _MetricChip({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          children: <Widget>[
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

class _FrequencyRow extends StatelessWidget {
  const _FrequencyRow({required this.item});

  final EmotionFrequencyItem item;

  @override
  Widget build(BuildContext context) {
    final Color color = _colorFromHex(item.colorHex);
    final S translations = S.of(context);
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                item.name,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF0F172A),
                ),
              ),
            ),
            Text(
              translations.analytics_records_count(item.count),
              style: const TextStyle(color: Color(0xFF64748B)),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(999),
          child: LinearProgressIndicator(
            value: (item.percentage / 100).clamp(0, 1),
            minHeight: 10,
            color: color,
            backgroundColor: const Color(0xFFE2E8F0),
          ),
        ),
      ],
    );
  }

  Color _colorFromHex(String? hex) {
    if (hex == null || hex.isEmpty) {
      return AppColors.primary;
    }
    return Color(int.parse('FF${hex.replaceFirst('#', '')}', radix: 16));
  }
}

class _CorrelationChart extends StatelessWidget {
  const _CorrelationChart({required this.points});

  final List<HabitMoodPoint> points;

  @override
  Widget build(BuildContext context) {
    if (points.isEmpty) {
      return Text(
        S.of(context).analytics_correlation_empty,
        style: const TextStyle(color: Color(0xFF64748B)),
      );
    }

    final double maxHabits = points.fold<double>(
      1,
      (double value, HabitMoodPoint point) =>
          math.max(value, point.habitsCompleted.toDouble()),
    );
    final double maxIntensity = points.fold<double>(
      1,
      (double value, HabitMoodPoint point) =>
          math.max(value, point.avgIntensity ?? 0),
    );

    return SizedBox(
      height: 170,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: points
            .map((HabitMoodPoint point) {
              final double barHeight = math.max(
                20,
                (point.habitsCompleted / maxHabits) * 110,
              );
              final double moodHeight = math.max(
                12,
                ((point.avgIntensity ?? 0) / maxIntensity) * 70,
              );
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        width: 8,
                        height: moodHeight,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF59E0B),
                          borderRadius: BorderRadius.circular(999),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        width: 22,
                        height: barHeight,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(999),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '${point.date.day}/${point.date.month}',
                        style: const TextStyle(
                          fontSize: 10,
                          color: Color(0xFF94A3B8),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            })
            .toList(growable: false),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 16),
          child,
        ],
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
