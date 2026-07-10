// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  static String m0(terms, privacy) => "I agree to the ${terms} and ${privacy}.";

  static String m1(pct) => "${pct}% completed";

  static String m2(count) => "${count} logs";

  static String m3(day) => "Best mood on ${day}";

  static String m4(count) =>
      "You still have ${count} habit(s) pending today. The easiest one to complete right now may give you a useful momentum boost.";

  static String m5(name) =>
      "Your most frequent recent emotion is ${name}. It is worth checking what activities or people usually appear alongside it.";

  static String m6(value) => "Activity: ${value}";

  static String m7(value) => "Intensity: ${value}/10";

  static String m8(value) => "Intensity ${value}/10";

  static String m9(value) => "People: ${value}";

  static String m10(value) => "Place: ${value}";

  static String m11(completed, total) =>
      "You\'ve completed ${completed} of ${total} habits today!";

  static String m12(days) => "Days per week: ${days}";

  static String m13(days) => "Weekly target: ${days} days";

  static String m14(count) => "${count} result(s)";

  static String m15(name) => "Good morning, ${name}";

  static String m16(name) => "Good afternoon, ${name}";

  static String m17(name) => "Good evening, ${name}";

  static String m18(name) => "Good morning, ${name}";

  static String m19(count) => "Best streak: ${count} day(s)";

  static String m20(count) => "Streak: ${count} day(s)";

  static String m21(count, energy) =>
      "You\'ve logged ${Intl.plural(count, one: '1 entry', other: '${count} entries')} today. Your average energy level is ${energy}.";

  static String m22(completed, target) =>
      "You have not marked this habit today yet. You are at ${completed}/${target} this week.";

  static String m23(name) => "Pending: ${name}";

  static String m24(time) => "Daily reminder · ${time}";

  static String m25(step, total) =>
      "Step ${step} of ${total} • Emotional Awareness";

  static String m26(time) => "Daily · ${time}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "accept_terms": m0,
    "accept_terms_error": MessageLookupByLibrary.simpleMessage(
      "You must accept the terms to continue.",
    ),
    "already_have_account": MessageLookupByLibrary.simpleMessage(
      "Already have an account? ",
    ),
    "analytics_correlation_empty": MessageLookupByLibrary.simpleMessage(
      "There is not enough data to relate habits and mood yet.",
    ),
    "analytics_default_insight": MessageLookupByLibrary.simpleMessage(
      "Keep logging emotions and habits to uncover patterns.",
    ),
    "analytics_distribution_title": MessageLookupByLibrary.simpleMessage(
      "Mood Distribution",
    ),
    "analytics_frequency_empty": MessageLookupByLibrary.simpleMessage(
      "There is not enough data yet to calculate frequency.",
    ),
    "analytics_frequency_title": MessageLookupByLibrary.simpleMessage(
      "Emotional Frequency",
    ),
    "analytics_habits_card_label": MessageLookupByLibrary.simpleMessage(
      "Habits",
    ),
    "analytics_habits_card_value": m1,
    "analytics_habits_mood_title": MessageLookupByLibrary.simpleMessage(
      "Habits vs Mood",
    ),
    "analytics_insight_title": MessageLookupByLibrary.simpleMessage(
      "Weekly Insight",
    ),
    "analytics_metric_habits": MessageLookupByLibrary.simpleMessage("Habits"),
    "analytics_metric_intensity": MessageLookupByLibrary.simpleMessage(
      "Intensity",
    ),
    "analytics_metric_logs": MessageLookupByLibrary.simpleMessage("Logs"),
    "analytics_mood_flow_caption": MessageLookupByLibrary.simpleMessage(
      "Average emotional intensity per day (1-10 scale)",
    ),
    "analytics_mood_flow_fallback_caption": MessageLookupByLibrary.simpleMessage(
      "No intensity logs this week. Showing completed habits per day instead.",
    ),
    "analytics_mood_flow_label": MessageLookupByLibrary.simpleMessage(
      "Weekly Mood Flow",
    ),
    "analytics_no_data_short": MessageLookupByLibrary.simpleMessage(
      "Not enough data",
    ),
    "analytics_no_dominant_emotion": MessageLookupByLibrary.simpleMessage(
      "No dominant emotion yet",
    ),
    "analytics_patterns_title": MessageLookupByLibrary.simpleMessage(
      "Patterns & Observations",
    ),
    "analytics_range_month": MessageLookupByLibrary.simpleMessage("Month"),
    "analytics_range_week": MessageLookupByLibrary.simpleMessage("Week"),
    "analytics_range_year": MessageLookupByLibrary.simpleMessage("Year"),
    "analytics_read_more": MessageLookupByLibrary.simpleMessage(
      "Read more insights",
    ),
    "analytics_records_count": m2,
    "analytics_title": MessageLookupByLibrary.simpleMessage("Analytics"),
    "analytics_top_day_label": MessageLookupByLibrary.simpleMessage("Top Day"),
    "analytics_top_day_value": m3,
    "analytics_trends_title": MessageLookupByLibrary.simpleMessage(
      "Emotional Trends",
    ),
    "analytics_view_habits": MessageLookupByLibrary.simpleMessage(
      "View habits",
    ),
    "analytics_weekly_summary_title": MessageLookupByLibrary.simpleMessage(
      "Weekly Summary",
    ),
    "auth_error_description": MessageLookupByLibrary.simpleMessage(
      "Unable to complete authentication.",
    ),
    "auth_error_title": MessageLookupByLibrary.simpleMessage("Error"),
    "auth_login_success_toast": MessageLookupByLibrary.simpleMessage(
      "Signed in successfully.",
    ),
    "auth_signup_success_toast": MessageLookupByLibrary.simpleMessage(
      "Registration completed successfully.",
    ),
    "auth_success_title": MessageLookupByLibrary.simpleMessage("Success"),
    "back": MessageLookupByLibrary.simpleMessage("Back"),
    "begin_your_journey": MessageLookupByLibrary.simpleMessage(
      "Begin Your Journey",
    ),
    "chat_greeting": MessageLookupByLibrary.simpleMessage(
      "Hi! I\'m MindtrackBot, your wellbeing coach. I can help you understand your emotions, improve your habits, or simply listen. How are you feeling today?",
    ),
    "chat_input_hint": MessageLookupByLibrary.simpleMessage(
      "Write a message...",
    ),
    "chat_online": MessageLookupByLibrary.simpleMessage("Online"),
    "chat_restart": MessageLookupByLibrary.simpleMessage(
      "Restart conversation",
    ),
    "chat_today": MessageLookupByLibrary.simpleMessage("Today"),
    "chat_typing": MessageLookupByLibrary.simpleMessage("Typing…"),
    "coach_hero_description": MessageLookupByLibrary.simpleMessage(
      "Actionable suggestions based on your recent activity.",
    ),
    "coach_hero_label": MessageLookupByLibrary.simpleMessage("AI Coach"),
    "coach_insight_balanced": MessageLookupByLibrary.simpleMessage(
      "Your metrics look balanced. Keep the rhythm and review your most consistent habits to reinforce what is already working.",
    ),
    "coach_insight_high_intensity": MessageLookupByLibrary.simpleMessage(
      "Your average emotional intensity is trending high. Consider a short pause today: guided breathing, a short walk, or journaling.",
    ),
    "coach_insight_low_habits": MessageLookupByLibrary.simpleMessage(
      "Your habit consistency is below 50%. Focus on completing just one key habit today to regain traction.",
    ),
    "coach_insight_low_logs": MessageLookupByLibrary.simpleMessage(
      "There are still few logs this week. Try noting at least one emotion in the morning and one at night to improve your patterns.",
    ),
    "coach_insight_pending_habits": m4,
    "coach_insight_top_emotion": m5,
    "coach_stat_habits": MessageLookupByLibrary.simpleMessage("Habits"),
    "coach_stat_intensity": MessageLookupByLibrary.simpleMessage("Intensity"),
    "coach_stat_logs": MessageLookupByLibrary.simpleMessage("Logs"),
    "coach_title": MessageLookupByLibrary.simpleMessage("MindTrack Coach"),
    "common_cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
    "common_delete": MessageLookupByLibrary.simpleMessage("Delete"),
    "confirm_password": MessageLookupByLibrary.simpleMessage(
      "Confirm password",
    ),
    "confirm_password_mismatch_error": MessageLookupByLibrary.simpleMessage(
      "Passwords do not match",
    ),
    "confirm_password_required_error": MessageLookupByLibrary.simpleMessage(
      "Please confirm your password",
    ),
    "continue_with_google": MessageLookupByLibrary.simpleMessage(
      "Continue with Google",
    ),
    "create_account": MessageLookupByLibrary.simpleMessage("Create Account"),
    "create_my_account": MessageLookupByLibrary.simpleMessage(
      "Create My Account",
    ),
    "detail_activity": m6,
    "detail_context": MessageLookupByLibrary.simpleMessage("Context"),
    "detail_delete_desc": MessageLookupByLibrary.simpleMessage(
      "This entry will be deleted from your history and cannot be recovered.",
    ),
    "detail_delete_title": MessageLookupByLibrary.simpleMessage(
      "Delete emotion",
    ),
    "detail_edit_intensity": m7,
    "detail_edit_tooltip": MessageLookupByLibrary.simpleMessage("Edit entry"),
    "detail_intensity": m8,
    "detail_no_context": MessageLookupByLibrary.simpleMessage(
      "You didn\'t log context for this emotion.",
    ),
    "detail_no_note": MessageLookupByLibrary.simpleMessage(
      "You didn\'t add a note to this entry.",
    ),
    "detail_note_hint": MessageLookupByLibrary.simpleMessage(
      "Write a note for this entry",
    ),
    "detail_note_label": MessageLookupByLibrary.simpleMessage("Note"),
    "detail_notes": MessageLookupByLibrary.simpleMessage("Notes"),
    "detail_people": m9,
    "detail_place": m10,
    "detail_title": MessageLookupByLibrary.simpleMessage("Emotion detail"),
    "dont_have_account": MessageLookupByLibrary.simpleMessage(
      "Don\'t have an account? ",
    ),
    "email_address": MessageLookupByLibrary.simpleMessage("Email Address"),
    "email_invalid_error": MessageLookupByLibrary.simpleMessage(
      "Enter a valid email with @",
    ),
    "email_required_error": MessageLookupByLibrary.simpleMessage(
      "Email is required",
    ),
    "emotion_activity_hint": MessageLookupByLibrary.simpleMessage(
      "E.g. meeting, exercise, rest",
    ),
    "emotion_details_desc": MessageLookupByLibrary.simpleMessage(
      "Fill in the details to connect how you felt with the context.",
    ),
    "emotion_note_hint": MessageLookupByLibrary.simpleMessage(
      "Describe what happened or what triggered this emotion.",
    ),
    "emotion_people_hint": MessageLookupByLibrary.simpleMessage(
      "E.g. alone, friends, family",
    ),
    "emotion_place_hint": MessageLookupByLibrary.simpleMessage(
      "E.g. home, office, university",
    ),
    "emotion_primary_label": MessageLookupByLibrary.simpleMessage(
      "Main emotion",
    ),
    "emotion_question": MessageLookupByLibrary.simpleMessage(
      "Which emotion do you want to log?",
    ),
    "emotion_save_button": MessageLookupByLibrary.simpleMessage("Save entry"),
    "emotion_select_error": MessageLookupByLibrary.simpleMessage(
      "Select an emotion to continue.",
    ),
    "err_chat_empty": MessageLookupByLibrary.simpleMessage(
      "The assistant returned an empty reply.",
    ),
    "err_chat_send": MessageLookupByLibrary.simpleMessage(
      "Could not send the message.",
    ),
    "err_connection": MessageLookupByLibrary.simpleMessage(
      "Could not connect to the server.",
    ),
    "err_connection_check": MessageLookupByLibrary.simpleMessage(
      "Connection error. Check your network.",
    ),
    "err_delete_emotion": MessageLookupByLibrary.simpleMessage(
      "Could not delete the emotion entry.",
    ),
    "err_load_analytics": MessageLookupByLibrary.simpleMessage(
      "Could not load analytics.",
    ),
    "err_load_coach": MessageLookupByLibrary.simpleMessage(
      "Could not load the coach.",
    ),
    "err_load_dashboard": MessageLookupByLibrary.simpleMessage(
      "Could not load your dashboard.",
    ),
    "err_load_emotion_detail": MessageLookupByLibrary.simpleMessage(
      "Could not load the emotion detail.",
    ),
    "err_load_emotion_types": MessageLookupByLibrary.simpleMessage(
      "Could not load the emotion types.",
    ),
    "err_load_habits": MessageLookupByLibrary.simpleMessage(
      "Could not load habits.",
    ),
    "err_load_history": MessageLookupByLibrary.simpleMessage(
      "Could not load the history.",
    ),
    "err_load_profile": MessageLookupByLibrary.simpleMessage(
      "Could not load your profile.",
    ),
    "err_load_tags": MessageLookupByLibrary.simpleMessage(
      "Could not load the tags.",
    ),
    "err_network": MessageLookupByLibrary.simpleMessage(
      "Network error. Try again.",
    ),
    "err_save_emotion": MessageLookupByLibrary.simpleMessage(
      "Could not save the emotion entry.",
    ),
    "err_session_expired_desc": MessageLookupByLibrary.simpleMessage(
      "Please sign in again.",
    ),
    "err_session_expired_full": MessageLookupByLibrary.simpleMessage(
      "Your session expired. Please sign in again.",
    ),
    "err_session_expired_title": MessageLookupByLibrary.simpleMessage(
      "Session expired",
    ),
    "err_timeout": MessageLookupByLibrary.simpleMessage(
      "The request timed out.",
    ),
    "err_timeout_conn": MessageLookupByLibrary.simpleMessage(
      "Request timed out. Check your connection.",
    ),
    "err_unknown": MessageLookupByLibrary.simpleMessage("Unknown error"),
    "err_update_emotion": MessageLookupByLibrary.simpleMessage(
      "Could not update the emotion entry.",
    ),
    "error_title": MessageLookupByLibrary.simpleMessage("Error"),
    "forgot_password": MessageLookupByLibrary.simpleMessage("Forgot password?"),
    "forgot_password_back_to_login": MessageLookupByLibrary.simpleMessage(
      "Back to sign in",
    ),
    "forgot_password_button": MessageLookupByLibrary.simpleMessage(
      "Change password",
    ),
    "forgot_password_description": MessageLookupByLibrary.simpleMessage(
      "Enter your account email and choose a new password.",
    ),
    "forgot_password_success_title": MessageLookupByLibrary.simpleMessage(
      "Password updated",
    ),
    "forgot_password_title": MessageLookupByLibrary.simpleMessage(
      "Reset password",
    ),
    "full_name": MessageLookupByLibrary.simpleMessage("Full Name"),
    "full_name_hint": MessageLookupByLibrary.simpleMessage("John Doe"),
    "full_name_required_error": MessageLookupByLibrary.simpleMessage(
      "Full name is required",
    ),
    "get_started": MessageLookupByLibrary.simpleMessage("Get started"),
    "habits_category_health": MessageLookupByLibrary.simpleMessage("Health"),
    "habits_category_label": MessageLookupByLibrary.simpleMessage("Category"),
    "habits_category_mind": MessageLookupByLibrary.simpleMessage("Mind"),
    "habits_category_other": MessageLookupByLibrary.simpleMessage("Other"),
    "habits_category_productivity": MessageLookupByLibrary.simpleMessage(
      "Productivity",
    ),
    "habits_category_social": MessageLookupByLibrary.simpleMessage("Social"),
    "habits_create_button": MessageLookupByLibrary.simpleMessage(
      "Create Habit",
    ),
    "habits_create_title": MessageLookupByLibrary.simpleMessage("Create habit"),
    "habits_daily_progress_message": m11,
    "habits_daily_progress_subtitle": MessageLookupByLibrary.simpleMessage(
      "Consistency is the key to mental clarity.",
    ),
    "habits_daily_progress_title": MessageLookupByLibrary.simpleMessage(
      "Daily Progress",
    ),
    "habits_days_error": MessageLookupByLibrary.simpleMessage(
      "Select at least one day.",
    ),
    "habits_days_per_week": m12,
    "habits_description_label": MessageLookupByLibrary.simpleMessage(
      "Description",
    ),
    "habits_edit_title": MessageLookupByLibrary.simpleMessage("Edit Habit"),
    "habits_empty_description": MessageLookupByLibrary.simpleMessage(
      "Create one to start measuring consistency and its relationship with your mood.",
    ),
    "habits_empty_title": MessageLookupByLibrary.simpleMessage(
      "You do not have active habits yet.",
    ),
    "habits_frequency_custom": MessageLookupByLibrary.simpleMessage("Custom"),
    "habits_frequency_daily": MessageLookupByLibrary.simpleMessage("Daily"),
    "habits_frequency_label": MessageLookupByLibrary.simpleMessage("Frequency"),
    "habits_frequency_weekly": MessageLookupByLibrary.simpleMessage("Weekly"),
    "habits_icon_label": MessageLookupByLibrary.simpleMessage("Choose Icon"),
    "habits_insights_button": MessageLookupByLibrary.simpleMessage("Insights"),
    "habits_name_error": MessageLookupByLibrary.simpleMessage("Enter a name."),
    "habits_name_hint": MessageLookupByLibrary.simpleMessage(
      "e.g., Drink Water",
    ),
    "habits_name_label": MessageLookupByLibrary.simpleMessage("Name"),
    "habits_new_button": MessageLookupByLibrary.simpleMessage("New habit"),
    "habits_save": MessageLookupByLibrary.simpleMessage("Save"),
    "habits_save_changes": MessageLookupByLibrary.simpleMessage("Save Changes"),
    "habits_title": MessageLookupByLibrary.simpleMessage("Habits"),
    "habits_today_title": MessageLookupByLibrary.simpleMessage(
      "Today\'s Habits",
    ),
    "habits_weekly_target": m13,
    "history_all_filter": MessageLookupByLibrary.simpleMessage("All"),
    "history_delete_desc": MessageLookupByLibrary.simpleMessage(
      "This will remove the emotion from your history.",
    ),
    "history_delete_title": MessageLookupByLibrary.simpleMessage(
      "Delete entry",
    ),
    "history_empty_desc": MessageLookupByLibrary.simpleMessage(
      "Use the log button to start building your history.",
    ),
    "history_empty_title": MessageLookupByLibrary.simpleMessage(
      "You have no logged emotions yet.",
    ),
    "history_intensity_label": MessageLookupByLibrary.simpleMessage(
      "INTENSITY",
    ),
    "history_log_button": MessageLookupByLibrary.simpleMessage("Log emotion"),
    "history_no_results": MessageLookupByLibrary.simpleMessage(
      "No emotions match your search.",
    ),
    "history_results": m14,
    "history_search_hint": MessageLookupByLibrary.simpleMessage(
      "Search notes or moods",
    ),
    "history_search_title": MessageLookupByLibrary.simpleMessage(
      "Search history",
    ),
    "history_title": MessageLookupByLibrary.simpleMessage("Emotion history"),
    "history_today": MessageLookupByLibrary.simpleMessage("Today"),
    "history_yesterday": MessageLookupByLibrary.simpleMessage("Yesterday"),
    "home_daily_habits_title": MessageLookupByLibrary.simpleMessage(
      "Daily Habits",
    ),
    "home_empty_entries_message": MessageLookupByLibrary.simpleMessage(
      "No emotions have been logged yet.",
    ),
    "home_empty_habits_message": MessageLookupByLibrary.simpleMessage(
      "You do not have active habits yet.",
    ),
    "home_energy_balanced": MessageLookupByLibrary.simpleMessage("balanced"),
    "home_energy_high": MessageLookupByLibrary.simpleMessage("high"),
    "home_energy_low": MessageLookupByLibrary.simpleMessage("low"),
    "home_entry_no_note": MessageLookupByLibrary.simpleMessage(
      "No additional notes.",
    ),
    "home_entry_yesterday": MessageLookupByLibrary.simpleMessage("Yesterday"),
    "home_greeting": m15,
    "home_greeting_afternoon": m16,
    "home_greeting_evening": m17,
    "home_greeting_morning": m18,
    "home_insight_fallback_day": MessageLookupByLibrary.simpleMessage(
      "Keep noticing what influences your mood during the day.",
    ),
    "home_insight_fallback_week": MessageLookupByLibrary.simpleMessage(
      "Your week is still taking shape. Keep logging to see patterns.",
    ),
    "home_log_emotion_button": MessageLookupByLibrary.simpleMessage(
      "Log My Current Emotion",
    ),
    "home_logout_success": MessageLookupByLibrary.simpleMessage(
      "Signed out successfully.",
    ),
    "home_logout_tooltip": MessageLookupByLibrary.simpleMessage("Sign out"),
    "home_manager_ai": MessageLookupByLibrary.simpleMessage("AI Manager"),
    "home_mood_entry_title": MessageLookupByLibrary.simpleMessage(
      "How are you feeling right now?",
    ),
    "home_mood_primary_description": MessageLookupByLibrary.simpleMessage(
      "You\'ve logged 3 entries today. Your average energy level is high.",
    ),
    "home_mood_primary_title": MessageLookupByLibrary.simpleMessage(
      "Primarily Positive",
    ),
    "home_mood_status_stable": MessageLookupByLibrary.simpleMessage("STABLE"),
    "home_nav_analytics": MessageLookupByLibrary.simpleMessage("ANALYTICS"),
    "home_nav_habits": MessageLookupByLibrary.simpleMessage("HABITS"),
    "home_nav_history": MessageLookupByLibrary.simpleMessage("HISTORY"),
    "home_nav_home": MessageLookupByLibrary.simpleMessage("HOME"),
    "home_nav_profile": MessageLookupByLibrary.simpleMessage("PROFILE"),
    "home_recent_entries_title": MessageLookupByLibrary.simpleMessage(
      "Recent Entries",
    ),
    "home_retry": MessageLookupByLibrary.simpleMessage("Retry"),
    "home_section_soon_description": MessageLookupByLibrary.simpleMessage(
      "This section will be available soon.",
    ),
    "home_see_all": MessageLookupByLibrary.simpleMessage("See all"),
    "home_status_elevated": MessageLookupByLibrary.simpleMessage("ELEVATED"),
    "home_status_gentle": MessageLookupByLibrary.simpleMessage("GENTLE"),
    "home_status_new_day": MessageLookupByLibrary.simpleMessage("NEW DAY"),
    "home_streak_best": m19,
    "home_streak_keep": MessageLookupByLibrary.simpleMessage(
      "Log today to keep it going",
    ),
    "home_streak_start": MessageLookupByLibrary.simpleMessage(
      "Log an emotion today to start your streak",
    ),
    "home_streak_title": m20,
    "home_subtitle_default": MessageLookupByLibrary.simpleMessage(
      "How are you feeling right now?",
    ),
    "home_subtitle_logged_in": MessageLookupByLibrary.simpleMessage(
      "Welcome back!",
    ),
    "home_subtitle_signed_up": MessageLookupByLibrary.simpleMessage(
      "Account created successfully.",
    ),
    "home_today_empty_description": MessageLookupByLibrary.simpleMessage(
      "Start by logging how you feel to build your daily trend.",
    ),
    "home_today_empty_title": MessageLookupByLibrary.simpleMessage(
      "No entries yet",
    ),
    "home_today_entries_description": m21,
    "home_today_mood_title": MessageLookupByLibrary.simpleMessage(
      "Today\'s Mood",
    ),
    "home_view_detailed_analysis": MessageLookupByLibrary.simpleMessage(
      "View detailed analysis",
    ),
    "home_weekday_fri": MessageLookupByLibrary.simpleMessage("FRI"),
    "home_weekday_mon": MessageLookupByLibrary.simpleMessage("MON"),
    "home_weekday_sat": MessageLookupByLibrary.simpleMessage("SAT"),
    "home_weekday_sun": MessageLookupByLibrary.simpleMessage("SUN"),
    "home_weekday_thu": MessageLookupByLibrary.simpleMessage("THU"),
    "home_weekday_tue": MessageLookupByLibrary.simpleMessage("TUE"),
    "home_weekday_wed": MessageLookupByLibrary.simpleMessage("WED"),
    "home_weekly_overview_title": MessageLookupByLibrary.simpleMessage(
      "Weekly Overview",
    ),
    "home_weekly_quote": MessageLookupByLibrary.simpleMessage(
      "\"Your mood peaks during the weekend.\\nTry to identify why!\"",
    ),
    "log_in": MessageLookupByLibrary.simpleMessage("Log In"),
    "login_subtitle": MessageLookupByLibrary.simpleMessage(
      "Log in to continue your journey towards emotional wellness.",
    ),
    "msg_emotion_deleted": MessageLookupByLibrary.simpleMessage(
      "Entry deleted.",
    ),
    "msg_emotion_saved": MessageLookupByLibrary.simpleMessage(
      "Emotion entry saved.",
    ),
    "msg_emotion_updated": MessageLookupByLibrary.simpleMessage(
      "Entry updated.",
    ),
    "msg_habit_created": MessageLookupByLibrary.simpleMessage(
      "Habit created successfully.",
    ),
    "msg_habit_done": MessageLookupByLibrary.simpleMessage(
      "Habit marked as completed.",
    ),
    "msg_habit_pending": MessageLookupByLibrary.simpleMessage(
      "Habit marked as pending.",
    ),
    "msg_habit_updated": MessageLookupByLibrary.simpleMessage(
      "Habit updated successfully.",
    ),
    "msg_password_updated": MessageLookupByLibrary.simpleMessage(
      "If the email is registered, your password was updated.",
    ),
    "msg_photo_deleted": MessageLookupByLibrary.simpleMessage(
      "Profile photo removed.",
    ),
    "msg_photo_updated": MessageLookupByLibrary.simpleMessage(
      "Profile photo updated.",
    ),
    "msg_prefs_updated": MessageLookupByLibrary.simpleMessage(
      "Preferences updated.",
    ),
    "msg_profile_updated": MessageLookupByLibrary.simpleMessage(
      "Profile updated successfully.",
    ),
    "new_password": MessageLookupByLibrary.simpleMessage("New password"),
    "next": MessageLookupByLibrary.simpleMessage("Next"),
    "notifications_active_description": MessageLookupByLibrary.simpleMessage(
      "Your reminders are enabled from preferences.",
    ),
    "notifications_active_title": MessageLookupByLibrary.simpleMessage(
      "Reminders active",
    ),
    "notifications_habits_clear_description": MessageLookupByLibrary.simpleMessage(
      "You do not have habits pending today, or you already completed them all.",
    ),
    "notifications_habits_clear_title": MessageLookupByLibrary.simpleMessage(
      "All clear with your habits",
    ),
    "notifications_inactive_description": MessageLookupByLibrary.simpleMessage(
      "Enable notifications in your profile to receive reminders.",
    ),
    "notifications_inactive_title": MessageLookupByLibrary.simpleMessage(
      "Reminders disabled",
    ),
    "notifications_mood_logged_description":
        MessageLookupByLibrary.simpleMessage(
          "You already logged at least one emotion today. Nice work.",
        ),
    "notifications_mood_logged_title": MessageLookupByLibrary.simpleMessage(
      "Mood log up to date",
    ),
    "notifications_mood_missing_description":
        MessageLookupByLibrary.simpleMessage(
          "Logging an emotion today helps improve your weekly insights.",
        ),
    "notifications_mood_missing_title": MessageLookupByLibrary.simpleMessage(
      "You still need to log how you feel today",
    ),
    "notifications_pending_description": m22,
    "notifications_pending_title": m23,
    "notifications_reminder_edit_hint": MessageLookupByLibrary.simpleMessage(
      "We will remind you every day at that time. Tap to change it.",
    ),
    "notifications_reminder_title": m24,
    "notifications_title": MessageLookupByLibrary.simpleMessage(
      "Notifications",
    ),
    "onboarding_desc_1": MessageLookupByLibrary.simpleMessage(
      "Take a moment each day to reflect on how you feel. Logging your mood helps you build deep self-awareness.",
    ),
    "onboarding_desc_2": MessageLookupByLibrary.simpleMessage(
      "Uncover deep insights into how your activities and habits affect your overall mood over time.",
    ),
    "onboarding_desc_3": MessageLookupByLibrary.simpleMessage(
      "Connect your daily routines with your emotional well-being. Start your journey towards a more balanced life.",
    ),
    "onboarding_step": m25,
    "onboarding_title_1": MessageLookupByLibrary.simpleMessage(
      "Track your daily emotions",
    ),
    "onboarding_title_2": MessageLookupByLibrary.simpleMessage(
      "Discover emotional patterns",
    ),
    "onboarding_title_3": MessageLookupByLibrary.simpleMessage(
      "Build healthy habits & self-awareness",
    ),
    "or_continue_with": MessageLookupByLibrary.simpleMessage(
      "OR CONTINUE WITH",
    ),
    "or_join_with": MessageLookupByLibrary.simpleMessage("Or join with"),
    "password": MessageLookupByLibrary.simpleMessage("Password"),
    "password_lowercase_error": MessageLookupByLibrary.simpleMessage(
      "Must contain at least one lowercase letter",
    ),
    "password_min_length_error": MessageLookupByLibrary.simpleMessage(
      "Minimum 8 characters",
    ),
    "password_number_error": MessageLookupByLibrary.simpleMessage(
      "Must contain at least one number",
    ),
    "password_required_error": MessageLookupByLibrary.simpleMessage(
      "Password is required",
    ),
    "password_special_char_error": MessageLookupByLibrary.simpleMessage(
      "Must contain one special character",
    ),
    "password_uppercase_error": MessageLookupByLibrary.simpleMessage(
      "Must contain at least one uppercase letter",
    ),
    "privacy_policy": MessageLookupByLibrary.simpleMessage("Privacy Policy"),
    "profile_account_settings": MessageLookupByLibrary.simpleMessage(
      "ACCOUNT SETTINGS",
    ),
    "profile_dark_mode": MessageLookupByLibrary.simpleMessage("Dark mode"),
    "profile_delete_photo": MessageLookupByLibrary.simpleMessage(
      "Remove photo",
    ),
    "profile_device_language": MessageLookupByLibrary.simpleMessage(
      "Device language",
    ),
    "profile_edit_button": MessageLookupByLibrary.simpleMessage("Edit profile"),
    "profile_edit_name": MessageLookupByLibrary.simpleMessage("Edit name"),
    "profile_footer_caption": MessageLookupByLibrary.simpleMessage(
      "MindTrack v2.4.0 • Made with mindfulness",
    ),
    "profile_intent_android_only": MessageLookupByLibrary.simpleMessage(
      "This option is available on Android settings.",
    ),
    "profile_intent_link_unavailable": MessageLookupByLibrary.simpleMessage(
      "No app was available to open this link.",
    ),
    "profile_language": MessageLookupByLibrary.simpleMessage("Language"),
    "profile_language_english": MessageLookupByLibrary.simpleMessage("English"),
    "profile_language_spanish": MessageLookupByLibrary.simpleMessage("Spanish"),
    "profile_logout": MessageLookupByLibrary.simpleMessage("Logout"),
    "profile_notif_toggle_desc": MessageLookupByLibrary.simpleMessage(
      "Turn app reminders on or off.",
    ),
    "profile_notification_settings": MessageLookupByLibrary.simpleMessage(
      "Notification Settings",
    ),
    "profile_pick_gallery": MessageLookupByLibrary.simpleMessage(
      "Choose from gallery",
    ),
    "profile_preferences": MessageLookupByLibrary.simpleMessage("Preferences"),
    "profile_privacy_security": MessageLookupByLibrary.simpleMessage(
      "Privacy & Security",
    ),
    "profile_reminder_off": MessageLookupByLibrary.simpleMessage("Off"),
    "profile_reminder_trailing": m26,
    "profile_take_photo": MessageLookupByLibrary.simpleMessage("Take photo"),
    "profile_title": MessageLookupByLibrary.simpleMessage("Profile"),
    "reminder_channel_desc": MessageLookupByLibrary.simpleMessage(
      "Daily alert to log your emotions and habits.",
    ),
    "reminder_channel_name": MessageLookupByLibrary.simpleMessage(
      "Daily reminder",
    ),
    "reminder_enable": MessageLookupByLibrary.simpleMessage("Enable reminder"),
    "reminder_notif_body": MessageLookupByLibrary.simpleMessage(
      "Take a minute to log your emotion in MindTrack.",
    ),
    "reminder_notif_title": MessageLookupByLibrary.simpleMessage(
      "How are you feeling today?",
    ),
    "reminder_sheet_desc": MessageLookupByLibrary.simpleMessage(
      "One alert a day to log how you feel.",
    ),
    "reminder_sheet_title": MessageLookupByLibrary.simpleMessage(
      "Daily reminder",
    ),
    "reminder_system_settings": MessageLookupByLibrary.simpleMessage(
      "System notification settings",
    ),
    "reminder_time_label": MessageLookupByLibrary.simpleMessage("Alert time"),
    "search_emotions_empty": MessageLookupByLibrary.simpleMessage(
      "No matching emotions were found.",
    ),
    "search_emotions_title": MessageLookupByLibrary.simpleMessage("Emotions"),
    "search_habits_empty": MessageLookupByLibrary.simpleMessage(
      "No matching habits were found.",
    ),
    "search_habits_title": MessageLookupByLibrary.simpleMessage("Habits"),
    "search_hint": MessageLookupByLibrary.simpleMessage(
      "Search emotions, notes, or habits",
    ),
    "search_no_detail": MessageLookupByLibrary.simpleMessage("No detail"),
    "search_title": MessageLookupByLibrary.simpleMessage("Search"),
    "sign_in": MessageLookupByLibrary.simpleMessage("Sign In"),
    "sign_in_button": MessageLookupByLibrary.simpleMessage("Sign In"),
    "sign_up": MessageLookupByLibrary.simpleMessage("Sign Up"),
    "signup_subtitle": MessageLookupByLibrary.simpleMessage(
      "Join thousands of others tracking their path to emotional wellness.",
    ),
    "skip": MessageLookupByLibrary.simpleMessage("Skip"),
    "splash_message": MessageLookupByLibrary.simpleMessage(
      "A gentle space to track your emotions and discover patterns for a healthier mind.",
    ),
    "splash_message_part2": MessageLookupByLibrary.simpleMessage(
      "Emotional awareness is the first step towards mental well-being.",
    ),
    "start_journey": MessageLookupByLibrary.simpleMessage(
      "Tap to start journey",
    ),
    "terms_of_service": MessageLookupByLibrary.simpleMessage(
      "Terms of Service",
    ),
    "title": MessageLookupByLibrary.simpleMessage("MindTrack"),
    "title_splash": MessageLookupByLibrary.simpleMessage("Find Your Calm"),
  };
}
