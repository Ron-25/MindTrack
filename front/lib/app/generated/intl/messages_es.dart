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

  static String m1(pct) => "${pct}% completados";

  static String m2(count) => "${count} registros";

  static String m3(day) => "Mejor animo el ${day}";

  static String m4(count) =>
      "Aun tienes ${count} habito(s) pendiente(s) hoy. El mas facil de completar ahora mismo puede darte un pequeño impulso de avance.";

  static String m5(name) =>
      "La emocion mas frecuente recientemente es ${name}. Vale la pena revisar que actividades o personas suelen aparecer junto a ella.";

  static String m6(value) => "Actividad: ${value}";

  static String m7(value) => "Intensidad: ${value}/10";

  static String m8(value) => "Intensidad ${value}/10";

  static String m9(value) => "Personas: ${value}";

  static String m10(value) => "Lugar: ${value}";

  static String m11(completed, total) =>
      "¡Has completado ${completed} de ${total} habitos hoy!";

  static String m12(days) => "Dias por semana: ${days}";

  static String m13(days) => "Meta semanal: ${days} dias";

  static String m14(count) => "${count} resultado(s)";

  static String m15(name) => "Buenos dias, ${name}";

  static String m16(name) => "Buenas tardes, ${name}";

  static String m17(name) => "Buenas noches, ${name}";

  static String m18(name) => "Buenos dias, ${name}";

  static String m19(count) => "Mejor racha: ${count} dia(s)";

  static String m20(count) => "Racha: ${count} dia(s)";

  static String m21(count, energy) =>
      "Has registrado ${Intl.plural(count, one: '1 entrada', other: '${count} entradas')} hoy. Tu nivel promedio de energia es ${energy}.";

  static String m22(completed, target) =>
      "Aun no marcas este habito hoy. Llevas ${completed}/${target} esta semana.";

  static String m23(name) => "Pendiente: ${name}";

  static String m24(time) => "Recordatorio diario · ${time}";

  static String m25(step, total) =>
      "Paso ${step} de ${total} • Conciencia Emocional";

  static String m26(time) => "Diario · ${time}";

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
    "analytics_distribution_title": MessageLookupByLibrary.simpleMessage(
      "Distribucion de animo",
    ),
    "analytics_frequency_empty": MessageLookupByLibrary.simpleMessage(
      "Todavia no hay suficientes registros para calcular frecuencia.",
    ),
    "analytics_frequency_title": MessageLookupByLibrary.simpleMessage(
      "Frecuencia emocional",
    ),
    "analytics_habits_card_label": MessageLookupByLibrary.simpleMessage(
      "Habitos",
    ),
    "analytics_habits_card_value": m1,
    "analytics_habits_mood_title": MessageLookupByLibrary.simpleMessage(
      "Habitos vs animo",
    ),
    "analytics_insight_title": MessageLookupByLibrary.simpleMessage(
      "Insight semanal",
    ),
    "analytics_metric_habits": MessageLookupByLibrary.simpleMessage("Habitos"),
    "analytics_metric_intensity": MessageLookupByLibrary.simpleMessage(
      "Intensidad",
    ),
    "analytics_metric_logs": MessageLookupByLibrary.simpleMessage("Registros"),
    "analytics_mood_flow_caption": MessageLookupByLibrary.simpleMessage(
      "Intensidad emocional promedio por dia (escala 1-10)",
    ),
    "analytics_mood_flow_fallback_caption": MessageLookupByLibrary.simpleMessage(
      "Sin registros de intensidad esta semana. Mostrando habitos completados por dia.",
    ),
    "analytics_mood_flow_label": MessageLookupByLibrary.simpleMessage(
      "Flujo de animo semanal",
    ),
    "analytics_no_data_short": MessageLookupByLibrary.simpleMessage(
      "Datos insuficientes",
    ),
    "analytics_no_dominant_emotion": MessageLookupByLibrary.simpleMessage(
      "Sin emocion dominante aun",
    ),
    "analytics_patterns_title": MessageLookupByLibrary.simpleMessage(
      "Patrones y observaciones",
    ),
    "analytics_range_month": MessageLookupByLibrary.simpleMessage("Mes"),
    "analytics_range_week": MessageLookupByLibrary.simpleMessage("Semana"),
    "analytics_range_year": MessageLookupByLibrary.simpleMessage("Año"),
    "analytics_read_more": MessageLookupByLibrary.simpleMessage(
      "Ver mas insights",
    ),
    "analytics_records_count": m2,
    "analytics_title": MessageLookupByLibrary.simpleMessage("Analiticas"),
    "analytics_top_day_label": MessageLookupByLibrary.simpleMessage(
      "Mejor dia",
    ),
    "analytics_top_day_value": m3,
    "analytics_trends_title": MessageLookupByLibrary.simpleMessage(
      "Tendencias emocionales",
    ),
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
    "chat_greeting": MessageLookupByLibrary.simpleMessage(
      "¡Hola! Soy MindtrackBot, tu coach de bienestar. Puedo ayudarte a entender tus emociones, mejorar tus hábitos o simplemente escucharte. ¿Cómo te sientes hoy?",
    ),
    "chat_input_hint": MessageLookupByLibrary.simpleMessage(
      "Escribe un mensaje...",
    ),
    "chat_online": MessageLookupByLibrary.simpleMessage("En línea"),
    "chat_restart": MessageLookupByLibrary.simpleMessage(
      "Reiniciar conversación",
    ),
    "chat_today": MessageLookupByLibrary.simpleMessage("Hoy"),
    "chat_typing": MessageLookupByLibrary.simpleMessage("Escribiendo…"),
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
    "coach_insight_pending_habits": m4,
    "coach_insight_top_emotion": m5,
    "coach_stat_habits": MessageLookupByLibrary.simpleMessage("Habitos"),
    "coach_stat_intensity": MessageLookupByLibrary.simpleMessage("Intensidad"),
    "coach_stat_logs": MessageLookupByLibrary.simpleMessage("Registros"),
    "coach_title": MessageLookupByLibrary.simpleMessage("MindTrack Coach"),
    "common_cancel": MessageLookupByLibrary.simpleMessage("Cancelar"),
    "common_delete": MessageLookupByLibrary.simpleMessage("Eliminar"),
    "confirm_password": MessageLookupByLibrary.simpleMessage(
      "Confirmar contraseña",
    ),
    "confirm_password_mismatch_error": MessageLookupByLibrary.simpleMessage(
      "Las contraseñas no coinciden",
    ),
    "confirm_password_required_error": MessageLookupByLibrary.simpleMessage(
      "Confirma tu contraseña",
    ),
    "continue_with_google": MessageLookupByLibrary.simpleMessage(
      "Continuar con Google",
    ),
    "create_account": MessageLookupByLibrary.simpleMessage("Crear cuenta"),
    "create_my_account": MessageLookupByLibrary.simpleMessage(
      "Crear mi cuenta",
    ),
    "detail_activity": m6,
    "detail_context": MessageLookupByLibrary.simpleMessage("Contexto"),
    "detail_delete_desc": MessageLookupByLibrary.simpleMessage(
      "Este registro se borrará del historial y no se podrá recuperar.",
    ),
    "detail_delete_title": MessageLookupByLibrary.simpleMessage(
      "Eliminar emoción",
    ),
    "detail_edit_intensity": m7,
    "detail_edit_tooltip": MessageLookupByLibrary.simpleMessage(
      "Editar registro",
    ),
    "detail_intensity": m8,
    "detail_no_context": MessageLookupByLibrary.simpleMessage(
      "No registraste contexto para esta emoción.",
    ),
    "detail_no_note": MessageLookupByLibrary.simpleMessage(
      "No agregaste una nota para este registro.",
    ),
    "detail_note_hint": MessageLookupByLibrary.simpleMessage(
      "Escribe una nota para este registro",
    ),
    "detail_note_label": MessageLookupByLibrary.simpleMessage("Nota"),
    "detail_notes": MessageLookupByLibrary.simpleMessage("Notas"),
    "detail_people": m9,
    "detail_place": m10,
    "detail_title": MessageLookupByLibrary.simpleMessage("Detalle de emoción"),
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
    "emotion_activity_hint": MessageLookupByLibrary.simpleMessage(
      "Ej. reunión, ejercicio, descanso",
    ),
    "emotion_details_desc": MessageLookupByLibrary.simpleMessage(
      "Completa los detalles para relacionar cómo te sentiste con el contexto.",
    ),
    "emotion_note_hint": MessageLookupByLibrary.simpleMessage(
      "Describe qué pasó o qué te disparó esta emoción.",
    ),
    "emotion_people_hint": MessageLookupByLibrary.simpleMessage(
      "Ej. solo, amigos, familia",
    ),
    "emotion_place_hint": MessageLookupByLibrary.simpleMessage(
      "Ej. casa, oficina, universidad",
    ),
    "emotion_primary_label": MessageLookupByLibrary.simpleMessage(
      "Emoción principal",
    ),
    "emotion_question": MessageLookupByLibrary.simpleMessage(
      "¿Qué emoción quieres registrar?",
    ),
    "emotion_save_button": MessageLookupByLibrary.simpleMessage(
      "Guardar registro",
    ),
    "emotion_select_error": MessageLookupByLibrary.simpleMessage(
      "Selecciona una emoción para continuar.",
    ),
    "err_chat_empty": MessageLookupByLibrary.simpleMessage(
      "El asistente devolvió una respuesta vacía.",
    ),
    "err_chat_send": MessageLookupByLibrary.simpleMessage(
      "No se pudo enviar el mensaje.",
    ),
    "err_connection": MessageLookupByLibrary.simpleMessage(
      "No se pudo conectar con el servidor.",
    ),
    "err_connection_check": MessageLookupByLibrary.simpleMessage(
      "Error de conexión. Verifica tu red.",
    ),
    "err_delete_emotion": MessageLookupByLibrary.simpleMessage(
      "No se pudo eliminar el registro emocional.",
    ),
    "err_load_analytics": MessageLookupByLibrary.simpleMessage(
      "No se pudieron cargar las analíticas.",
    ),
    "err_load_coach": MessageLookupByLibrary.simpleMessage(
      "No se pudo cargar el coach.",
    ),
    "err_load_dashboard": MessageLookupByLibrary.simpleMessage(
      "No se pudo cargar tu tablero.",
    ),
    "err_load_emotion_detail": MessageLookupByLibrary.simpleMessage(
      "No se pudo cargar el detalle de la emoción.",
    ),
    "err_load_emotion_types": MessageLookupByLibrary.simpleMessage(
      "No se pudieron cargar los tipos de emoción.",
    ),
    "err_load_habits": MessageLookupByLibrary.simpleMessage(
      "No se pudieron cargar los hábitos.",
    ),
    "err_load_history": MessageLookupByLibrary.simpleMessage(
      "No se pudo cargar el historial.",
    ),
    "err_load_profile": MessageLookupByLibrary.simpleMessage(
      "No se pudo cargar tu perfil.",
    ),
    "err_load_tags": MessageLookupByLibrary.simpleMessage(
      "No se pudieron cargar las tags.",
    ),
    "err_network": MessageLookupByLibrary.simpleMessage(
      "Error de red. Inténtalo de nuevo.",
    ),
    "err_save_emotion": MessageLookupByLibrary.simpleMessage(
      "No se pudo guardar el registro emocional.",
    ),
    "err_session_expired_desc": MessageLookupByLibrary.simpleMessage(
      "Por favor inicia sesión nuevamente.",
    ),
    "err_session_expired_full": MessageLookupByLibrary.simpleMessage(
      "Tu sesión expiró. Inicia sesión nuevamente.",
    ),
    "err_session_expired_title": MessageLookupByLibrary.simpleMessage(
      "Sesión expirada",
    ),
    "err_timeout": MessageLookupByLibrary.simpleMessage(
      "La solicitud tardó demasiado.",
    ),
    "err_timeout_conn": MessageLookupByLibrary.simpleMessage(
      "Tiempo de espera agotado. Verifica tu conexión.",
    ),
    "err_unknown": MessageLookupByLibrary.simpleMessage("Error desconocido"),
    "err_update_emotion": MessageLookupByLibrary.simpleMessage(
      "No se pudo actualizar el registro emocional.",
    ),
    "error_title": MessageLookupByLibrary.simpleMessage("Error"),
    "forgot_password": MessageLookupByLibrary.simpleMessage(
      "¿Olvidaste tu contraseña?",
    ),
    "forgot_password_back_to_login": MessageLookupByLibrary.simpleMessage(
      "Volver a iniciar sesión",
    ),
    "forgot_password_button": MessageLookupByLibrary.simpleMessage(
      "Cambiar contraseña",
    ),
    "forgot_password_description": MessageLookupByLibrary.simpleMessage(
      "Ingresa el correo de tu cuenta y elige una nueva contraseña.",
    ),
    "forgot_password_success_title": MessageLookupByLibrary.simpleMessage(
      "Contraseña actualizada",
    ),
    "forgot_password_title": MessageLookupByLibrary.simpleMessage(
      "Recuperar contraseña",
    ),
    "full_name": MessageLookupByLibrary.simpleMessage("Nombre completo"),
    "full_name_hint": MessageLookupByLibrary.simpleMessage("Juan Pérez"),
    "full_name_required_error": MessageLookupByLibrary.simpleMessage(
      "El nombre es requerido",
    ),
    "get_started": MessageLookupByLibrary.simpleMessage("Comenzar"),
    "habits_category_health": MessageLookupByLibrary.simpleMessage("Salud"),
    "habits_category_label": MessageLookupByLibrary.simpleMessage("Categoria"),
    "habits_category_mind": MessageLookupByLibrary.simpleMessage("Mente"),
    "habits_category_other": MessageLookupByLibrary.simpleMessage("Otro"),
    "habits_category_productivity": MessageLookupByLibrary.simpleMessage(
      "Productividad",
    ),
    "habits_category_social": MessageLookupByLibrary.simpleMessage("Social"),
    "habits_create_button": MessageLookupByLibrary.simpleMessage(
      "Crear habito",
    ),
    "habits_create_title": MessageLookupByLibrary.simpleMessage("Crear habito"),
    "habits_daily_progress_message": m11,
    "habits_daily_progress_subtitle": MessageLookupByLibrary.simpleMessage(
      "La constancia es la clave de la claridad mental.",
    ),
    "habits_daily_progress_title": MessageLookupByLibrary.simpleMessage(
      "Progreso diario",
    ),
    "habits_days_error": MessageLookupByLibrary.simpleMessage(
      "Selecciona al menos un dia.",
    ),
    "habits_days_per_week": m12,
    "habits_description_label": MessageLookupByLibrary.simpleMessage(
      "Descripcion",
    ),
    "habits_edit_title": MessageLookupByLibrary.simpleMessage("Editar habito"),
    "habits_empty_description": MessageLookupByLibrary.simpleMessage(
      "Crea uno para empezar a medir constancia y su relacion con tu animo.",
    ),
    "habits_empty_title": MessageLookupByLibrary.simpleMessage(
      "Aun no tienes habitos activos.",
    ),
    "habits_frequency_custom": MessageLookupByLibrary.simpleMessage(
      "Personalizado",
    ),
    "habits_frequency_daily": MessageLookupByLibrary.simpleMessage("Diario"),
    "habits_frequency_label": MessageLookupByLibrary.simpleMessage(
      "Frecuencia",
    ),
    "habits_frequency_weekly": MessageLookupByLibrary.simpleMessage("Semanal"),
    "habits_icon_label": MessageLookupByLibrary.simpleMessage("Elige un icono"),
    "habits_insights_button": MessageLookupByLibrary.simpleMessage("Insights"),
    "habits_name_error": MessageLookupByLibrary.simpleMessage(
      "Ingresa un nombre.",
    ),
    "habits_name_hint": MessageLookupByLibrary.simpleMessage(
      "p. ej., Beber agua",
    ),
    "habits_name_label": MessageLookupByLibrary.simpleMessage("Nombre"),
    "habits_new_button": MessageLookupByLibrary.simpleMessage("Nuevo habito"),
    "habits_save": MessageLookupByLibrary.simpleMessage("Guardar"),
    "habits_save_changes": MessageLookupByLibrary.simpleMessage(
      "Guardar cambios",
    ),
    "habits_title": MessageLookupByLibrary.simpleMessage("Habitos"),
    "habits_today_title": MessageLookupByLibrary.simpleMessage(
      "Habitos de hoy",
    ),
    "habits_weekly_target": m13,
    "history_all_filter": MessageLookupByLibrary.simpleMessage("Todas"),
    "history_delete_desc": MessageLookupByLibrary.simpleMessage(
      "Esta acción quitará la emoción de tu historial.",
    ),
    "history_delete_title": MessageLookupByLibrary.simpleMessage(
      "Eliminar registro",
    ),
    "history_empty_desc": MessageLookupByLibrary.simpleMessage(
      "Usa el botón de registrar para empezar a construir tu historial.",
    ),
    "history_empty_title": MessageLookupByLibrary.simpleMessage(
      "Todavía no tienes emociones registradas.",
    ),
    "history_intensity_label": MessageLookupByLibrary.simpleMessage(
      "INTENSIDAD",
    ),
    "history_log_button": MessageLookupByLibrary.simpleMessage(
      "Registrar emoción",
    ),
    "history_no_results": MessageLookupByLibrary.simpleMessage(
      "No encontramos emociones con esa búsqueda.",
    ),
    "history_results": m14,
    "history_search_hint": MessageLookupByLibrary.simpleMessage(
      "Buscar notas o estados de ánimo",
    ),
    "history_search_title": MessageLookupByLibrary.simpleMessage(
      "Buscar en historial",
    ),
    "history_title": MessageLookupByLibrary.simpleMessage(
      "Historial emocional",
    ),
    "history_today": MessageLookupByLibrary.simpleMessage("Hoy"),
    "history_yesterday": MessageLookupByLibrary.simpleMessage("Ayer"),
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
    "home_greeting": m15,
    "home_greeting_afternoon": m16,
    "home_greeting_evening": m17,
    "home_greeting_morning": m18,
    "home_insight_fallback_day": MessageLookupByLibrary.simpleMessage(
      "Sigue observando qué influye en tu ánimo durante el día.",
    ),
    "home_insight_fallback_week": MessageLookupByLibrary.simpleMessage(
      "Tu semana aún está tomando forma. Sigue registrando para ver patrones.",
    ),
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
    "home_mood_entry_title": MessageLookupByLibrary.simpleMessage(
      "¿Cómo te sientes en este momento?",
    ),
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
    "home_streak_best": m19,
    "home_streak_keep": MessageLookupByLibrary.simpleMessage(
      "Registra hoy para mantenerla",
    ),
    "home_streak_start": MessageLookupByLibrary.simpleMessage(
      "Registra una emocion hoy para empezar tu racha",
    ),
    "home_streak_title": m20,
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
    "home_today_entries_description": m21,
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
    "msg_emotion_deleted": MessageLookupByLibrary.simpleMessage(
      "Registro eliminado.",
    ),
    "msg_emotion_saved": MessageLookupByLibrary.simpleMessage(
      "Registro emocional guardado.",
    ),
    "msg_emotion_updated": MessageLookupByLibrary.simpleMessage(
      "Registro actualizado.",
    ),
    "msg_habit_created": MessageLookupByLibrary.simpleMessage(
      "Hábito creado correctamente.",
    ),
    "msg_habit_done": MessageLookupByLibrary.simpleMessage(
      "Hábito marcado como completado.",
    ),
    "msg_habit_pending": MessageLookupByLibrary.simpleMessage(
      "Hábito marcado como pendiente.",
    ),
    "msg_habit_updated": MessageLookupByLibrary.simpleMessage(
      "Hábito actualizado correctamente.",
    ),
    "msg_password_updated": MessageLookupByLibrary.simpleMessage(
      "Si el correo está registrado, tu contraseña fue actualizada.",
    ),
    "msg_photo_deleted": MessageLookupByLibrary.simpleMessage(
      "Foto de perfil eliminada.",
    ),
    "msg_photo_updated": MessageLookupByLibrary.simpleMessage(
      "Foto de perfil actualizada.",
    ),
    "msg_prefs_updated": MessageLookupByLibrary.simpleMessage(
      "Preferencias actualizadas.",
    ),
    "msg_profile_updated": MessageLookupByLibrary.simpleMessage(
      "Perfil actualizado correctamente.",
    ),
    "new_password": MessageLookupByLibrary.simpleMessage("Nueva contraseña"),
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
    "notifications_pending_description": m22,
    "notifications_pending_title": m23,
    "notifications_reminder_edit_hint": MessageLookupByLibrary.simpleMessage(
      "Te avisaremos todos los dias a esa hora. Toca para cambiarla.",
    ),
    "notifications_reminder_title": m24,
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
    "onboarding_step": m25,
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
    "profile_dark_mode": MessageLookupByLibrary.simpleMessage("Modo oscuro"),
    "profile_delete_photo": MessageLookupByLibrary.simpleMessage(
      "Eliminar foto",
    ),
    "profile_device_language": MessageLookupByLibrary.simpleMessage(
      "Idioma del dispositivo",
    ),
    "profile_edit_button": MessageLookupByLibrary.simpleMessage(
      "Editar perfil",
    ),
    "profile_edit_name": MessageLookupByLibrary.simpleMessage("Editar nombre"),
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
    "profile_notif_toggle_desc": MessageLookupByLibrary.simpleMessage(
      "Activa o desactiva recordatorios de la app.",
    ),
    "profile_notification_settings": MessageLookupByLibrary.simpleMessage(
      "Configuracion de notificaciones",
    ),
    "profile_pick_gallery": MessageLookupByLibrary.simpleMessage(
      "Elegir de galería",
    ),
    "profile_preferences": MessageLookupByLibrary.simpleMessage("Preferencias"),
    "profile_privacy_security": MessageLookupByLibrary.simpleMessage(
      "Privacidad y seguridad",
    ),
    "profile_reminder_off": MessageLookupByLibrary.simpleMessage(
      "Desactivados",
    ),
    "profile_reminder_trailing": m26,
    "profile_take_photo": MessageLookupByLibrary.simpleMessage("Tomar foto"),
    "profile_title": MessageLookupByLibrary.simpleMessage("Perfil"),
    "reminder_channel_desc": MessageLookupByLibrary.simpleMessage(
      "Aviso diario para registrar tus emociones y hábitos.",
    ),
    "reminder_channel_name": MessageLookupByLibrary.simpleMessage(
      "Recordatorio diario",
    ),
    "reminder_enable": MessageLookupByLibrary.simpleMessage(
      "Activar recordatorio",
    ),
    "reminder_notif_body": MessageLookupByLibrary.simpleMessage(
      "Tómate un minuto para registrar tu emoción en MindTrack.",
    ),
    "reminder_notif_title": MessageLookupByLibrary.simpleMessage(
      "¿Cómo te sientes hoy?",
    ),
    "reminder_sheet_desc": MessageLookupByLibrary.simpleMessage(
      "Un aviso al día para registrar cómo te sientes.",
    ),
    "reminder_sheet_title": MessageLookupByLibrary.simpleMessage(
      "Recordatorio diario",
    ),
    "reminder_system_settings": MessageLookupByLibrary.simpleMessage(
      "Ajustes de notificaciones del sistema",
    ),
    "reminder_time_label": MessageLookupByLibrary.simpleMessage(
      "Hora del aviso",
    ),
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
