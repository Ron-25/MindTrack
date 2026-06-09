import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mind_track/app/injector.dart';
import 'package:mind_track/app/theme/app_colors.dart';
import 'package:mind_track/features/daily_mood/domain/entities/daily_mood.dart';
import 'package:mind_track/features/daily_mood/presentation/viewmodel/daily_mood_state.dart';
import 'package:mind_track/features/daily_mood/presentation/viewmodel/daily_mood_viewmodel.dart';

// VIEW en MVVM: solo renderiza el estado, delega acciones al ViewModel.
class DailyMoodPage extends StatelessWidget {
  const DailyMoodPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DailyMoodViewModel>(
      create: (_) => Injector.get<DailyMoodViewModel>(),
      child: const _DailyMoodView(),
    );
  }
}

class _DailyMoodView extends StatelessWidget {
  const _DailyMoodView();

  static const List<String> _moodOptions = <String>[
    'Feliz',
    'Calmado',
    'Neutral',
    'Ansioso',
    'Triste',
  ];

  static const Map<String, IconData> _moodIcons = <String, IconData>{
    'Feliz': Icons.sentiment_very_satisfied,
    'Calmado': Icons.self_improvement,
    'Neutral': Icons.sentiment_neutral,
    'Ansioso': Icons.sentiment_dissatisfied,
    'Triste': Icons.sentiment_very_dissatisfied,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Estado de ánimo'),
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
      body: BlocBuilder<DailyMoodViewModel, DailyMoodState>(
        builder: (BuildContext context, DailyMoodState state) {
          if (state.status == DailyMoodStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.status == DailyMoodStatus.failure) {
            return Center(child: Text(state.error ?? 'Error inesperado'));
          }

          if (state.entries.isEmpty) {
            return const Center(
              child: Text(
                'Sin registros.\nPresiona + para agregar.',
                textAlign: TextAlign.center,
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: state.entries.length,
            separatorBuilder: (_, _) => const SizedBox(height: 8),
            itemBuilder: (BuildContext context, int index) {
              final DailyMoodEntry entry = state.entries[index];
              return _MoodCard(entry: entry);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddSheet(context),
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  void _showAddSheet(BuildContext context) {
    final DailyMoodViewModel vm = context.read<DailyMoodViewModel>();
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.card,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => _AddMoodSheet(
        moodOptions: _moodOptions,
        moodIcons: _moodIcons,
        onSubmit: (DailyMoodEntry entry) {
          vm.add(entry);
          Navigator.of(context).pop();
        },
      ),
    );
  }
}

class _MoodCard extends StatelessWidget {
  const _MoodCard({required this.entry});

  final DailyMoodEntry entry;

  static const Map<String, IconData> _icons = <String, IconData>{
    'Feliz': Icons.sentiment_very_satisfied,
    'Calmado': Icons.self_improvement,
    'Neutral': Icons.sentiment_neutral,
    'Ansioso': Icons.sentiment_dissatisfied,
    'Triste': Icons.sentiment_very_dissatisfied,
  };

  @override
  Widget build(BuildContext context) {
    final DailyMoodViewModel vm = context.read<DailyMoodViewModel>();

    return Dismissible(
      key: Key(entry.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: Colors.redAccent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(Icons.delete_outline, color: Colors.white),
      ),
      onDismissed: (_) => vm.remove(entry.id),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: <Widget>[
            Icon(
              _icons[entry.mood] ?? Icons.mood,
              size: 32,
              color: AppColors.primary,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    entry.mood,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  if (entry.note.isNotEmpty)
                    Text(
                      entry.note,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Text(
              _formatDate(entry.createdAt),
              style: const TextStyle(fontSize: 11, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime dt) {
    return '${dt.day.toString().padLeft(2, '0')}/'
        '${dt.month.toString().padLeft(2, '0')} '
        '${dt.hour.toString().padLeft(2, '0')}:'
        '${dt.minute.toString().padLeft(2, '0')}';
  }
}

class _AddMoodSheet extends StatefulWidget {
  const _AddMoodSheet({
    required this.moodOptions,
    required this.moodIcons,
    required this.onSubmit,
  });

  final List<String> moodOptions;
  final Map<String, IconData> moodIcons;
  final void Function(DailyMoodEntry) onSubmit;

  @override
  State<_AddMoodSheet> createState() => _AddMoodSheetState();
}

class _AddMoodSheetState extends State<_AddMoodSheet> {
  late String _selectedMood;
  final TextEditingController _noteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedMood = widget.moodOptions.first;
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        24,
        24,
        24,
        MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            '¿Cómo te sientes?',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            children: widget.moodOptions.map((String m) {
              final bool selected = m == _selectedMood;
              return ChoiceChip(
                avatar: Icon(widget.moodIcons[m], size: 18),
                label: Text(m),
                selected: selected,
                onSelected: (_) => setState(() => _selectedMood = m),
                selectedColor: AppColors.primary.withValues(alpha: 0.2),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _noteController,
            maxLines: 2,
            decoration: const InputDecoration(
              hintText: 'Nota (opcional)',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _submit,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text(
                'Guardar',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _submit() {
    final DateTime now = DateTime.now();
    widget.onSubmit(
      DailyMoodEntry(
        id: now.microsecondsSinceEpoch.toString(),
        mood: _selectedMood,
        note: _noteController.text.trim(),
        createdAt: now,
      ),
    );
  }
}
