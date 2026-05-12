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

  static String m1(name) => "Good morning, ${name}";

  static String m2(step, total) =>
      "Step ${step} of ${total} • Emotional Awareness";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "accept_terms": m0,
    "accept_terms_error": MessageLookupByLibrary.simpleMessage(
      "You must accept the terms to continue.",
    ),
    "already_have_account": MessageLookupByLibrary.simpleMessage(
      "Already have an account? ",
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
    "continue_with_google": MessageLookupByLibrary.simpleMessage(
      "Continue with Google",
    ),
    "create_account": MessageLookupByLibrary.simpleMessage("Create Account"),
    "create_my_account": MessageLookupByLibrary.simpleMessage(
      "Create My Account",
    ),
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
    "error_title": MessageLookupByLibrary.simpleMessage("Error"),
    "forgot_password": MessageLookupByLibrary.simpleMessage("Forgot password?"),
    "full_name": MessageLookupByLibrary.simpleMessage("Full Name"),
    "full_name_hint": MessageLookupByLibrary.simpleMessage("John Doe"),
    "full_name_required_error": MessageLookupByLibrary.simpleMessage(
      "Full name is required",
    ),
    "get_started": MessageLookupByLibrary.simpleMessage("Get started"),
    "home_greeting": m1,
    "home_log_emotion_button": MessageLookupByLibrary.simpleMessage(
      "Log My Current Emotion",
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
    "home_subtitle_default": MessageLookupByLibrary.simpleMessage(
      "How are you feeling right now?",
    ),
    "home_subtitle_logged_in": MessageLookupByLibrary.simpleMessage(
      "Welcome back!",
    ),
    "home_subtitle_signed_up": MessageLookupByLibrary.simpleMessage(
      "Account created successfully.",
    ),
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
    "next": MessageLookupByLibrary.simpleMessage("Next"),
    "onboarding_desc_1": MessageLookupByLibrary.simpleMessage(
      "Take a moment each day to reflect on how you feel. Logging your mood helps you build deep self-awareness.",
    ),
    "onboarding_desc_2": MessageLookupByLibrary.simpleMessage(
      "Uncover deep insights into how your activities and habits affect your overall mood over time.",
    ),
    "onboarding_desc_3": MessageLookupByLibrary.simpleMessage(
      "Connect your daily routines with your emotional well-being. Start your journey towards a more balanced life.",
    ),
    "onboarding_step": m2,
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
