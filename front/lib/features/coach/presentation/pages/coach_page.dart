import 'package:flutter/material.dart';
import 'package:mind_track/app/generated/l10n.dart';
import 'package:mind_track/app/theme/mt_colors.dart';
import 'package:mind_track/app/injector.dart';
import 'package:mind_track/app/theme/app_colors.dart';
import 'package:mind_track/shared/widget/mindtrack_app_bar.dart';
import 'package:mind_track/features/coach/domain/entities/coach_response.dart';
import 'package:mind_track/features/coach/domain/repositories/coach_repository.dart';

class CoachPage extends StatefulWidget {
  const CoachPage({super.key});

  @override
  State<CoachPage> createState() => _CoachPageState();
}

class _CoachPageState extends State<CoachPage> {
  final CoachRepository _coachRepository = Injector.get<CoachRepository>();

  bool _isLoading = true;
  String? _errorMessage;
  CoachResponse? _response;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {
      final CoachResponse response = await _coachRepository
          .fetchCoachResponse();
      if (!mounted) {
        return;
      }
      setState(() {
        _response = response;
        _isLoading = false;
      });
    } catch (error) {
      if (!mounted) {
        return;
      }
      setState(() {
        _errorMessage = error.toString().replaceFirst('Exception: ', '');
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final CoachResponse? response = _response;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: MindTrackAppBar(title: S.of(context).coach_title),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _loadData,
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: <Color>[Color(0xFF5FA9D3), Color(0xFF16324F)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(28),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      response?.heroLabel ?? S.of(context).coach_hero_label,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      response?.heroDescription ??
                          S.of(context).coach_hero_description,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              if (_isLoading)
                const Padding(
                  padding: EdgeInsets.only(top: 80),
                  child: Center(child: CircularProgressIndicator()),
                )
              else if (_errorMessage != null)
                _ErrorState(message: _errorMessage!, onRetry: _loadData)
              else ...<Widget>[
                ...(response?.insights ?? <CoachInsight>[]).map((
                  CoachInsight insight,
                ) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 14),
                    child: _InsightCard(
                      text: insight.message,
                      priority: insight.priority,
                    ),
                  );
                }),
                if (response != null)
                  _QuickStats(
                    totalLogs: response.summary.totalLogs,
                    avgIntensity: response.summary.avgIntensity,
                    completionPct: response.summary.habitsCompletionPct,
                  ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _InsightCard extends StatelessWidget {
  const _InsightCard({required this.text, required this.priority});

  final String text;
  final String priority;

  @override
  Widget build(BuildContext context) {
    final Color tone = switch (priority) {
      'high' => const Color(0xFFDC2626),
      'medium' => const Color(0xFFD97706),
      _ => AppColors.primary,
    };

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: context.mtColors.card,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: context.mtColors.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: tone.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.tips_and_updates_outlined, color: tone),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(height: 1.5, color: Color(0xFF334155)),
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickStats extends StatelessWidget {
  const _QuickStats({
    required this.totalLogs,
    required this.avgIntensity,
    required this.completionPct,
  });

  final int totalLogs;
  final double? avgIntensity;
  final double? completionPct;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: _StatTile(
            label: S.of(context).coach_stat_logs,
            value: '$totalLogs',
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _StatTile(
            label: S.of(context).coach_stat_intensity,
            value: avgIntensity?.toStringAsFixed(1) ?? '--',
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _StatTile(
            label: S.of(context).coach_stat_habits,
            value: completionPct != null ? '${completionPct!.round()}%' : '--',
          ),
        ),
      ],
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      decoration: BoxDecoration(
        color: context.mtColors.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: context.mtColors.border),
      ),
      child: Column(
        children: <Widget>[
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: context.mtColors.textPrimary,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: context.mtColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.message, required this.onRetry});

  final String message;
  final Future<void> Function() onRetry;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 60),
      child: Center(
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
