import 'package:flutter/material.dart';
import 'package:mind_track/app/generated/l10n.dart';
import 'package:mind_track/app/theme/mt_colors.dart';
import 'package:mind_track/app/injector.dart';
import 'package:mind_track/app/routes/route_names.dart';
import 'package:mind_track/shared/widget/mindtrack_app_bar.dart';
import 'package:mind_track/features/emotion_tracker/domain/entities/emotion_entry.dart';
import 'package:mind_track/features/emotion_tracker/domain/repositories/emotion_repository.dart';
import 'package:mind_track/features/habits/domain/entities/habit_tracker.dart';
import 'package:mind_track/features/habits/domain/repositories/habit_repository.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final EmotionRepository _emotionRepository =
      Injector.get<EmotionRepository>();
  final HabitRepository _habitRepository = Injector.get<HabitRepository>();
  final TextEditingController _controller = TextEditingController();

  bool _isLoading = true;
  String? _errorMessage;
  List<EmotionEntry> _entries = <EmotionEntry>[];
  List<HabitTracker> _habits = <HabitTracker>[];
  String _query = '';

  @override
  void initState() {
    super.initState();
    _loadData();
    _controller.addListener(() {
      setState(() => _query = _controller.text.trim().toLowerCase());
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {
      final List<dynamic> results =
          await Future.wait<dynamic>(<Future<dynamic>>[
            _emotionRepository.fetchEntries(limit: 100),
            _habitRepository.fetchHabits(),
          ]);
      if (!mounted) {
        return;
      }
      setState(() {
        _entries = results[0] as List<EmotionEntry>;
        _habits = results[1] as List<HabitTracker>;
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
    final List<EmotionEntry> filteredEntries = _entries
        .where((EmotionEntry entry) {
          if (_query.isEmpty) {
            return true;
          }
          final String haystack = <String>[
            entry.emotionName,
            entry.emotionNameEs ?? '',
            entry.note ?? '',
            entry.contextActivity ?? '',
            entry.contextPlace ?? '',
            entry.contextPeople ?? '',
          ].join(' ').toLowerCase();
          return haystack.contains(_query);
        })
        .toList(growable: false);
    final List<HabitTracker> filteredHabits = _habits
        .where((HabitTracker habit) {
          if (_query.isEmpty) {
            return true;
          }
          final String haystack = <String>[
            habit.name,
            habit.description ?? '',
            habit.category ?? '',
          ].join(' ').toLowerCase();
          return haystack.contains(_query);
        })
        .toList(growable: false);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: MindTrackAppBar(title: S.of(context).search_title),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _loadData,
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
            children: <Widget>[
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: S.of(context).search_hint,
                  prefixIcon: const Icon(Icons.search_rounded),
                  filled: true,
                  fillColor: context.mtColors.card,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none,
                  ),
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
                _Section(
                  title: S.of(context).search_habits_title,
                  child: filteredHabits.isEmpty
                      ? Text(
                          S.of(context).search_habits_empty,
                          style: TextStyle(
                            color: context.mtColors.textSecondary,
                          ),
                        )
                      : Column(
                          children: filteredHabits
                              .map((HabitTracker habit) {
                                return ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  leading: Icon(
                                    habit.completedToday
                                        ? Icons.check_circle_rounded
                                        : Icons.radio_button_unchecked_rounded,
                                  ),
                                  title: Text(habit.name),
                                  subtitle:
                                      habit.description?.trim().isNotEmpty ==
                                          true
                                      ? Text(habit.description!)
                                      : null,
                                  trailing: const Icon(
                                    Icons.chevron_right_rounded,
                                  ),
                                  onTap: () {
                                    Navigator.of(
                                      context,
                                    ).pushNamed(RouteNames.habits);
                                  },
                                );
                              })
                              .toList(growable: false),
                        ),
                ),
                const SizedBox(height: 16),
                _Section(
                  title: S.of(context).search_emotions_title,
                  child: filteredEntries.isEmpty
                      ? Text(
                          S.of(context).search_emotions_empty,
                          style: TextStyle(
                            color: context.mtColors.textSecondary,
                          ),
                        )
                      : Column(
                          children: filteredEntries
                              .map((EmotionEntry entry) {
                                return ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  leading: const Icon(Icons.mood_rounded),
                                  title: Text(entry.localizedName('es')),
                                  subtitle: Text(
                                    (entry.note?.trim().isNotEmpty == true
                                            ? entry.note!
                                            : entry.contextActivity) ??
                                        S.of(context).search_no_detail,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  trailing: const Icon(
                                    Icons.chevron_right_rounded,
                                  ),
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                      RouteNames.emotionDetail,
                                      arguments: entry.id,
                                    );
                                  },
                                );
                              })
                              .toList(growable: false),
                        ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: context.mtColors.card,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: context.mtColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: context.mtColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          child,
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
