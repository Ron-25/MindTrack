import 'package:equatable/equatable.dart';

class HabitTracker extends Equatable {
  const HabitTracker({
    required this.id,
    required this.name,
    this.description,
    this.iconKey,
    this.colorHex,
    this.category,
    required this.targetDaysWeek,
    required this.completedDays,
    required this.completionPct,
    required this.completedToday,
  });

  final String id;
  final String name;
  final String? description;
  final String? iconKey;
  final String? colorHex;
  final String? category;
  final int targetDaysWeek;
  final int completedDays;
  final double completionPct;
  final bool completedToday;

  @override
  List<Object?> get props => <Object?>[
    id,
    name,
    description,
    iconKey,
    colorHex,
    category,
    targetDaysWeek,
    completedDays,
    completionPct,
    completedToday,
  ];
}

class CreateHabitInput extends Equatable {
  const CreateHabitInput({
    required this.name,
    required this.targetDaysWeek,
    this.description,
    this.category,
  });

  final String name;
  final int targetDaysWeek;
  final String? description;
  final String? category;

  @override
  List<Object?> get props => <Object?>[
    name,
    targetDaysWeek,
    description,
    category,
  ];
}

class UpdateHabitInput extends Equatable {
  const UpdateHabitInput({
    this.name,
    this.description,
    this.category,
    this.targetDaysWeek,
  });

  final String? name;
  final String? description;
  final String? category;
  final int? targetDaysWeek;

  @override
  List<Object?> get props => <Object?>[
    name,
    description,
    category,
    targetDaysWeek,
  ];
}
