import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mind_track/app/injector.dart';
import 'package:mind_track/app/routes/route_names.dart';
import 'package:mind_track/app/theme/app_colors.dart';
import 'package:mind_track/features/emotion_tracker/domain/entities/emotion_entry.dart';
import 'package:mind_track/features/emotion_tracker/presentation/cubit/emotion_cubit.dart';
import 'package:mind_track/features/emotion_tracker/presentation/cubit/emotion_state.dart';

class DailyMoodPage extends StatelessWidget {
  const DailyMoodPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EmotionCubit>(
      create: (_) => Injector.get<EmotionCubit>()..loadEntries(),
      child: const _DailyMoodView(),
    );
  }
}

class _DailyMoodView extends StatelessWidget {
  const _DailyMoodView();

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
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: const Text('Historial emocional'),
          backgroundColor: AppColors.background,
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => _openComposer(context),
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          icon: const Icon(Icons.add_rounded),
          label: const Text('Registrar'),
        ),
        body: RefreshIndicator(
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

  Widget _buildBody(BuildContext context, EmotionState state) {
    if (state.isLoading && state.entries.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.errorMessage != null && state.entries.isEmpty) {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: <Widget>[
          SizedBox(
            height: 420,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Icon(
                      Icons.cloud_off_rounded,
                      size: 48,
                      color: Color(0xFF94A3B8),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      state.errorMessage!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Color(0xFF475569)),
                    ),
                    const SizedBox(height: 16),
                    FilledButton(
                      onPressed: () =>
                          context.read<EmotionCubit>().loadEntries(),
                      child: const Text('Reintentar'),
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
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(24),
        children: const <Widget>[
          SizedBox(height: 120),
          Icon(
            Icons.psychology_alt_rounded,
            size: 56,
            color: AppColors.primary,
          ),
          SizedBox(height: 16),
          Text(
            'Todavía no tienes emociones registradas.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 8),
          Text(
            'Usa el botón de registrar para empezar a construir tu historial.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Color(0xFF64748B), height: 1.4),
          ),
        ],
      );
    }

    return ListView.separated(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
      itemCount: state.entries.length,
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (BuildContext context, int index) {
        final EmotionEntry entry = state.entries[index];
        return Dismissible(
          key: ValueKey<String>(entry.id),
          direction: DismissDirection.endToStart,
          confirmDismiss: (_) => _confirmDelete(context),
          onDismissed: (_) {
            context.read<EmotionCubit>().deleteEntryFromList(entry.id);
          },
          background: Container(
            decoration: BoxDecoration(
              color: const Color(0xFFEF4444),
              borderRadius: BorderRadius.circular(24),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.centerRight,
            child: const Icon(
              Icons.delete_outline_rounded,
              color: Colors.white,
            ),
          ),
          child: Material(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            child: InkWell(
              borderRadius: BorderRadius.circular(24),
              onTap: () => _openDetail(context, entry.id),
              child: Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: _colorFromHex(
                          entry.colorHex,
                        ).withValues(alpha: 0.14),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        _iconForEmotion(entry),
                        color: _colorFromHex(entry.colorHex),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            entry.localizedName('es'),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF0F172A),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _subtitle(entry),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Color(0xFF64748B),
                              height: 1.35,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          'Int ${entry.intensity}/10',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          _formatDate(entry.loggedAt),
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF94A3B8),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _openComposer(BuildContext context) async {
    final Object? result = await Navigator.of(
      context,
    ).pushNamed(RouteNames.addEmotion);
    if (result == true && context.mounted) {
      await context.read<EmotionCubit>().loadEntries();
    }
  }

  Future<void> _openDetail(BuildContext context, String id) async {
    final Object? result = await Navigator.of(
      context,
    ).pushNamed(RouteNames.emotionDetail, arguments: id);
    if (result == true && context.mounted) {
      await context.read<EmotionCubit>().loadEntries();
    }
  }

  Future<bool> _confirmDelete(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Eliminar registro'),
              content: const Text(
                'Esta acción quitará la emoción de tu historial.',
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('Cancelar'),
                ),
                FilledButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text('Eliminar'),
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
      return 'Sin nota adicional.';
    }
    return contexts.join(' • ');
  }

  String _formatDate(DateTime dateTime) {
    final String day = dateTime.day.toString().padLeft(2, '0');
    final String month = dateTime.month.toString().padLeft(2, '0');
    final String hour = dateTime.hour.toString().padLeft(2, '0');
    final String minute = dateTime.minute.toString().padLeft(2, '0');
    return '$day/$month $hour:$minute';
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
