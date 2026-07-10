import 'package:equatable/equatable.dart';

class EmotionTypeOption extends Equatable {
  const EmotionTypeOption({
    required this.id,
    required this.name,
    this.nameEs,
    required this.colorHex,
    this.iconKey,
  });

  final String id;
  final String name;
  final String? nameEs;
  final String colorHex;
  final String? iconKey;

  String localizedName(String languageCode) {
    if (languageCode.toLowerCase().startsWith('es') &&
        nameEs != null &&
        nameEs!.trim().isNotEmpty) {
      return nameEs!;
    }
    return name;
  }

  @override
  List<Object?> get props => <Object?>[id, name, nameEs, colorHex, iconKey];
}

class EmotionTag extends Equatable {
  const EmotionTag({required this.id, required this.name, this.colorHex});

  final String id;
  final String name;
  final String? colorHex;

  @override
  List<Object?> get props => <Object?>[id, name, colorHex];
}

class EmotionEntry extends Equatable {
  const EmotionEntry({
    required this.id,
    required this.emotionTypeId,
    required this.emotionName,
    this.emotionNameEs,
    required this.intensity,
    this.note,
    this.contextPlace,
    this.contextActivity,
    this.contextPeople,
    required this.tags,
    required this.loggedAt,
    required this.createdAt,
    this.colorHex,
    this.iconKey,
  });

  final String id;
  final String emotionTypeId;
  final String emotionName;
  final String? emotionNameEs;
  final int intensity;
  final String? note;
  final String? contextPlace;
  final String? contextActivity;
  final String? contextPeople;
  final List<EmotionTag> tags;
  final DateTime loggedAt;
  final DateTime createdAt;
  final String? colorHex;
  final String? iconKey;

  String localizedName(String languageCode) {
    if (languageCode.toLowerCase().startsWith('es') &&
        emotionNameEs != null &&
        emotionNameEs!.trim().isNotEmpty) {
      return emotionNameEs!;
    }
    return emotionName;
  }

  @override
  List<Object?> get props => <Object?>[
    id,
    emotionTypeId,
    emotionName,
    emotionNameEs,
    intensity,
    note,
    contextPlace,
    contextActivity,
    contextPeople,
    tags,
    loggedAt,
    createdAt,
    colorHex,
    iconKey,
  ];
}

class CreateEmotionEntryInput extends Equatable {
  const CreateEmotionEntryInput({
    required this.emotionTypeId,
    required this.intensity,
    required this.loggedAt,
    this.note,
    this.contextPlace,
    this.contextActivity,
    this.contextPeople,
    this.tagIds = const <String>[],
  });

  final String emotionTypeId;
  final int intensity;
  final DateTime loggedAt;
  final String? note;
  final String? contextPlace;
  final String? contextActivity;
  final String? contextPeople;
  final List<String> tagIds;

  @override
  List<Object?> get props => <Object?>[
    emotionTypeId,
    intensity,
    loggedAt,
    note,
    contextPlace,
    contextActivity,
    contextPeople,
    tagIds,
  ];
}

class UpdateEmotionEntryInput extends Equatable {
  const UpdateEmotionEntryInput({this.intensity, this.note, this.tagIds});

  final int? intensity;
  final String? note;
  final List<String>? tagIds;

  @override
  List<Object?> get props => <Object?>[intensity, note, tagIds];
}
