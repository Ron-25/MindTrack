import 'package:flutter/material.dart';
import 'package:mind_track/app/generated/l10n.dart';
import 'package:mind_track/app/injector.dart';
import 'package:mind_track/features/emotion_tracker/domain/entities/emotion_entry.dart';
import 'package:mind_track/features/emotion_tracker/domain/repositories/emotion_repository.dart';
import 'package:mind_track/features/habits/domain/entities/habit_tracker.dart';
import 'package:mind_track/features/habits/domain/repositories/habit_repository.dart';
import 'package:mind_track/features/profile/domain/entities/profile_settings_data.dart';
import 'package:mind_track/features/profile/domain/repositories/profile_repository.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final ProfileRepository _profileRepository =
      Injector.get<ProfileRepository>();
  final HabitRepository _habitRepository = Injector.get<HabitRepository>();
  final EmotionRepository _emotionRepository =
      Injector.get<EmotionRepository>();

  bool _isLoading = true;
  String? _errorMessage;
  ProfileSettingsData? _profile;
  List<HabitTracker> _habits = <HabitTracker>[];
  List<EmotionEntry> _entries = <EmotionEntry>[];

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
      final List<dynamic> results =
          await Future.wait<dynamic>(<Future<dynamic>>[
            _profileRepository.fetchProfile(),
            _habitRepository.fetchHabits(),
            _emotionRepository.fetchEntries(limit: 20),
          ]);
      if (!mounted) {
        return;
      }
      setState(() {
        _profile = results[0] as ProfileSettingsData;
        _habits = results[1] as List<HabitTracker>;
        _entries = results[2] as List<EmotionEntry>;
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
    final DateTime now = DateTime.now();
    final DateTime today = DateTime(now.year, now.month, now.day);
    final bool hasTodayEmotion = _entries.any((EmotionEntry entry) {
      final DateTime date = DateTime(
        entry.loggedAt.year,
        entry.loggedAt.month,
        entry.loggedAt.day,
      );
      return date == today;
    });
    final List<HabitTracker> pendingHabits = _habits
        .where((HabitTracker habit) => !habit.completedToday)
        .toList(growable: false);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: Text(S.of(context).notifications_title),
        backgroundColor: const Color(0xFFF8FAFC),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _loadData,
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
            children: <Widget>[
              if (_isLoading)
                const Padding(
                  padding: EdgeInsets.only(top: 80),
                  child: Center(child: CircularProgressIndicator()),
                )
              else if (_errorMessage != null)
                _ErrorState(message: _errorMessage!, onRetry: _loadData)
              else ...<Widget>[
                _NotificationCard(
                  icon: _profile?.notificationsEnabled == true
                      ? Icons.notifications_active_outlined
                      : Icons.notifications_off_outlined,
                  title: _profile?.notificationsEnabled == true
                      ? S.of(context).notifications_active_title
                      : S.of(context).notifications_inactive_title,
                  description: _profile?.notificationsEnabled == true
                      ? S.of(context).notifications_active_description
                      : S.of(context).notifications_inactive_description,
                  tone: _profile?.notificationsEnabled == true
                      ? const Color(0xFF0F766E)
                      : const Color(0xFFD97706),
                ),
                const SizedBox(height: 14),
                _NotificationCard(
                  icon: hasTodayEmotion
                      ? Icons.check_circle_outline_rounded
                      : Icons.edit_note_rounded,
                  title: hasTodayEmotion
                      ? S.of(context).notifications_mood_logged_title
                      : S.of(context).notifications_mood_missing_title,
                  description: hasTodayEmotion
                      ? S.of(context).notifications_mood_logged_description
                      : S.of(context).notifications_mood_missing_description,
                  tone: hasTodayEmotion
                      ? const Color(0xFF166534)
                      : const Color(0xFF1D4ED8),
                ),
                const SizedBox(height: 14),
                if (pendingHabits.isEmpty)
                  _NotificationCard(
                    icon: Icons.checklist_rtl_rounded,
                    title: S.of(context).notifications_habits_clear_title,
                    description: S
                        .of(context)
                        .notifications_habits_clear_description,
                    tone: const Color(0xFF166534),
                  )
                else
                  ...pendingHabits.map((HabitTracker habit) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 14),
                      child: _NotificationCard(
                        icon: Icons.alarm_rounded,
                        title: S
                            .of(context)
                            .notifications_pending_title(habit.name),
                        description: S
                            .of(context)
                            .notifications_pending_description(
                              habit.completedDays,
                              habit.targetDaysWeek,
                            ),
                        tone: const Color(0xFF7C3AED),
                      ),
                    );
                  }),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _NotificationCard extends StatelessWidget {
  const _NotificationCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.tone,
  });

  final IconData icon;
  final String title;
  final String description;
  final Color tone;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: tone.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: tone),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  style: const TextStyle(
                    height: 1.45,
                    color: Color(0xFF64748B),
                  ),
                ),
              ],
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
