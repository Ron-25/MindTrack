import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Controla el idioma de la app en caliente. `null` = seguir el idioma
/// del sistema. Se persiste en SharedPreferences y se sincroniza con la
/// preferencia guardada en el backend al cargar el perfil.
class LocaleController extends ValueNotifier<Locale?> {
  LocaleController._() : super(null);

  static final LocaleController instance = LocaleController._();
  static const String _storageKey = 'app_locale';

  Future<void> load() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? stored = prefs.getString(_storageKey);
    if (stored != null && stored.isNotEmpty) {
      value = Locale(stored);
    }
  }

  /// Cambia el idioma inmediatamente y lo persiste. [code] es "es"/"en";
  /// `null` vuelve al idioma del sistema.
  Future<void> setLanguage(String? code) async {
    final String? normalized = code?.trim().toLowerCase();
    final Locale? next = normalized == null || normalized.isEmpty
        ? null
        : Locale(normalized);
    if (next?.languageCode == value?.languageCode) {
      return;
    }
    value = next;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (normalized == null || normalized.isEmpty) {
      await prefs.remove(_storageKey);
    } else {
      await prefs.setString(_storageKey, normalized);
    }
  }
}
