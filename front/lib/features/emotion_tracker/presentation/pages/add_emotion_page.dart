import 'package:flutter/material.dart';
import 'package:mind_track/app/generated/l10n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mind_track/app/injector.dart';
import 'package:mind_track/app/theme/mt_colors.dart';
import 'package:mind_track/app/routes/route_names.dart';
import 'package:mind_track/app/theme/app_colors.dart';
import 'package:mind_track/features/emotion_tracker/domain/entities/emotion_entry.dart';
import 'package:mind_track/features/emotion_tracker/presentation/cubit/emotion_cubit.dart';
import 'package:mind_track/features/emotion_tracker/presentation/cubit/emotion_state.dart';

class AddEmotionPage extends StatelessWidget {
  const AddEmotionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EmotionCubit>(
      create: (_) => Injector.get<EmotionCubit>()..loadComposerData(),
      child: const _AddEmotionView(),
    );
  }
}

class _AddEmotionView extends StatefulWidget {
  const _AddEmotionView();

  @override
  State<_AddEmotionView> createState() => _AddEmotionViewState();
}

class _AddEmotionViewState extends State<_AddEmotionView> {
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _placeController = TextEditingController();
  final TextEditingController _activityController = TextEditingController();
  final TextEditingController _peopleController = TextEditingController();

  EmotionTypeOption? _selectedEmotion;
  final Set<String> _selectedTagIds = <String>{};
  double _intensity = 5;

  @override
  void dispose() {
    _noteController.dispose();
    _placeController.dispose();
    _activityController.dispose();
    _peopleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EmotionCubit, EmotionState>(
      listenWhen: (EmotionState previous, EmotionState current) {
        return previous.errorMessage != current.errorMessage ||
            previous.lastCreatedEntryId != current.lastCreatedEntryId;
      },
      listener: (BuildContext context, EmotionState state) {
        if (state.errorMessage != null) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
          context.read<EmotionCubit>().clearFeedback();
          return;
        }
        if (state.lastCreatedEntryId != null) {
          Navigator.of(context).pushReplacementNamed(
            RouteNames.emotionDetail,
            arguments: state.lastCreatedEntryId,
          );
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          title: Text(S.current.history_log_button),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        body: BlocBuilder<EmotionCubit, EmotionState>(
          builder: (BuildContext context, EmotionState state) {
            if (_selectedEmotion == null && state.emotionTypes.isNotEmpty) {
              _selectedEmotion = state.emotionTypes.first;
            }
            return _buildBody(context, state);
          },
        ),
        bottomNavigationBar: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
            child: BlocBuilder<EmotionCubit, EmotionState>(
              builder: (BuildContext context, EmotionState state) {
                return FilledButton(
                  onPressed: state.isLoading || state.isSaving ? null : _submit,
                  style: FilledButton.styleFrom(
                    minimumSize: const Size(double.infinity, 56),
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: state.isSaving
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.2,
                            color: Colors.white,
                          ),
                        )
                      : Text(S.current.emotion_save_button),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, EmotionState state) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (state.errorMessage != null &&
        state.emotionTypes.isEmpty &&
        state.tags.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(state.errorMessage!, textAlign: TextAlign.center),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: () =>
                    context.read<EmotionCubit>().loadComposerData(),
                child: const Text('Reintentar'),
              ),
            ],
          ),
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      children: <Widget>[
        Text(
          S.current.emotion_question,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: context.mtColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          S.current.emotion_details_desc,
          style: TextStyle(color: context.mtColors.textSecondary, height: 1.45),
        ),
        const SizedBox(height: 20),
        _SectionCard(
          title: S.current.emotion_primary_label,
          child: Wrap(
            spacing: 10,
            runSpacing: 10,
            children: state.emotionTypes
                .map((EmotionTypeOption type) {
                  final bool isSelected = _selectedEmotion?.id == type.id;
                  final Color accent = _colorFromHex(type.colorHex);
                  return ChoiceChip(
                    label: Text(type.localizedName('es')),
                    selected: isSelected,
                    avatar: Icon(
                      _iconForEmotion(type),
                      size: 18,
                      color: isSelected
                          ? accent
                          : context.mtColors.textSecondary,
                    ),
                    side: BorderSide(color: accent.withValues(alpha: 0.4)),
                    selectedColor: accent.withValues(alpha: 0.16),
                    onSelected: (_) => setState(() => _selectedEmotion = type),
                  );
                })
                .toList(growable: false),
          ),
        ),
        const SizedBox(height: 16),
        _SectionCard(
          title: 'Intensidad',
          child: Column(
            children: <Widget>[
              Slider(
                value: _intensity,
                min: 1,
                max: 10,
                divisions: 9,
                activeColor: AppColors.primary,
                label: _intensity.round().toString(),
                onChanged: (double value) => setState(() => _intensity = value),
              ),
              Row(
                children: <Widget>[
                  Text(
                    'Suave',
                    style: TextStyle(color: context.mtColors.textMuted),
                  ),
                  const Spacer(),
                  Text(
                    '${_intensity.round()}/10',
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'Alta',
                    style: TextStyle(color: context.mtColors.textMuted),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _SectionCard(
          title: 'Contexto',
          child: Column(
            children: <Widget>[
              _AppField(
                controller: _activityController,
                label: 'Actividad',
                hint: S.current.emotion_activity_hint,
                icon: Icons.local_activity_outlined,
              ),
              const SizedBox(height: 12),
              _AppField(
                controller: _placeController,
                label: 'Lugar',
                hint: S.current.emotion_place_hint,
                icon: Icons.place_outlined,
              ),
              const SizedBox(height: 12),
              _AppField(
                controller: _peopleController,
                label: 'Personas',
                hint: S.current.emotion_people_hint,
                icon: Icons.groups_outlined,
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _SectionCard(
          title: 'Nota',
          child: TextField(
            controller: _noteController,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: S.current.emotion_note_hint,
              border: const OutlineInputBorder(),
            ),
          ),
        ),
        if (state.tags.isNotEmpty) ...<Widget>[
          const SizedBox(height: 16),
          _SectionCard(
            title: 'Tags',
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              children: state.tags
                  .map((EmotionTag tag) {
                    final bool isSelected = _selectedTagIds.contains(tag.id);
                    final Color accent = _colorFromHex(tag.colorHex);
                    return FilterChip(
                      label: Text(tag.name),
                      selected: isSelected,
                      selectedColor: accent.withValues(alpha: 0.16),
                      checkmarkColor: accent,
                      side: BorderSide(color: accent.withValues(alpha: 0.35)),
                      onSelected: (bool selected) {
                        setState(() {
                          if (selected) {
                            _selectedTagIds.add(tag.id);
                          } else {
                            _selectedTagIds.remove(tag.id);
                          }
                        });
                      },
                    );
                  })
                  .toList(growable: false),
            ),
          ),
        ],
      ],
    );
  }

  void _submit() {
    if (_selectedEmotion == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(S.current.emotion_select_error)));
      return;
    }
    context.read<EmotionCubit>().createEntry(
      CreateEmotionEntryInput(
        emotionTypeId: _selectedEmotion!.id,
        intensity: _intensity.round(),
        loggedAt: DateTime.now(),
        note: _noteController.text,
        contextPlace: _placeController.text,
        contextActivity: _activityController.text,
        contextPeople: _peopleController.text,
        tagIds: _selectedTagIds.toList(growable: false),
      ),
    );
  }

  Color _colorFromHex(String? hex) {
    if (hex == null || hex.isEmpty) {
      return AppColors.primary;
    }
    return Color(int.parse('FF${hex.replaceFirst('#', '')}', radix: 16));
  }

  IconData _iconForEmotion(EmotionTypeOption type) {
    final String value =
        '${type.iconKey ?? ''} ${type.name.toLowerCase()} ${type.nameEs?.toLowerCase() ?? ''}';
    if (value.contains('joy') ||
        value.contains('happy') ||
        value.contains('fel')) {
      return Icons.wb_sunny_outlined;
    }
    if (value.contains('sad') || value.contains('tri')) {
      return Icons.cloudy_snowing;
    }
    if (value.contains('ang') ||
        value.contains('rage') ||
        value.contains('eno')) {
      return Icons.local_fire_department_outlined;
    }
    if (value.contains('calm') || value.contains('peace')) {
      return Icons.self_improvement_outlined;
    }
    return Icons.mood_outlined;
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.title, required this.child});

  final String title;
  final Widget child;

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
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }
}

class _AppField extends StatelessWidget {
  const _AppField({
    required this.controller,
    required this.label,
    required this.hint,
    required this.icon,
  });

  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon),
        border: const OutlineInputBorder(),
      ),
    );
  }
}
