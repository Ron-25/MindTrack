import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mind_track/app/injector.dart';
import 'package:mind_track/app/theme/mt_colors.dart';
import 'package:mind_track/app/theme/app_colors.dart';
import 'package:mind_track/features/emotion_tracker/domain/entities/emotion_entry.dart';
import 'package:mind_track/features/emotion_tracker/presentation/cubit/emotion_cubit.dart';
import 'package:mind_track/features/emotion_tracker/presentation/cubit/emotion_state.dart';

class EmotionDetailPage extends StatelessWidget {
  const EmotionDetailPage({super.key, this.emotionId});

  final String? emotionId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EmotionCubit>(
      create: (_) {
        final EmotionCubit cubit = Injector.get<EmotionCubit>();
        if (emotionId != null && emotionId!.isNotEmpty) {
          cubit.loadEntry(emotionId!);
        }
        return cubit;
      },
      child: const _EmotionDetailView(),
    );
  }
}

class _EmotionDetailView extends StatefulWidget {
  const _EmotionDetailView();

  @override
  State<_EmotionDetailView> createState() => _EmotionDetailViewState();
}

class _EmotionDetailViewState extends State<_EmotionDetailView> {
  bool _modified = false;

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
        if (state.successMessage != null && state.selectedEntry == null) {
          Navigator.of(context).pop(true);
          return;
        }
        if (state.successMessage != null) {
          // Edición exitosa: notifica y marca para recargar el historial.
          _modified = true;
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.successMessage!)));
          context.read<EmotionCubit>().clearFeedback();
        }
      },
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: (bool didPop, Object? result) {
          if (!didPop) {
            Navigator.of(context).pop(_modified);
          }
        },
        child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(
            title: const Text('Detalle de emoción'),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            actions: <Widget>[
              BlocBuilder<EmotionCubit, EmotionState>(
                builder: (BuildContext context, EmotionState state) {
                  return IconButton(
                    tooltip: 'Editar registro',
                    onPressed: state.selectedEntry == null || state.isSaving
                        ? null
                        : () => _openEditSheet(context),
                    icon: state.isSaving
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.edit_outlined),
                  );
                },
              ),
              BlocBuilder<EmotionCubit, EmotionState>(
                builder: (BuildContext context, EmotionState state) {
                  return IconButton(
                    tooltip: 'Eliminar registro',
                    onPressed: state.selectedEntry == null || state.isDeleting
                        ? null
                        : () => _delete(context),
                    icon: state.isDeleting
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.delete_outline_rounded),
                  );
                },
              ),
            ],
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              final EmotionEntry? entry = context
                  .read<EmotionCubit>()
                  .state
                  .selectedEntry;
              if (entry != null) {
                await context.read<EmotionCubit>().loadEntry(entry.id);
              }
            },
            child: BlocBuilder<EmotionCubit, EmotionState>(
              builder: (BuildContext context, EmotionState state) {
                return _buildBody(context, state);
              },
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _openEditSheet(BuildContext context) async {
    final EmotionCubit cubit = context.read<EmotionCubit>();
    final EmotionEntry? entry = cubit.state.selectedEntry;
    if (entry == null) {
      return;
    }

    final UpdateEmotionEntryInput? input =
        await showModalBottomSheet<UpdateEmotionEntryInput>(
          context: context,
          isScrollControlled: true,
          backgroundColor: Theme.of(context).colorScheme.surface,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          builder: (BuildContext context) => _EditEmotionSheet(entry: entry),
        );

    if (input == null || !context.mounted) {
      return;
    }
    await cubit.updateSelectedEntry(input);
  }

  Widget _buildBody(BuildContext context, EmotionState state) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (state.errorMessage != null && state.selectedEntry == null) {
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
                    Text(state.errorMessage!, textAlign: TextAlign.center),
                    const SizedBox(height: 16),
                    FilledButton(
                      onPressed: () {
                        final EmotionDetailPage? widget = context
                            .findAncestorWidgetOfExactType<EmotionDetailPage>();
                        final String? emotionId = widget?.emotionId;
                        if (emotionId != null && emotionId.isNotEmpty) {
                          context.read<EmotionCubit>().loadEntry(emotionId);
                        }
                      },
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

    final EmotionEntry entry = state.selectedEntry!;
    final Color accent = _colorFromHex(entry.colorHex);
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: context.mtColors.card,
            borderRadius: BorderRadius.circular(28),
            border: Border.all(color: context.mtColors.border),
          ),
          child: Column(
            children: <Widget>[
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.14),
                  shape: BoxShape.circle,
                ),
                child: Icon(_iconForEmotion(entry), size: 34, color: accent),
              ),
              const SizedBox(height: 16),
              Text(
                entry.localizedName('es'),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: context.mtColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Intensidad ${entry.intensity}/10',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                _formatDateTime(entry.loggedAt),
                style: TextStyle(color: context.mtColors.textSecondary),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _DetailCard(
          title: 'Notas',
          content: entry.note?.trim().isNotEmpty == true
              ? entry.note!
              : 'No agregaste una nota para este registro.',
        ),
        const SizedBox(height: 16),
        _DetailCard(title: 'Contexto', content: _buildContextText(entry)),
        if (entry.tags.isNotEmpty) ...<Widget>[
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: context.mtColors.card,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: context.mtColors.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Tags',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: context.mtColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: entry.tags
                      .map((EmotionTag tag) {
                        final Color tagAccent = _colorFromHex(tag.colorHex);
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: tagAccent.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Text(
                            tag.name,
                            style: TextStyle(
                              color: tagAccent,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        );
                      })
                      .toList(growable: false),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Future<void> _delete(BuildContext context) async {
    final bool confirmed =
        await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Eliminar emoción'),
              content: const Text(
                'Este registro se borrará del historial y no se podrá recuperar.',
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
    if (!confirmed || !context.mounted) {
      return;
    }
    await context.read<EmotionCubit>().deleteSelectedEntry();
  }

  String _buildContextText(EmotionEntry entry) {
    final List<String> pieces = <String>[
      if (entry.contextActivity?.trim().isNotEmpty == true)
        'Actividad: ${entry.contextActivity}',
      if (entry.contextPlace?.trim().isNotEmpty == true)
        'Lugar: ${entry.contextPlace}',
      if (entry.contextPeople?.trim().isNotEmpty == true)
        'Personas: ${entry.contextPeople}',
    ];
    if (pieces.isEmpty) {
      return 'No registraste contexto para esta emoción.';
    }
    return pieces.join('\n');
  }

  String _formatDateTime(DateTime dateTime) {
    final String day = dateTime.day.toString().padLeft(2, '0');
    final String month = dateTime.month.toString().padLeft(2, '0');
    final String year = dateTime.year.toString();
    final String hour = dateTime.hour.toString().padLeft(2, '0');
    final String minute = dateTime.minute.toString().padLeft(2, '0');
    return '$day/$month/$year a las $hour:$minute';
  }

  Color _colorFromHex(String? hex) {
    if (hex == null || hex.isEmpty) {
      return AppColors.primary;
    }
    return Color(int.parse('FF${hex.replaceFirst('#', '')}', radix: 16));
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
    if (value.contains('ang') || value.contains('eno')) {
      return Icons.local_fire_department_rounded;
    }
    if (value.contains('calm') || value.contains('peace')) {
      return Icons.self_improvement_rounded;
    }
    return Icons.mood_rounded;
  }
}

class _EditEmotionSheet extends StatefulWidget {
  const _EditEmotionSheet({required this.entry});

  final EmotionEntry entry;

  @override
  State<_EditEmotionSheet> createState() => _EditEmotionSheetState();
}

class _EditEmotionSheetState extends State<_EditEmotionSheet> {
  late final TextEditingController _noteController;
  late double _intensity;

  @override
  void initState() {
    super.initState();
    _noteController = TextEditingController(text: widget.entry.note ?? '');
    _intensity = widget.entry.intensity.toDouble();
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(
          20,
          20,
          20,
          MediaQuery.of(context).viewInsets.bottom + 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Editar registro',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: context.mtColors.textPrimary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              widget.entry.localizedName('es'),
              style: TextStyle(
                fontSize: 14,
                color: context.mtColors.textSecondary,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Intensidad: ${_intensity.round()}/10',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: context.mtColors.textPrimary,
              ),
            ),
            Slider(
              value: _intensity,
              min: 1,
              max: 10,
              divisions: 9,
              activeColor: AppColors.primary,
              label: '${_intensity.round()}',
              onChanged: (double value) {
                setState(() => _intensity = value);
              },
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _noteController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Nota',
                hintText: 'Escribe una nota para este registro',
                filled: true,
                fillColor: context.mtColors.surfaceSubtle,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: <Widget>[
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text('Cancelar'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton(
                    onPressed: () {
                      Navigator.of(context).pop(
                        UpdateEmotionEntryInput(
                          intensity: _intensity.round(),
                          note: _noteController.text.trim(),
                        ),
                      );
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text('Guardar cambios'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailCard extends StatelessWidget {
  const _DetailCard({required this.title, required this.content});

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
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
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: context.mtColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            content,
            style: TextStyle(
              height: 1.5,
              color: context.mtColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
