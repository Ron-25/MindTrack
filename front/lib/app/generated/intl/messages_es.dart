// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a es locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'es';

  static String m0(terms, privacy) => "Acepto los ${terms} y la ${privacy}.";

  static String m1(count) => "${count} registros";

  static String m2(count) =>
      "Aun tienes ${count} habito(s) pendiente(s) hoy. El mas facil de completar ahora mismo puede darte un pequeño impulso de avance.";

  static String m3(name) =>
      "La emocion mas frecuente recientemente es ${name}. Vale la pena revisar que actividades o personas suelen aparecer junto a ella.";

  static String m4(days) => "Dias por semana: ${days}";

  static String m5(days) => "Meta semanal: ${days} dias";

  static String m6(name) => "Buenos dias, ${name}";

  static String m7(name) => "Buenas tardes, ${name}";

  static String m8(name) => "Buenas noches, ${name}";

  static String m9(name) => "Buenos dias, ${name}";

  static String m10(count, energy) =>
      "Has registrado ${Intl.plural(count, one: '1 entrada', other: '${count} entradas')} hoy. Tu nivel promedio de energia es ${energy}.";

  static String m11(completed, target) =>
      "Aun no marcas este habito hoy. Llevas ${completed}/${target} esta semana.";

  static String m12(name) => "Pendiente: ${name}";

  static String m13(step, total) =>
      "Paso ${step} de ${total} • Conciencia Emocional";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "accept_terms": m0,
    "accept_terms_error": MessageLookupByLibrary.simpleMessage(
      "Debes aceptar los terminos para continuar.",
    ),
    "already_have_account": MessageLookupByLibrary.simpleMessage(
      "¿Ya tienes una cuenta? ",
    ),
    "analytics_correlation_empty": MessageLookupByLibrary.simpleMessage(
      "Todavia no hay suficientes datos para relacionar habitos y estado de animo.",
    ),
    "analytics_default_insight": MessageLookupByLibrary.simpleMessage(
      "Sigue registrando emociones y habitos para descubrir patrones.",
    ),
    "analytics_frequency_empty": MessageLookupByLibrary.simpleMessage(
      "Todavia no hay suficientes registros para calcular frecuencia.",
    ),
    "analytics_frequency_title": MessageLookupByLibrary.simpleMessage(
      "Frecuencia emocional",
    ),
    "analytics_habits_mood_title": MessageLookupByLibrary.simpleMessage(
      "Habitos vs animo",
    ),
    "analytics_metric_habits": MessageLookupByLibrary.simpleMessage("Habitos"),
    "analytics_metric_intensity": MessageLookupByLibrary.simpleMessage(
      "Intensidad",
    ),
    "analytics_metric_logs": MessageLookupByLibrary.simpleMessage("Registros"),
    "analytics_no_dominant_emotion": MessageLookupByLibrary.simpleMessage(
      "Sin emocion dominante aun",
    ),
    "analytics_records_count": m1,
    "analytics_title": MessageLookupByLibrary.simpleMessage("Analiticas"),
    "analytics_view_habits": MessageLookupByLibrary.simpleMessage(
      "Ver habitos",
    ),
    "analytics_weekly_summary_title": MessageLookupByLibrary.simpleMessage(
      "Resumen semanal",
    ),
    "auth_error_description": MessageLookupByLibrary.simpleMessage(
      "No se pudo completar la autenticacion.",
    ),
    "auth_error_title": MessageLookupByLibrary.simpleMessage("Error"),
    "auth_login_success_toast": MessageLookupByLibrary.simpleMessage(
      "Sesion iniciada correctamente.",
    ),
    "auth_signup_success_toast": MessageLookupByLibrary.simpleMessage(
      "Registro completado correctamente.",
    ),
    "auth_success_title": MessageLookupByLibrary.simpleMessage("Exito"),
    "back": MessageLookupByLibrary.simpleMessage("Atrás"),
    "begin_your_journey": MessageLookupByLibrary.simpleMessage(
      "Comienza tu viaje",
    ),
    "coach_hero_description": MessageLookupByLibrary.simpleMessage(
      "Sugerencias accionables basadas en tu actividad reciente.",
    ),
    "coach_hero_label": MessageLookupByLibrary.simpleMessage("Coach IA"),
    "coach_insight_balanced": MessageLookupByLibrary.simpleMessage(
      "Tus metricas se ven equilibradas. Mantén el ritmo y revisa tus habitos mas consistentes para reforzar lo que ya te funciona.",
    ),
    "coach_insight_high_intensity": MessageLookupByLibrary.simpleMessage(
      "Tu intensidad emocional promedio viene alta. Considera una pausa breve hoy: respiracion guiada, caminata corta o journaling.",
    ),
    "coach_insight_low_habits": MessageLookupByLibrary.simpleMessage(
      "Tu constancia en habitos esta por debajo del 50%. Enfocate en completar solo un habito clave hoy para recuperar traccion.",
    ),
    "coach_insight_low_logs": MessageLookupByLibrary.simpleMessage(
      "Esta semana todavia hay pocos registros. Intenta anotar al menos una emocion por la mañana y otra por la noche para mejorar tus patrones.",
    ),
    "coach_insight_pending_habits": m2,
    "coach_insight_top_emotion": m3,
    "coach_stat_habits": MessageLookupByLibrary.simpleMessage("Habitos"),
    "coach_stat_intensity": MessageLookupByLibrary.simpleMessage("Intensidad"),
    "coach_stat_logs": MessageLookupByLibrary.simpleMessage("Registros"),
    "coach_title": MessageLookupByLibrary.simpleMessage("MindTrack Coach"),
    "continue_with_google": MessageLookupByLibrary.simpleMessage(
      "Continuar con Google",
    ),
    "create_account": MessageLookupByLibrary.simpleMessage("Crear cuenta"),
    "create_my_account": MessageLookupByLibrary.simpleMessage(
      "Crear mi cuenta",
    ),
    "dont_have_account": MessageLookupByLibrary.simpleMessage(
      "¿No tienes una cuenta? ",
    ),
    "email_address": MessageLookupByLibrary.simpleMessage("Correo electrónico"),
    "email_invalid_error": MessageLookupByLibrary.simpleMessage(
      "Ingresa un correo valido con @",
    ),
    "email_required_error": MessageLookupByLibrary.simpleMessage(
      "El correo es requerido",
    ),
    "error_title": MessageLookupByLibrary.simpleMessage("Error"),
    "forgot_password": MessageLookupByLibrary.simpleMessage(
      "¿Olvidaste tu contraseña?",
    ),
    "full_name": MessageLookupByLibrary.simpleMessage("Nombre completo"),
    "full_name_hint": MessageLookupByLibrary.simpleMessage("Juan Pérez"),
    "full_name_required_error": MessageLookupByLibrary.simpleMessage(
      "El nombre es requerido",
    ),
    "get_started": MessageLookupByLibrary.simpleMessage("Comenzar"),
    "habits_category_label": MessageLookupByLibrary.simpleMessage("Categoria"),
    "habits_create_title": MessageLookupByLibrary.simpleMessage("Crear habito"),
    "habits_days_per_week": m4,
    "habits_description_label": MessageLookupByLibrary.simpleMessage(
      "Descripcion",
    ),
    "habits_empty_description": MessageLookupByLibrary.simpleMessage(
      "Crea uno para empezar a medir constancia y su relacion con tu animo.",
    ),
    "habits_empty_title": MessageLookupByLibrary.simpleMessage(
      "Aun no tienes habitos activos.",
    ),
    "habits_name_error": MessageLookupByLibrary.simpleMessage(
      "Ingresa un nombre.",
    ),
    "habits_name_label": MessageLookupByLibrary.simpleMessage("Nombre"),
    "habits_new_button": MessageLookupByLibrary.simpleMessage("Nuevo habito"),
    "habits_save": MessageLookupByLibrary.simpleMessage("Guardar"),
    "habits_title": MessageLookupByLibrary.simpleMessage("Habitos"),
    "habits_weekly_target": m5,
    "home_daily_habits_title": MessageLookupByLibrary.simpleMessage(
      "Habitos diarios",
    ),
    "home_empty_entries_message": MessageLookupByLibrary.simpleMessage(
      "Aun no hay emociones registradas.",
    ),
    "home_empty_habits_message": MessageLookupByLibrary.simpleMessage(
      "Aun no tienes habitos activos.",
    ),
    "home_energy_balanced": MessageLookupByLibrary.simpleMessage("equilibrado"),
    "home_energy_high": MessageLookupByLibrary.simpleMessage("alto"),
    "home_energy_low": MessageLookupByLibrary.simpleMessage("bajo"),
    "home_entry_no_note": MessageLookupByLibrary.simpleMessage(
      "Sin nota adicional.",
    ),
    "home_entry_yesterday": MessageLookupByLibrary.simpleMessage("Ayer"),
    "home_greeting": m6,
    "home_greeting_afternoon": m7,
    "home_greeting_evening": m8,
    "home_greeting_morning": m9,
    "home_log_emotion_button": MessageLookupByLibrary.simpleMessage(
      "Registrar mi emocion actual",
    ),
    "home_logout_success": MessageLookupByLibrary.simpleMessage(
      "Sesion cerrada correctamente.",
    ),
    "home_logout_tooltip": MessageLookupByLibrary.simpleMessage(
      "Cerrar sesion",
    ),
    "home_manager_ai": MessageLookupByLibrary.simpleMessage("Manager IA"),
    "home_mood_primary_description": MessageLookupByLibrary.simpleMessage(
      "Has registrado 3 entradas hoy. Tu nivel promedio de energia es alto.",
    ),
    "home_mood_primary_title": MessageLookupByLibrary.simpleMessage(
      "Principalmente positivo",
    ),
    "home_mood_status_stable": MessageLookupByLibrary.simpleMessage("ESTABLE"),
    "home_nav_analytics": MessageLookupByLibrary.simpleMessage("ANALITICAS"),
    "home_nav_habits": MessageLookupByLibrary.simpleMessage("HABITOS"),
    "home_nav_history": MessageLookupByLibrary.simpleMessage("HISTORIAL"),
    "home_nav_home": MessageLookupByLibrary.simpleMessage("INICIO"),
    "home_nav_profile": MessageLookupByLibrary.simpleMessage("PERFIL"),
    "home_recent_entries_title": MessageLookupByLibrary.simpleMessage(
      "Entradas recientes",
    ),
    "home_retry": MessageLookupByLibrary.simpleMessage("Reintentar"),
    "home_section_soon_description": MessageLookupByLibrary.simpleMessage(
      "Esta seccion estara disponible pronto.",
    ),
    "home_see_all": MessageLookupByLibrary.simpleMessage("Ver todo"),
    "home_status_elevated": MessageLookupByLibrary.simpleMessage("ALTO"),
    "home_status_gentle": MessageLookupByLibrary.simpleMessage("SUAVE"),
    "home_status_new_day": MessageLookupByLibrary.simpleMessage("NUEVO DIA"),
    "home_subtitle_default": MessageLookupByLibrary.simpleMessage(
      "Como te sientes en este momento?",
    ),
    "home_subtitle_logged_in": MessageLookupByLibrary.simpleMessage(
      "Bienvenido de nuevo!",
    ),
    "home_subtitle_signed_up": MessageLookupByLibrary.simpleMessage(
      "Cuenta creada correctamente.",
    ),
    "home_today_empty_description": MessageLookupByLibrary.simpleMessage(
      "Empieza registrando como te sientes para construir tu tendencia diaria.",
    ),
    "home_today_empty_title": MessageLookupByLibrary.simpleMessage(
      "Aun no hay entradas",
    ),
    "home_today_entries_description": m10,
    "home_today_mood_title": MessageLookupByLibrary.simpleMessage(
      "Estado de animo de hoy",
    ),
    "home_view_detailed_analysis": MessageLookupByLibrary.simpleMessage(
      "Ver analisis detallado",
    ),
    "home_weekday_fri": MessageLookupByLibrary.simpleMessage("VIE"),
    "home_weekday_mon": MessageLookupByLibrary.simpleMessage("LUN"),
    "home_weekday_sat": MessageLookupByLibrary.simpleMessage("SAB"),
    "home_weekday_sun": MessageLookupByLibrary.simpleMessage("DOM"),
    "home_weekday_thu": MessageLookupByLibrary.simpleMessage("JUE"),
    "home_weekday_tue": MessageLookupByLibrary.simpleMessage("MAR"),
    "home_weekday_wed": MessageLookupByLibrary.simpleMessage("MIE"),
    "home_weekly_overview_title": MessageLookupByLibrary.simpleMessage(
      "Resumen semanal",
    ),
    "home_weekly_quote": MessageLookupByLibrary.simpleMessage(
      "\"Tu estado de animo mejora durante el fin de semana. Intenta identificar por que!\"",
    ),
    "log_in": MessageLookupByLibrary.simpleMessage("Iniciar sesión"),
    "login_subtitle": MessageLookupByLibrary.simpleMessage(
      "Inicia sesión para continuar tu camino hacia el bienestar emocional.",
    ),
    "next": MessageLookupByLibrary.simpleMessage("Siguiente"),
    "notifications_active_description": MessageLookupByLibrary.simpleMessage(
      "Tus recordatorios estan habilitados desde preferencias.",
    ),
    "notifications_active_title": MessageLookupByLibrary.simpleMessage(
      "Recordatorios activos",
    ),
    "notifications_habits_clear_description":
        MessageLookupByLibrary.simpleMessage(
          "No tienes habitos pendientes para hoy o ya completaste todos.",
        ),
    "notifications_habits_clear_title": MessageLookupByLibrary.simpleMessage(
      "Todo en orden con tus habitos",
    ),
    "notifications_inactive_description": MessageLookupByLibrary.simpleMessage(
      "Activa las notificaciones en tu perfil para recibir recordatorios.",
    ),
    "notifications_inactive_title": MessageLookupByLibrary.simpleMessage(
      "Recordatorios desactivados",
    ),
    "notifications_mood_logged_description":
        MessageLookupByLibrary.simpleMessage(
          "Ya registraste al menos una emocion hoy. Buen trabajo.",
        ),
    "notifications_mood_logged_title": MessageLookupByLibrary.simpleMessage(
      "Estado emocional al dia",
    ),
    "notifications_mood_missing_description":
        MessageLookupByLibrary.simpleMessage(
          "Registrar una emocion hoy ayuda a mejorar tus insights semanales.",
        ),
    "notifications_mood_missing_title": MessageLookupByLibrary.simpleMessage(
      "Te falta registrar como te sientes hoy",
    ),
    "notifications_pending_description": m11,
    "notifications_pending_title": m12,
    "notifications_title": MessageLookupByLibrary.simpleMessage(
      "Notificaciones",
    ),
    "onboarding_desc_1": MessageLookupByLibrary.simpleMessage(
      "Tómate un momento cada día para reflexionar sobre cómo te sientes. Registrar tu estado de ánimo te ayuda a desarrollar una mayor autoconciencia.",
    ),
    "onboarding_desc_2": MessageLookupByLibrary.simpleMessage(
      "Descubre información profunda sobre cómo tus actividades y hábitos influyen en tu estado de ánimo con el tiempo.",
    ),
    "onboarding_desc_3": MessageLookupByLibrary.simpleMessage(
      "Conecta tus rutinas diarias con tu bienestar emocional. Comienza tu camino hacia una vida más equilibrada.",
    ),
    "onboarding_step": m13,
    "onboarding_title_1": MessageLookupByLibrary.simpleMessage(
      "Registra tus emociones diarias",
    ),
    "onboarding_title_2": MessageLookupByLibrary.simpleMessage(
      "Descubre patrones emocionales",
    ),
    "onboarding_title_3": MessageLookupByLibrary.simpleMessage(
      "Construye hábitos saludables y autoconciencia",
    ),
    "or_continue_with": MessageLookupByLibrary.simpleMessage("O CONTINUAR CON"),
    "or_join_with": MessageLookupByLibrary.simpleMessage("O únete con"),
    "password": MessageLookupByLibrary.simpleMessage("Contraseña"),
    "password_lowercase_error": MessageLookupByLibrary.simpleMessage(
      "Debe contener al menos una minuscula",
    ),
    "password_min_length_error": MessageLookupByLibrary.simpleMessage(
      "Minimo 8 caracteres",
    ),
    "password_number_error": MessageLookupByLibrary.simpleMessage(
      "Debe contener al menos un numero",
    ),
    "password_required_error": MessageLookupByLibrary.simpleMessage(
      "La contraseña es requerida",
    ),
    "password_special_char_error": MessageLookupByLibrary.simpleMessage(
      "Debe contener un caracter especial",
    ),
    "password_uppercase_error": MessageLookupByLibrary.simpleMessage(
      "Debe contener al menos una mayuscula",
    ),
    "privacy_policy": MessageLookupByLibrary.simpleMessage(
      "Política de privacidad",
    ),
    "profile_account_settings": MessageLookupByLibrary.simpleMessage(
      "AJUSTES DE LA CUENTA",
    ),
    "profile_footer_caption": MessageLookupByLibrary.simpleMessage(
      "MindTrack v2.4.0 • Hecho con mindfulness",
    ),
    "profile_intent_android_only": MessageLookupByLibrary.simpleMessage(
      "Esta opcion esta disponible en los ajustes de Android.",
    ),
    "profile_intent_link_unavailable": MessageLookupByLibrary.simpleMessage(
      "No hubo una app disponible para abrir este enlace.",
    ),
    "profile_language": MessageLookupByLibrary.simpleMessage("Idioma"),
    "profile_language_english": MessageLookupByLibrary.simpleMessage("Ingles"),
    "profile_language_spanish": MessageLookupByLibrary.simpleMessage("Español"),
    "profile_logout": MessageLookupByLibrary.simpleMessage("Cerrar sesion"),
    "profile_notification_settings": MessageLookupByLibrary.simpleMessage(
      "Configuracion de notificaciones",
    ),
    "profile_preferences": MessageLookupByLibrary.simpleMessage("Preferencias"),
    "profile_privacy_security": MessageLookupByLibrary.simpleMessage(
      "Privacidad y seguridad",
    ),
    "profile_title": MessageLookupByLibrary.simpleMessage("Perfil"),
    "search_emotions_empty": MessageLookupByLibrary.simpleMessage(
      "No se encontraron emociones que coincidan.",
    ),
    "search_emotions_title": MessageLookupByLibrary.simpleMessage("Emociones"),
    "search_habits_empty": MessageLookupByLibrary.simpleMessage(
      "No se encontraron habitos que coincidan.",
    ),
    "search_habits_title": MessageLookupByLibrary.simpleMessage("Habitos"),
    "search_hint": MessageLookupByLibrary.simpleMessage(
      "Busca emociones, notas o habitos",
    ),
    "search_no_detail": MessageLookupByLibrary.simpleMessage("Sin detalle"),
    "search_title": MessageLookupByLibrary.simpleMessage("Buscar"),
    "sign_in": MessageLookupByLibrary.simpleMessage("Iniciar sesión"),
    "sign_in_button": MessageLookupByLibrary.simpleMessage("Iniciar sesión"),
    "sign_up": MessageLookupByLibrary.simpleMessage("Regístrate"),
    "signup_subtitle": MessageLookupByLibrary.simpleMessage(
      "Únete a miles de personas que rastrean su camino hacia el bienestar emocional.",
    ),
    "skip": MessageLookupByLibrary.simpleMessage("Saltar"),
    "splash_message": MessageLookupByLibrary.simpleMessage(
      "Un espacio tranquilo para rastrear tus emociones y descubrir patrones para una mente más saludable.",
    ),
    "splash_message_part2": MessageLookupByLibrary.simpleMessage(
      "La conciencia emocional es el primer paso hacia el bienestar mental.",
    ),
    "start_journey": MessageLookupByLibrary.simpleMessage(
      "Toca para comenzar el viaje",
    ),
    "terms_of_service": MessageLookupByLibrary.simpleMessage(
      "Términos de servicio",
    ),
    "title": MessageLookupByLibrary.simpleMessage("MindTrack"),
    "title_splash": MessageLookupByLibrary.simpleMessage("Encuentra tu calma"),
  };
}
