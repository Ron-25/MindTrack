import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mind_track/app/generated/l10n.dart';
import 'package:mind_track/app/theme/mt_colors.dart';
import 'package:mind_track/app/theme/app_colors.dart';
import 'package:mind_track/features/habits/domain/entities/habit_tracker.dart';

enum _FrequencyMode { daily, weekly, custom }

class _CategoryOption {
  const _CategoryOption({required this.key, required this.icon});

  final String key;
  final IconData icon;
}

List<_CategoryOption> _categoryOptions = <_CategoryOption>[
  _CategoryOption(key: 'health', icon: Icons.favorite_border_rounded),
  _CategoryOption(key: 'mind', icon: Icons.self_improvement_rounded),
  _CategoryOption(key: 'social', icon: Icons.groups_outlined),
  _CategoryOption(key: 'productivity', icon: Icons.work_outline_rounded),
  _CategoryOption(key: 'other', icon: Icons.star_border_rounded),
];

/// Formulario de creación/edición de hábito con el diseño "Add New Habit"
/// de Figma. Devuelve un [CreateHabitInput] mediante `Navigator.pop` al
/// confirmar; si [habit] no es nulo, el formulario se precarga para editarlo.
class AddHabitPage extends StatefulWidget {
  const AddHabitPage({super.key, this.habit});

  final HabitTracker? habit;

  @override
  State<AddHabitPage> createState() => _AddHabitPageState();
}

class _AddHabitPageState extends State<AddHabitPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String _category = _categoryOptions.first.key;
  _FrequencyMode _frequencyMode = _FrequencyMode.daily;
  final List<bool> _selectedDays = List<bool>.filled(7, true);
  String? _nameError;
  String? _daysError;

  bool get _isEditing => widget.habit != null;

  @override
  void initState() {
    super.initState();
    final HabitTracker? habit = widget.habit;
    if (habit == null) {
      return;
    }
    _nameController.text = habit.name;
    _descriptionController.text = habit.description ?? '';
    if (_categoryOptions.any(
      (_CategoryOption option) => option.key == habit.category,
    )) {
      _category = habit.category!;
    }
    final int days = habit.targetDaysWeek.clamp(1, 7);
    for (int i = 0; i < 7; i++) {
      _selectedDays[i] = i < days;
    }
    _frequencyMode = days == 7 ? _FrequencyMode.daily : _FrequencyMode.custom;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final S translations = S.of(context);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(
            Icons.arrow_back_rounded,
            color: context.mtColors.textPrimary,
          ),
        ),
        title: Text(
          _isEditing
              ? translations.habits_edit_title
              : translations.habits_create_title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.27,
            color: context.mtColors.textPrimary,
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: _submit,
              icon: Icon(Icons.check_circle_outline_rounded, size: 20),
              label: Text(
                _isEditing
                    ? translations.habits_save_changes
                    : translations.habits_create_button,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildLabel(translations.habits_name_label),
              SizedBox(height: 8),
              _buildTextInput(
                controller: _nameController,
                hint: translations.habits_name_hint,
                errorText: _nameError,
              ),
              SizedBox(height: 24),
              _buildLabel(translations.habits_description_label),
              SizedBox(height: 8),
              _buildTextInput(
                controller: _descriptionController,
                hint: '',
              ),
              SizedBox(height: 24),
              _buildLabel(translations.habits_icon_label),
              SizedBox(height: 12),
              _buildCategoryGrid(translations),
              SizedBox(height: 24),
              _buildLabel(translations.habits_frequency_label),
              SizedBox(height: 12),
              _buildFrequencySegments(translations),
              SizedBox(height: 12),
              _buildDayCircles(context),
              if (_daysError != null) ...<Widget>[
                SizedBox(height: 8),
                Text(
                  _daysError!,
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFFEF4444),
                  ),
                ),
              ],
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.24,
        color: context.mtColors.textPrimary,
      ),
    );
  }

  Widget _buildTextInput({
    required TextEditingController controller,
    required String hint,
    String? errorText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          height: 56,
          decoration: BoxDecoration(
            color: context.mtColors.card,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: errorText != null
                  ? Color(0xFFEF4444)
                  : context.mtColors.border,
            ),
          ),
          alignment: Alignment.centerLeft,
          child: TextField(
            controller: controller,
            style: TextStyle(fontSize: 16, color: context.mtColors.textPrimary),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                fontSize: 16,
                color: context.mtColors.textMuted,
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 17,
              ),
            ),
          ),
        ),
        if (errorText != null) ...<Widget>[
          SizedBox(height: 6),
          Text(
            errorText,
            style: TextStyle(fontSize: 12, color: Color(0xFFEF4444)),
          ),
        ],
      ],
    );
  }

  Widget _buildCategoryGrid(S translations) {
    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      mainAxisSpacing: 14,
      crossAxisSpacing: 8,
      childAspectRatio: 1.24,
      children: _categoryOptions.map((_CategoryOption option) {
        final bool isSelected = _category == option.key;
        return GestureDetector(
          onTap: () => setState(() => _category = option.key),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 150),
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.primary.withValues(alpha: 0.05)
                  : Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: isSelected ? AppColors.primary : context.mtColors.border,
                width: isSelected ? 2 : 1,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  option.icon,
                  size: 24,
                  color: isSelected
                      ? AppColors.primary
                      : context.mtColors.textSecondary,
                ),
                SizedBox(height: 8),
                Text(
                  _categoryLabel(translations, option.key),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: isSelected
                        ? context.mtColors.textPrimary
                        : context.mtColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(growable: false),
    );
  }

  Widget _buildFrequencySegments(S translations) {
    final Map<_FrequencyMode, String> labels = <_FrequencyMode, String>{
      _FrequencyMode.daily: translations.habits_frequency_daily,
      _FrequencyMode.weekly: translations.habits_frequency_weekly,
      _FrequencyMode.custom: translations.habits_frequency_custom,
    };

    return Container(
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: context.mtColors.borderSubtle,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: labels.entries.map((
          MapEntry<_FrequencyMode, String> entry,
        ) {
          final bool isSelected = _frequencyMode == entry.key;
          return Expanded(
            child: GestureDetector(
              onTap: () => _selectFrequencyMode(entry.key),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 200),
                padding: EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: isSelected
                      ? <BoxShadow>[
                          BoxShadow(
                            color: Color(0x0D000000),
                            blurRadius: 1,
                            offset: Offset(0, 1),
                          ),
                        ]
                      : null,
                ),
                child: Text(
                  entry.value,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    color: isSelected
                        ? AppColors.primary
                        : context.mtColors.textSecondary,
                  ),
                ),
              ),
            ),
          );
        }).toList(growable: false),
      ),
    );
  }

  Widget _buildDayCircles(BuildContext context) {
    final String locale = Localizations.localeOf(context).languageCode;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List<Widget>.generate(7, (int index) {
        final bool isSelected = _selectedDays[index];
        // Lunes = weekday 1 → 2024-01-01 fue lunes.
        final DateTime weekday = DateTime(2024, 1, 1 + index);
        final String letter = DateFormat.E(
          locale,
        ).format(weekday).substring(0, 1).toUpperCase();
        return GestureDetector(
          onTap: () => _toggleDay(index),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 150),
            width: 36,
            height: 36,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isSelected ? AppColors.primary : Colors.transparent,
              shape: BoxShape.circle,
              border: isSelected
                  ? null
                  : Border.all(color: context.mtColors.border),
            ),
            child: Text(
              letter,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: isSelected ? Colors.white : context.mtColors.textMuted,
              ),
            ),
          ),
        );
      }),
    );
  }

  void _selectFrequencyMode(_FrequencyMode mode) {
    setState(() {
      _frequencyMode = mode;
      _daysError = null;
      switch (mode) {
        case _FrequencyMode.daily:
          _selectedDays.fillRange(0, 7, true);
        case _FrequencyMode.weekly:
          // Lunes a viernes.
          for (int i = 0; i < 7; i++) {
            _selectedDays[i] = i < 5;
          }
        case _FrequencyMode.custom:
          break;
      }
    });
  }

  void _toggleDay(int index) {
    setState(() {
      _selectedDays[index] = !_selectedDays[index];
      _daysError = null;
      final int count = _selectedDays.where((bool day) => day).length;
      _frequencyMode = count == 7
          ? _FrequencyMode.daily
          : _FrequencyMode.custom;
    });
  }

  String _categoryLabel(S translations, String category) {
    switch (category) {
      case 'health':
        return translations.habits_category_health;
      case 'mind':
        return translations.habits_category_mind;
      case 'social':
        return translations.habits_category_social;
      case 'productivity':
        return translations.habits_category_productivity;
      default:
        return translations.habits_category_other;
    }
  }

  void _submit() {
    final S translations = S.of(context);
    final String name = _nameController.text.trim();
    final int days = _selectedDays.where((bool day) => day).length;

    setState(() {
      _nameError = name.isEmpty ? translations.habits_name_error : null;
      _daysError = days == 0 ? translations.habits_days_error : null;
    });
    if (name.isEmpty || days == 0) {
      return;
    }

    Navigator.of(context).pop(
      CreateHabitInput(
        name: name,
        description: _descriptionController.text.trim(),
        category: _category,
        targetDaysWeek: days,
      ),
    );
  }
}
