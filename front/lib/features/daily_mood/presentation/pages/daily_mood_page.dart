import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mind_track/app/generated/l10n.dart';
import 'package:mind_track/app/theme/mt_colors.dart';
import 'package:mind_track/app/injector.dart';
import 'package:mind_track/app/routes/route_names.dart';
import 'package:mind_track/app/theme/app_colors.dart';
import 'package:mind_track/features/analytics/presentation/cubit/analytics_cubit.dart';
import 'package:mind_track/features/emotion_tracker/domain/entities/emotion_entry.dart';
import 'package:mind_track/features/emotion_tracker/presentation/cubit/emotion_cubit.dart';
import 'package:mind_track/features/emotion_tracker/presentation/cubit/emotion_state.dart';
import 'package:mind_track/features/home/presentation/cubit/home_cubit.dart';
import 'package:mind_track/shared/widget/mindtrack_app_bar.dart';

class DailyMoodPage extends StatelessWidget {
  const DailyMoodPage({super.key, this.searchMode = false});

  final bool searchMode;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EmotionCubit>(
      create: (_) => Injector.get<EmotionCubit>()..loadEntries(),
      child: _DailyMoodView(searchMode: searchMode),
    );
  }
}

class _DailyMoodView extends StatefulWidget {
  const _DailyMoodView({required this.searchMode});

  final bool searchMode;

  @override
  State<_DailyMoodView> createState() => _DailyMoodViewState();
}

class _DailyMoodViewState extends State<_DailyMoodView> {
  late final TextEditingController _searchController;
  String _query = '';
  String? _emotionFilter;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _searchController.addListener(() {
      setState(() => _query = _searchController.text.trim().toLowerCase());
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EmotionCubit, EmotionState>(
      listenWhen: (EmotionState previous, EmotionState current) {
        return previous.errorMessage != current.errorMessage ||
            previous.successMessage != current.successMessage;
      },
      listener: (BuildContext context, EmotionState state) {
        if (state.errorMessage != null) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
          context.read<EmotionCubit>().clearFeedback();
          return;
        }
        if (state.successMessage != null) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.successMessage!)));
          context.read<EmotionCubit>().clearFeedback();
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: MindTrackAppBar(
          title: widget.searchMode
              ? S.current.history_search_title
              : S.current.history_title,
        ),
        floatingActionButton: _buildLogEmotionButton(context),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: RefreshIndicator(
          color: AppColors.primary,
          onRefresh: () => context.read<EmotionCubit>().loadEntries(),
          child: BlocBuilder<EmotionCubit, EmotionState>(
            builder: (BuildContext context, EmotionState state) {
              return _buildBody(context, state);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildLogEmotionButton(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          S.current.history_log_button,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.27,
            color: context.mtColors.textPrimary,
          ),
        ),
        SizedBox(height: 8),
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => _openComposer(context),
            customBorder: CircleBorder(),
            child: Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  width: 4,
                ),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Color(0x665FA9D3),
                    blurRadius: 15,
                    offset: Offset(0, 10),
                  ),
                ],
              ),
              child: Icon(Icons.add_rounded, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBody(BuildContext context, EmotionState state) {
    if (state.isLoading && state.entries.isEmpty) {
      return Center(child: CircularProgressIndicator());
    }

    if (state.errorMessage != null && state.entries.isEmpty) {
      return ListView(
        physics: AlwaysScrollableScrollPhysics(),
        children: <Widget>[
          SizedBox(
            height: 420,
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      Icons.cloud_off_rounded,
                      size: 48,
                      color: context.mtColors.textMuted,
                    ),
                    SizedBox(height: 16),
                    Text(
                      state.errorMessage!,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: context.mtColors.textSecondary),
                    ),
                    SizedBox(height: 16),
                    FilledButton(
                      onPressed: () =>
                          context.read<EmotionCubit>().loadEntries(),
                      child: Text(S.current.home_retry),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    }

    if (state.entries.isEmpty) {
      return ListView(
        physics: AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.all(24),
        children: <Widget>[
          SizedBox(height: 120),
          Icon(
            Icons.psychology_alt_rounded,
            size: 56,
            color: AppColors.primary,
          ),
          SizedBox(height: 16),
          Text(
            S.current.history_empty_title,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 8),
          Text(
            S.current.history_empty_desc,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: context.mtColors.textSecondary,
              height: 1.4,
            ),
          ),
        ],
      );
    }

    final List<EmotionEntry> filteredEntries = state.entries
        .where(
          (EmotionEntry entry) => _matchesQuery(entry) && _matchesFilter(entry),
        )
        .toList(growable: false);
    final List<_DayGroup> groups = _groupByDay(filteredEntries);

    return ListView(
      physics: AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.fromLTRB(16, 16, 16, 160),
      children: <Widget>[
        _buildSearchBar(context),
        SizedBox(height: 16),
        _buildFilterChips(context, state.entries),
        if (_query.isNotEmpty || _emotionFilter != null) ...<Widget>[
          SizedBox(height: 12),
          Text(
            S.current.history_results(filteredEntries.length),
            style: TextStyle(
              fontSize: 13,
              color: context.mtColors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
        SizedBox(height: 24),
        if (filteredEntries.isEmpty)
          Padding(
            padding: EdgeInsets.only(top: 28),
            child: Center(
              child: Text(
                S.current.history_no_results,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: context.mtColors.textSecondary,
                  height: 1.4,
                ),
              ),
            ),
          )
        else
          ...groups.map(
            (_DayGroup group) => Padding(
              padding: EdgeInsets.only(bottom: 24),
              child: _buildDayGroup(context, group),
            ),
          ),
      ],
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    final S translations = S.of(context);
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: context.mtColors.card,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: context.mtColors.border),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 1,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: TextField(
        controller: _searchController,
        autofocus: widget.searchMode,
        style: TextStyle(fontSize: 16, color: context.mtColors.textPrimary),
        decoration: InputDecoration(
          hintText: widget.searchMode
              ? translations.search_hint
              : S.current.history_search_hint,
          hintStyle: TextStyle(fontSize: 16, color: context.mtColors.textMuted),
          prefixIcon: Icon(
            Icons.search_rounded,
            size: 20,
            color: context.mtColors.textMuted,
          ),
          suffixIcon: _query.isEmpty
              ? null
              : IconButton(
                  onPressed: _searchController.clear,
                  icon: Icon(
                    Icons.close_rounded,
                    size: 20,
                    color: context.mtColors.textMuted,
                  ),
                ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 13,
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChips(BuildContext context, List<EmotionEntry> entries) {
    final String locale = Localizations.localeOf(context).languageCode;
    final List<String> emotionNames = <String>[];
    for (final EmotionEntry entry in entries) {
      final String name = entry.localizedName(locale);
      if (!emotionNames.contains(name)) {
        emotionNames.add(name);
      }
    }

    return SizedBox(
      height: 36,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          _FilterChipButton(
            label: S.current.history_all_filter,
            isSelected: _emotionFilter == null,
            onTap: () => setState(() => _emotionFilter = null),
          ),
          ...emotionNames.map(
            (String name) => Padding(
              padding: EdgeInsets.only(left: 8),
              child: _FilterChipButton(
                label: name,
                isSelected: _emotionFilter == name,
                onTap: () => setState(
                  () => _emotionFilter = _emotionFilter == name ? null : name,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDayGroup(BuildContext context, _DayGroup group) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          _dayLabel(context, group.date).toUpperCase(),
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.7,
            color: context.mtColors.textSecondary,
          ),
        ),
        SizedBox(height: 12),
        Stack(
          children: <Widget>[
            Positioned(
              left: 21,
              top: 16,
              bottom: 16,
              child: Container(width: 2, color: context.mtColors.border),
            ),
            Column(
              children: List<Widget>.generate(group.entries.length, (
                int index,
              ) {
                return Padding(
                  padding: EdgeInsets.only(
                    bottom: index == group.entries.length - 1 ? 0 : 12,
                  ),
                  child: _buildEntry(context, group.entries[index]),
                );
              }),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildEntry(BuildContext context, EmotionEntry entry) {
    final String locale = Localizations.localeOf(context).languageCode;
    final Color accent = _colorFromHex(entry.colorHex);

    return Dismissible(
      key: ValueKey<String>(entry.id),
      direction: DismissDirection.endToStart,
      confirmDismiss: (_) => _confirmDelete(context),
      onDismissed: (_) {
        context.read<EmotionCubit>().deleteEntryFromList(entry.id);
      },
      background: Container(
        margin: EdgeInsets.only(left: 40),
        decoration: BoxDecoration(
          color: Color(0xFFEF4444),
          borderRadius: BorderRadius.circular(24),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20),
        alignment: Alignment.centerRight,
        child: Icon(Icons.delete_outline_rounded, color: Colors.white),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 40),
            child: Material(
              color: context.mtColors.card,
              borderRadius: BorderRadius.circular(24),
              child: InkWell(
                borderRadius: BorderRadius.circular(24),
                onTap: () => _openDetail(context, entry.id),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: context.mtColors.borderSubtle),
                    boxShadow: <BoxShadow>[
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
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  entry.localizedName(locale),
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: context.mtColors.textPrimary,
                                  ),
                                ),
                                Text(
                                  _formatTime(context, entry.loggedAt),
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: context.mtColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                S.current.history_intensity_label,
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  color: context.mtColors.textMuted,
                                ),
                              ),
                              SizedBox(height: 4),
                              _IntensityBars(intensity: entry.intensity),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        _subtitle(entry),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.45,
                          color: context.mtColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            top: 4,
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: Color.alphaBlend(
                  accent.withValues(alpha: 0.16),
                  Colors.white,
                ),
                shape: BoxShape.circle,
                border: Border.all(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  width: 4,
                ),
              ),
              child: Icon(_iconForEmotion(entry), size: 20, color: accent),
            ),
          ),
        ],
      ),
    );
  }

  bool _matchesQuery(EmotionEntry entry) {
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
      ...entry.tags.map((EmotionTag tag) => tag.name),
    ].join(' ').toLowerCase();

    return haystack.contains(_query);
  }

  bool _matchesFilter(EmotionEntry entry) {
    if (_emotionFilter == null) {
      return true;
    }
    final String locale = Localizations.localeOf(context).languageCode;
    return entry.localizedName(locale) == _emotionFilter;
  }

  List<_DayGroup> _groupByDay(List<EmotionEntry> entries) {
    final List<EmotionEntry> sorted = List<EmotionEntry>.from(entries)
      ..sort(
        (EmotionEntry a, EmotionEntry b) => b.loggedAt.compareTo(a.loggedAt),
      );

    final List<_DayGroup> groups = <_DayGroup>[];
    for (final EmotionEntry entry in sorted) {
      final DateTime day = DateTime(
        entry.loggedAt.year,
        entry.loggedAt.month,
        entry.loggedAt.day,
      );
      if (groups.isNotEmpty && groups.last.date == day) {
        groups.last.entries.add(entry);
      } else {
        groups.add(_DayGroup(date: day, entries: <EmotionEntry>[entry]));
      }
    }
    return groups;
  }

  String _dayLabel(BuildContext context, DateTime date) {
    final DateTime now = DateTime.now();
    final DateTime today = DateTime(now.year, now.month, now.day);
    if (date == today) {
      return S.current.history_today;
    }
    if (date == today.subtract(Duration(days: 1))) {
      return S.current.history_yesterday;
    }
    final String locale = Localizations.localeOf(context).languageCode;
    return DateFormat.MMMEd(locale).format(date);
  }

  String _formatTime(BuildContext context, DateTime dateTime) {
    return MaterialLocalizations.of(context).formatTimeOfDay(
      TimeOfDay.fromDateTime(dateTime),
      alwaysUse24HourFormat: false,
    );
  }

  Future<void> _openComposer(BuildContext context) async {
    final Object? result = await Navigator.of(
      context,
    ).pushNamed(RouteNames.addEmotion);
    if (result == true && context.mounted) {
      await context.read<EmotionCubit>().loadEntries();
      _refreshDependentTabs();
    }
  }

  Future<void> _openDetail(BuildContext context, String id) async {
    final Object? result = await Navigator.of(
      context,
    ).pushNamed(RouteNames.emotionDetail, arguments: id);
    if (result == true && context.mounted) {
      await context.read<EmotionCubit>().loadEntries();
      _refreshDependentTabs();
    }
  }

  void _refreshDependentTabs() {
    Injector.get<HomeCubit>().loadDashboard();
    Injector.get<AnalyticsCubit>().loadSnapshot();
  }

  Future<bool> _confirmDelete(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(S.current.history_delete_title),
              content: Text(
                S.current.history_delete_desc,
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text(S.current.common_cancel),
                ),
                FilledButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text(S.current.common_delete),
                ),
              ],
            );
          },
        ) ??
        false;
  }

  String _subtitle(EmotionEntry entry) {
    if (entry.note != null && entry.note!.trim().isNotEmpty) {
      return entry.note!;
    }
    final List<String> contexts = <String>[
      if (entry.contextActivity != null && entry.contextActivity!.isNotEmpty)
        entry.contextActivity!,
      if (entry.contextPlace != null && entry.contextPlace!.isNotEmpty)
        entry.contextPlace!,
      if (entry.contextPeople != null && entry.contextPeople!.isNotEmpty)
        entry.contextPeople!,
    ];
    if (contexts.isEmpty) {
      return S.current.home_entry_no_note;
    }
    return contexts.join(' • ');
  }

  Color _colorFromHex(String? hex) {
    if (hex == null || hex.isEmpty) {
      return AppColors.primary;
    }
    final String normalized = hex.replaceFirst('#', '');
    return Color(int.parse('FF$normalized', radix: 16));
  }

  IconData _iconForEmotion(EmotionEntry entry) {
    final String value =
        '${entry.iconKey ?? ''} ${entry.emotionName.toLowerCase()} ${entry.emotionNameEs?.toLowerCase() ?? ''}';
    if (value.contains('joy') ||
        value.contains('happy') ||
        value.contains('fel')) {
      return Icons.sentiment_very_satisfied_rounded;
    }
    if (value.contains('sad') || value.contains('tri')) {
      return Icons.sentiment_very_dissatisfied_rounded;
    }
    if (value.contains('calm') || value.contains('peace')) {
      return Icons.self_improvement_rounded;
    }
    if (value.contains('ang') ||
        value.contains('rage') ||
        value.contains('eno')) {
      return Icons.local_fire_department_rounded;
    }
    return Icons.mood_rounded;
  }
}

class _DayGroup {
  _DayGroup({required this.date, required this.entries});

  final DateTime date;
  final List<EmotionEntry> entries;
}

class _FilterChipButton extends StatelessWidget {
  const _FilterChipButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isSelected ? AppColors.primary : Colors.white,
      borderRadius: BorderRadius.circular(999),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(999),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(999),
            border: isSelected
                ? null
                : Border.all(color: context.mtColors.border),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: isSelected ? Colors.white : context.mtColors.textPrimary,
            ),
          ),
        ),
      ),
    );
  }
}

class _IntensityBars extends StatelessWidget {
  const _IntensityBars({required this.intensity});

  /// Intensidad en escala 1-10; se muestra en 5 segmentos.
  final int intensity;

  @override
  Widget build(BuildContext context) {
    final int filled = (intensity / 2).ceil().clamp(0, 5);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List<Widget>.generate(5, (int index) {
        return Padding(
          padding: EdgeInsets.only(left: index == 0 ? 0 : 2),
          child: Container(
            width: 16,
            height: 6,
            decoration: BoxDecoration(
              color: index < filled
                  ? AppColors.primary
                  : context.mtColors.border,
              borderRadius: BorderRadius.circular(999),
            ),
          ),
        );
      }),
    );
  }
}
