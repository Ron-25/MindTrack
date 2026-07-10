// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `MindTrack`
  String get title {
    return Intl.message('MindTrack', name: 'title', desc: '', args: []);
  }

  /// `Find Your Calm`
  String get title_splash {
    return Intl.message(
      'Find Your Calm',
      name: 'title_splash',
      desc: '',
      args: [],
    );
  }

  /// `A gentle space to track your emotions and discover patterns for a healthier mind.`
  String get splash_message {
    return Intl.message(
      'A gentle space to track your emotions and discover patterns for a healthier mind.',
      name: 'splash_message',
      desc: '',
      args: [],
    );
  }

  /// `Emotional awareness is the first step towards mental well-being.`
  String get splash_message_part2 {
    return Intl.message(
      'Emotional awareness is the first step towards mental well-being.',
      name: 'splash_message_part2',
      desc: '',
      args: [],
    );
  }

  /// `Tap to start journey`
  String get start_journey {
    return Intl.message(
      'Tap to start journey',
      name: 'start_journey',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get skip {
    return Intl.message('Skip', name: 'skip', desc: '', args: []);
  }

  /// `Back`
  String get back {
    return Intl.message('Back', name: 'back', desc: '', args: []);
  }

  /// `Next`
  String get next {
    return Intl.message('Next', name: 'next', desc: '', args: []);
  }

  /// `Get started`
  String get get_started {
    return Intl.message('Get started', name: 'get_started', desc: '', args: []);
  }

  /// `Track your daily emotions`
  String get onboarding_title_1 {
    return Intl.message(
      'Track your daily emotions',
      name: 'onboarding_title_1',
      desc: '',
      args: [],
    );
  }

  /// `Discover emotional patterns`
  String get onboarding_title_2 {
    return Intl.message(
      'Discover emotional patterns',
      name: 'onboarding_title_2',
      desc: '',
      args: [],
    );
  }

  /// `Build healthy habits & self-awareness`
  String get onboarding_title_3 {
    return Intl.message(
      'Build healthy habits & self-awareness',
      name: 'onboarding_title_3',
      desc: '',
      args: [],
    );
  }

  /// `Take a moment each day to reflect on how you feel. Logging your mood helps you build deep self-awareness.`
  String get onboarding_desc_1 {
    return Intl.message(
      'Take a moment each day to reflect on how you feel. Logging your mood helps you build deep self-awareness.',
      name: 'onboarding_desc_1',
      desc: '',
      args: [],
    );
  }

  /// `Uncover deep insights into how your activities and habits affect your overall mood over time.`
  String get onboarding_desc_2 {
    return Intl.message(
      'Uncover deep insights into how your activities and habits affect your overall mood over time.',
      name: 'onboarding_desc_2',
      desc: '',
      args: [],
    );
  }

  /// `Connect your daily routines with your emotional well-being. Start your journey towards a more balanced life.`
  String get onboarding_desc_3 {
    return Intl.message(
      'Connect your daily routines with your emotional well-being. Start your journey towards a more balanced life.',
      name: 'onboarding_desc_3',
      desc: '',
      args: [],
    );
  }

  /// `Step {step} of {total} • Emotional Awareness`
  String onboarding_step(Object step, Object total) {
    return Intl.message(
      'Step $step of $total • Emotional Awareness',
      name: 'onboarding_step',
      desc: 'Onboarding step indicator',
      args: [step, total],
    );
  }

  /// `Sign In`
  String get sign_in {
    return Intl.message('Sign In', name: 'sign_in', desc: '', args: []);
  }

  /// `Log in to continue your journey towards emotional wellness.`
  String get login_subtitle {
    return Intl.message(
      'Log in to continue your journey towards emotional wellness.',
      name: 'login_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Email Address`
  String get email_address {
    return Intl.message(
      'Email Address',
      name: 'email_address',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `Email is required`
  String get email_required_error {
    return Intl.message(
      'Email is required',
      name: 'email_required_error',
      desc: '',
      args: [],
    );
  }

  /// `Enter a valid email with @`
  String get email_invalid_error {
    return Intl.message(
      'Enter a valid email with @',
      name: 'email_invalid_error',
      desc: '',
      args: [],
    );
  }

  /// `Password is required`
  String get password_required_error {
    return Intl.message(
      'Password is required',
      name: 'password_required_error',
      desc: '',
      args: [],
    );
  }

  /// `Minimum 8 characters`
  String get password_min_length_error {
    return Intl.message(
      'Minimum 8 characters',
      name: 'password_min_length_error',
      desc: '',
      args: [],
    );
  }

  /// `Must contain at least one uppercase letter`
  String get password_uppercase_error {
    return Intl.message(
      'Must contain at least one uppercase letter',
      name: 'password_uppercase_error',
      desc: '',
      args: [],
    );
  }

  /// `Must contain at least one lowercase letter`
  String get password_lowercase_error {
    return Intl.message(
      'Must contain at least one lowercase letter',
      name: 'password_lowercase_error',
      desc: '',
      args: [],
    );
  }

  /// `Must contain at least one number`
  String get password_number_error {
    return Intl.message(
      'Must contain at least one number',
      name: 'password_number_error',
      desc: '',
      args: [],
    );
  }

  /// `Must contain one special character`
  String get password_special_char_error {
    return Intl.message(
      'Must contain one special character',
      name: 'password_special_char_error',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get sign_in_button {
    return Intl.message('Sign In', name: 'sign_in_button', desc: '', args: []);
  }

  /// `OR CONTINUE WITH`
  String get or_continue_with {
    return Intl.message(
      'OR CONTINUE WITH',
      name: 'or_continue_with',
      desc: '',
      args: [],
    );
  }

  /// `Continue with Google`
  String get continue_with_google {
    return Intl.message(
      'Continue with Google',
      name: 'continue_with_google',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account? `
  String get dont_have_account {
    return Intl.message(
      'Don\'t have an account? ',
      name: 'dont_have_account',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get sign_up {
    return Intl.message('Sign Up', name: 'sign_up', desc: '', args: []);
  }

  /// `Forgot password?`
  String get forgot_password {
    return Intl.message(
      'Forgot password?',
      name: 'forgot_password',
      desc: '',
      args: [],
    );
  }

  /// `Reset password`
  String get forgot_password_title {
    return Intl.message(
      'Reset password',
      name: 'forgot_password_title',
      desc: '',
      args: [],
    );
  }

  /// `Enter your account email and choose a new password.`
  String get forgot_password_description {
    return Intl.message(
      'Enter your account email and choose a new password.',
      name: 'forgot_password_description',
      desc: '',
      args: [],
    );
  }

  /// `Change password`
  String get forgot_password_button {
    return Intl.message(
      'Change password',
      name: 'forgot_password_button',
      desc: '',
      args: [],
    );
  }

  /// `Password updated`
  String get forgot_password_success_title {
    return Intl.message(
      'Password updated',
      name: 'forgot_password_success_title',
      desc: '',
      args: [],
    );
  }

  /// `Back to sign in`
  String get forgot_password_back_to_login {
    return Intl.message(
      'Back to sign in',
      name: 'forgot_password_back_to_login',
      desc: '',
      args: [],
    );
  }

  /// `New password`
  String get new_password {
    return Intl.message(
      'New password',
      name: 'new_password',
      desc: '',
      args: [],
    );
  }

  /// `Confirm password`
  String get confirm_password {
    return Intl.message(
      'Confirm password',
      name: 'confirm_password',
      desc: '',
      args: [],
    );
  }

  /// `Please confirm your password`
  String get confirm_password_required_error {
    return Intl.message(
      'Please confirm your password',
      name: 'confirm_password_required_error',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get confirm_password_mismatch_error {
    return Intl.message(
      'Passwords do not match',
      name: 'confirm_password_mismatch_error',
      desc: '',
      args: [],
    );
  }

  /// `Create Account`
  String get create_account {
    return Intl.message(
      'Create Account',
      name: 'create_account',
      desc: '',
      args: [],
    );
  }

  /// `Begin Your Journey`
  String get begin_your_journey {
    return Intl.message(
      'Begin Your Journey',
      name: 'begin_your_journey',
      desc: '',
      args: [],
    );
  }

  /// `Join thousands of others tracking their path to emotional wellness.`
  String get signup_subtitle {
    return Intl.message(
      'Join thousands of others tracking their path to emotional wellness.',
      name: 'signup_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Full Name`
  String get full_name {
    return Intl.message('Full Name', name: 'full_name', desc: '', args: []);
  }

  /// `John Doe`
  String get full_name_hint {
    return Intl.message('John Doe', name: 'full_name_hint', desc: '', args: []);
  }

  /// `Full name is required`
  String get full_name_required_error {
    return Intl.message(
      'Full name is required',
      name: 'full_name_required_error',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get error_title {
    return Intl.message('Error', name: 'error_title', desc: '', args: []);
  }

  /// `You must accept the terms to continue.`
  String get accept_terms_error {
    return Intl.message(
      'You must accept the terms to continue.',
      name: 'accept_terms_error',
      desc: '',
      args: [],
    );
  }

  /// `Create My Account`
  String get create_my_account {
    return Intl.message(
      'Create My Account',
      name: 'create_my_account',
      desc: '',
      args: [],
    );
  }

  /// `Or join with`
  String get or_join_with {
    return Intl.message(
      'Or join with',
      name: 'or_join_with',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account? `
  String get already_have_account {
    return Intl.message(
      'Already have an account? ',
      name: 'already_have_account',
      desc: '',
      args: [],
    );
  }

  /// `Log In`
  String get log_in {
    return Intl.message('Log In', name: 'log_in', desc: '', args: []);
  }

  /// `I agree to the {terms} and {privacy}.`
  String accept_terms(Object terms, Object privacy) {
    return Intl.message(
      'I agree to the $terms and $privacy.',
      name: 'accept_terms',
      desc: 'Checkbox text for accepting terms and privacy policy.',
      args: [terms, privacy],
    );
  }

  /// `Terms of Service`
  String get terms_of_service {
    return Intl.message(
      'Terms of Service',
      name: 'terms_of_service',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get privacy_policy {
    return Intl.message(
      'Privacy Policy',
      name: 'privacy_policy',
      desc: '',
      args: [],
    );
  }

  /// `Good morning, {name}`
  String home_greeting(Object name) {
    return Intl.message(
      'Good morning, $name',
      name: 'home_greeting',
      desc: '',
      args: [name],
    );
  }

  /// `How are you feeling right now?`
  String get home_subtitle_default {
    return Intl.message(
      'How are you feeling right now?',
      name: 'home_subtitle_default',
      desc: '',
      args: [],
    );
  }

  /// `Welcome back!`
  String get home_subtitle_logged_in {
    return Intl.message(
      'Welcome back!',
      name: 'home_subtitle_logged_in',
      desc: '',
      args: [],
    );
  }

  /// `Account created successfully.`
  String get home_subtitle_signed_up {
    return Intl.message(
      'Account created successfully.',
      name: 'home_subtitle_signed_up',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get auth_error_title {
    return Intl.message('Error', name: 'auth_error_title', desc: '', args: []);
  }

  /// `Unable to complete authentication.`
  String get auth_error_description {
    return Intl.message(
      'Unable to complete authentication.',
      name: 'auth_error_description',
      desc: '',
      args: [],
    );
  }

  /// `Success`
  String get auth_success_title {
    return Intl.message(
      'Success',
      name: 'auth_success_title',
      desc: '',
      args: [],
    );
  }

  /// `Registration completed successfully.`
  String get auth_signup_success_toast {
    return Intl.message(
      'Registration completed successfully.',
      name: 'auth_signup_success_toast',
      desc: '',
      args: [],
    );
  }

  /// `Signed in successfully.`
  String get auth_login_success_toast {
    return Intl.message(
      'Signed in successfully.',
      name: 'auth_login_success_toast',
      desc: '',
      args: [],
    );
  }

  /// `Log My Current Emotion`
  String get home_log_emotion_button {
    return Intl.message(
      'Log My Current Emotion',
      name: 'home_log_emotion_button',
      desc: '',
      args: [],
    );
  }

  /// `Today's Mood`
  String get home_today_mood_title {
    return Intl.message(
      'Today\'s Mood',
      name: 'home_today_mood_title',
      desc: '',
      args: [],
    );
  }

  /// `STABLE`
  String get home_mood_status_stable {
    return Intl.message(
      'STABLE',
      name: 'home_mood_status_stable',
      desc: '',
      args: [],
    );
  }

  /// `Primarily Positive`
  String get home_mood_primary_title {
    return Intl.message(
      'Primarily Positive',
      name: 'home_mood_primary_title',
      desc: '',
      args: [],
    );
  }

  /// `You've logged 3 entries today. Your average energy level is high.`
  String get home_mood_primary_description {
    return Intl.message(
      'You\'ve logged 3 entries today. Your average energy level is high.',
      name: 'home_mood_primary_description',
      desc: '',
      args: [],
    );
  }

  /// `View detailed analysis`
  String get home_view_detailed_analysis {
    return Intl.message(
      'View detailed analysis',
      name: 'home_view_detailed_analysis',
      desc: '',
      args: [],
    );
  }

  /// `Weekly Overview`
  String get home_weekly_overview_title {
    return Intl.message(
      'Weekly Overview',
      name: 'home_weekly_overview_title',
      desc: '',
      args: [],
    );
  }

  /// `"Your mood peaks during the weekend.\nTry to identify why!"`
  String get home_weekly_quote {
    return Intl.message(
      '"Your mood peaks during the weekend.\\nTry to identify why!"',
      name: 'home_weekly_quote',
      desc: '',
      args: [],
    );
  }

  /// `Streak: {count} day(s)`
  String home_streak_title(Object count) {
    return Intl.message(
      'Streak: $count day(s)',
      name: 'home_streak_title',
      desc: '',
      args: [count],
    );
  }

  /// `Best streak: {count} day(s)`
  String home_streak_best(Object count) {
    return Intl.message(
      'Best streak: $count day(s)',
      name: 'home_streak_best',
      desc: '',
      args: [count],
    );
  }

  /// `Log today to keep it going`
  String get home_streak_keep {
    return Intl.message(
      'Log today to keep it going',
      name: 'home_streak_keep',
      desc: '',
      args: [],
    );
  }

  /// `Log an emotion today to start your streak`
  String get home_streak_start {
    return Intl.message(
      'Log an emotion today to start your streak',
      name: 'home_streak_start',
      desc: '',
      args: [],
    );
  }

  /// `HOME`
  String get home_nav_home {
    return Intl.message('HOME', name: 'home_nav_home', desc: '', args: []);
  }

  /// `HISTORY`
  String get home_nav_history {
    return Intl.message(
      'HISTORY',
      name: 'home_nav_history',
      desc: '',
      args: [],
    );
  }

  /// `ANALYTICS`
  String get home_nav_analytics {
    return Intl.message(
      'ANALYTICS',
      name: 'home_nav_analytics',
      desc: '',
      args: [],
    );
  }

  /// `HABITS`
  String get home_nav_habits {
    return Intl.message('HABITS', name: 'home_nav_habits', desc: '', args: []);
  }

  /// `PROFILE`
  String get home_nav_profile {
    return Intl.message(
      'PROFILE',
      name: 'home_nav_profile',
      desc: '',
      args: [],
    );
  }

  /// `MON`
  String get home_weekday_mon {
    return Intl.message('MON', name: 'home_weekday_mon', desc: '', args: []);
  }

  /// `TUE`
  String get home_weekday_tue {
    return Intl.message('TUE', name: 'home_weekday_tue', desc: '', args: []);
  }

  /// `WED`
  String get home_weekday_wed {
    return Intl.message('WED', name: 'home_weekday_wed', desc: '', args: []);
  }

  /// `THU`
  String get home_weekday_thu {
    return Intl.message('THU', name: 'home_weekday_thu', desc: '', args: []);
  }

  /// `FRI`
  String get home_weekday_fri {
    return Intl.message('FRI', name: 'home_weekday_fri', desc: '', args: []);
  }

  /// `SAT`
  String get home_weekday_sat {
    return Intl.message('SAT', name: 'home_weekday_sat', desc: '', args: []);
  }

  /// `SUN`
  String get home_weekday_sun {
    return Intl.message('SUN', name: 'home_weekday_sun', desc: '', args: []);
  }

  /// `How are you feeling right now?`
  String get home_mood_entry_title {
    return Intl.message(
      'How are you feeling right now?',
      name: 'home_mood_entry_title',
      desc: '',
      args: [],
    );
  }

  /// `Good morning, {name}`
  String home_greeting_morning(Object name) {
    return Intl.message(
      'Good morning, $name',
      name: 'home_greeting_morning',
      desc: '',
      args: [name],
    );
  }

  /// `Good afternoon, {name}`
  String home_greeting_afternoon(Object name) {
    return Intl.message(
      'Good afternoon, $name',
      name: 'home_greeting_afternoon',
      desc: '',
      args: [name],
    );
  }

  /// `Good evening, {name}`
  String home_greeting_evening(Object name) {
    return Intl.message(
      'Good evening, $name',
      name: 'home_greeting_evening',
      desc: '',
      args: [name],
    );
  }

  /// `Daily Habits`
  String get home_daily_habits_title {
    return Intl.message(
      'Daily Habits',
      name: 'home_daily_habits_title',
      desc: '',
      args: [],
    );
  }

  /// `You do not have active habits yet.`
  String get home_empty_habits_message {
    return Intl.message(
      'You do not have active habits yet.',
      name: 'home_empty_habits_message',
      desc: '',
      args: [],
    );
  }

  /// `Recent Entries`
  String get home_recent_entries_title {
    return Intl.message(
      'Recent Entries',
      name: 'home_recent_entries_title',
      desc: '',
      args: [],
    );
  }

  /// `See all`
  String get home_see_all {
    return Intl.message('See all', name: 'home_see_all', desc: '', args: []);
  }

  /// `No emotions have been logged yet.`
  String get home_empty_entries_message {
    return Intl.message(
      'No emotions have been logged yet.',
      name: 'home_empty_entries_message',
      desc: '',
      args: [],
    );
  }

  /// `AI Manager`
  String get home_manager_ai {
    return Intl.message(
      'AI Manager',
      name: 'home_manager_ai',
      desc: '',
      args: [],
    );
  }

  /// `No additional notes.`
  String get home_entry_no_note {
    return Intl.message(
      'No additional notes.',
      name: 'home_entry_no_note',
      desc: '',
      args: [],
    );
  }

  /// `Yesterday`
  String get home_entry_yesterday {
    return Intl.message(
      'Yesterday',
      name: 'home_entry_yesterday',
      desc: '',
      args: [],
    );
  }

  /// `Retry`
  String get home_retry {
    return Intl.message('Retry', name: 'home_retry', desc: '', args: []);
  }

  /// `This section will be available soon.`
  String get home_section_soon_description {
    return Intl.message(
      'This section will be available soon.',
      name: 'home_section_soon_description',
      desc: '',
      args: [],
    );
  }

  /// `Sign out`
  String get home_logout_tooltip {
    return Intl.message(
      'Sign out',
      name: 'home_logout_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Signed out successfully.`
  String get home_logout_success {
    return Intl.message(
      'Signed out successfully.',
      name: 'home_logout_success',
      desc: '',
      args: [],
    );
  }

  /// `NEW DAY`
  String get home_status_new_day {
    return Intl.message(
      'NEW DAY',
      name: 'home_status_new_day',
      desc: '',
      args: [],
    );
  }

  /// `ELEVATED`
  String get home_status_elevated {
    return Intl.message(
      'ELEVATED',
      name: 'home_status_elevated',
      desc: '',
      args: [],
    );
  }

  /// `GENTLE`
  String get home_status_gentle {
    return Intl.message(
      'GENTLE',
      name: 'home_status_gentle',
      desc: '',
      args: [],
    );
  }

  /// `No entries yet`
  String get home_today_empty_title {
    return Intl.message(
      'No entries yet',
      name: 'home_today_empty_title',
      desc: '',
      args: [],
    );
  }

  /// `Start by logging how you feel to build your daily trend.`
  String get home_today_empty_description {
    return Intl.message(
      'Start by logging how you feel to build your daily trend.',
      name: 'home_today_empty_description',
      desc: '',
      args: [],
    );
  }

  /// `You've logged {count, plural, one{1 entry} other{{count} entries}} today. Your average energy level is {energy}.`
  String home_today_entries_description(num count, Object energy) {
    return Intl.message(
      'You\'ve logged ${Intl.plural(count, one: '1 entry', other: '$count entries')} today. Your average energy level is $energy.',
      name: 'home_today_entries_description',
      desc: '',
      args: [count, energy],
    );
  }

  /// `high`
  String get home_energy_high {
    return Intl.message('high', name: 'home_energy_high', desc: '', args: []);
  }

  /// `balanced`
  String get home_energy_balanced {
    return Intl.message(
      'balanced',
      name: 'home_energy_balanced',
      desc: '',
      args: [],
    );
  }

  /// `low`
  String get home_energy_low {
    return Intl.message('low', name: 'home_energy_low', desc: '', args: []);
  }

  /// `Profile`
  String get profile_title {
    return Intl.message('Profile', name: 'profile_title', desc: '', args: []);
  }

  /// `ACCOUNT SETTINGS`
  String get profile_account_settings {
    return Intl.message(
      'ACCOUNT SETTINGS',
      name: 'profile_account_settings',
      desc: '',
      args: [],
    );
  }

  /// `Preferences`
  String get profile_preferences {
    return Intl.message(
      'Preferences',
      name: 'profile_preferences',
      desc: '',
      args: [],
    );
  }

  /// `Notification Settings`
  String get profile_notification_settings {
    return Intl.message(
      'Notification Settings',
      name: 'profile_notification_settings',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get profile_language {
    return Intl.message(
      'Language',
      name: 'profile_language',
      desc: '',
      args: [],
    );
  }

  /// `Privacy & Security`
  String get profile_privacy_security {
    return Intl.message(
      'Privacy & Security',
      name: 'profile_privacy_security',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get profile_logout {
    return Intl.message('Logout', name: 'profile_logout', desc: '', args: []);
  }

  /// `MindTrack v2.4.0 • Made with mindfulness`
  String get profile_footer_caption {
    return Intl.message(
      'MindTrack v2.4.0 • Made with mindfulness',
      name: 'profile_footer_caption',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get profile_language_english {
    return Intl.message(
      'English',
      name: 'profile_language_english',
      desc: '',
      args: [],
    );
  }

  /// `Spanish`
  String get profile_language_spanish {
    return Intl.message(
      'Spanish',
      name: 'profile_language_spanish',
      desc: '',
      args: [],
    );
  }

  /// `This option is available on Android settings.`
  String get profile_intent_android_only {
    return Intl.message(
      'This option is available on Android settings.',
      name: 'profile_intent_android_only',
      desc: '',
      args: [],
    );
  }

  /// `No app was available to open this link.`
  String get profile_intent_link_unavailable {
    return Intl.message(
      'No app was available to open this link.',
      name: 'profile_intent_link_unavailable',
      desc: '',
      args: [],
    );
  }

  /// `Analytics`
  String get analytics_title {
    return Intl.message(
      'Analytics',
      name: 'analytics_title',
      desc: '',
      args: [],
    );
  }

  /// `Emotional Frequency`
  String get analytics_frequency_title {
    return Intl.message(
      'Emotional Frequency',
      name: 'analytics_frequency_title',
      desc: '',
      args: [],
    );
  }

  /// `There is not enough data yet to calculate frequency.`
  String get analytics_frequency_empty {
    return Intl.message(
      'There is not enough data yet to calculate frequency.',
      name: 'analytics_frequency_empty',
      desc: '',
      args: [],
    );
  }

  /// `Habits vs Mood`
  String get analytics_habits_mood_title {
    return Intl.message(
      'Habits vs Mood',
      name: 'analytics_habits_mood_title',
      desc: '',
      args: [],
    );
  }

  /// `View habits`
  String get analytics_view_habits {
    return Intl.message(
      'View habits',
      name: 'analytics_view_habits',
      desc: '',
      args: [],
    );
  }

  /// `Weekly Summary`
  String get analytics_weekly_summary_title {
    return Intl.message(
      'Weekly Summary',
      name: 'analytics_weekly_summary_title',
      desc: '',
      args: [],
    );
  }

  /// `No dominant emotion yet`
  String get analytics_no_dominant_emotion {
    return Intl.message(
      'No dominant emotion yet',
      name: 'analytics_no_dominant_emotion',
      desc: '',
      args: [],
    );
  }

  /// `Keep logging emotions and habits to uncover patterns.`
  String get analytics_default_insight {
    return Intl.message(
      'Keep logging emotions and habits to uncover patterns.',
      name: 'analytics_default_insight',
      desc: '',
      args: [],
    );
  }

  /// `Logs`
  String get analytics_metric_logs {
    return Intl.message(
      'Logs',
      name: 'analytics_metric_logs',
      desc: '',
      args: [],
    );
  }

  /// `Intensity`
  String get analytics_metric_intensity {
    return Intl.message(
      'Intensity',
      name: 'analytics_metric_intensity',
      desc: '',
      args: [],
    );
  }

  /// `Habits`
  String get analytics_metric_habits {
    return Intl.message(
      'Habits',
      name: 'analytics_metric_habits',
      desc: '',
      args: [],
    );
  }

  /// `{count} logs`
  String analytics_records_count(Object count) {
    return Intl.message(
      '$count logs',
      name: 'analytics_records_count',
      desc: '',
      args: [count],
    );
  }

  /// `There is not enough data to relate habits and mood yet.`
  String get analytics_correlation_empty {
    return Intl.message(
      'There is not enough data to relate habits and mood yet.',
      name: 'analytics_correlation_empty',
      desc: '',
      args: [],
    );
  }

  /// `Week`
  String get analytics_range_week {
    return Intl.message(
      'Week',
      name: 'analytics_range_week',
      desc: '',
      args: [],
    );
  }

  /// `Month`
  String get analytics_range_month {
    return Intl.message(
      'Month',
      name: 'analytics_range_month',
      desc: '',
      args: [],
    );
  }

  /// `Year`
  String get analytics_range_year {
    return Intl.message(
      'Year',
      name: 'analytics_range_year',
      desc: '',
      args: [],
    );
  }

  /// `Emotional Trends`
  String get analytics_trends_title {
    return Intl.message(
      'Emotional Trends',
      name: 'analytics_trends_title',
      desc: '',
      args: [],
    );
  }

  /// `Weekly Mood Flow`
  String get analytics_mood_flow_label {
    return Intl.message(
      'Weekly Mood Flow',
      name: 'analytics_mood_flow_label',
      desc: '',
      args: [],
    );
  }

  /// `Average emotional intensity per day (1-10 scale)`
  String get analytics_mood_flow_caption {
    return Intl.message(
      'Average emotional intensity per day (1-10 scale)',
      name: 'analytics_mood_flow_caption',
      desc: '',
      args: [],
    );
  }

  /// `No intensity logs this week. Showing completed habits per day instead.`
  String get analytics_mood_flow_fallback_caption {
    return Intl.message(
      'No intensity logs this week. Showing completed habits per day instead.',
      name: 'analytics_mood_flow_fallback_caption',
      desc: '',
      args: [],
    );
  }

  /// `Mood Distribution`
  String get analytics_distribution_title {
    return Intl.message(
      'Mood Distribution',
      name: 'analytics_distribution_title',
      desc: '',
      args: [],
    );
  }

  /// `Patterns & Observations`
  String get analytics_patterns_title {
    return Intl.message(
      'Patterns & Observations',
      name: 'analytics_patterns_title',
      desc: '',
      args: [],
    );
  }

  /// `Top Day`
  String get analytics_top_day_label {
    return Intl.message(
      'Top Day',
      name: 'analytics_top_day_label',
      desc: '',
      args: [],
    );
  }

  /// `Best mood on {day}`
  String analytics_top_day_value(Object day) {
    return Intl.message(
      'Best mood on $day',
      name: 'analytics_top_day_value',
      desc: '',
      args: [day],
    );
  }

  /// `Habits`
  String get analytics_habits_card_label {
    return Intl.message(
      'Habits',
      name: 'analytics_habits_card_label',
      desc: '',
      args: [],
    );
  }

  /// `{pct}% completed`
  String analytics_habits_card_value(Object pct) {
    return Intl.message(
      '$pct% completed',
      name: 'analytics_habits_card_value',
      desc: '',
      args: [pct],
    );
  }

  /// `Weekly Insight`
  String get analytics_insight_title {
    return Intl.message(
      'Weekly Insight',
      name: 'analytics_insight_title',
      desc: '',
      args: [],
    );
  }

  /// `Read more insights`
  String get analytics_read_more {
    return Intl.message(
      'Read more insights',
      name: 'analytics_read_more',
      desc: '',
      args: [],
    );
  }

  /// `Not enough data`
  String get analytics_no_data_short {
    return Intl.message(
      'Not enough data',
      name: 'analytics_no_data_short',
      desc: '',
      args: [],
    );
  }

  /// `Habits`
  String get habits_title {
    return Intl.message('Habits', name: 'habits_title', desc: '', args: []);
  }

  /// `New habit`
  String get habits_new_button {
    return Intl.message(
      'New habit',
      name: 'habits_new_button',
      desc: '',
      args: [],
    );
  }

  /// `You do not have active habits yet.`
  String get habits_empty_title {
    return Intl.message(
      'You do not have active habits yet.',
      name: 'habits_empty_title',
      desc: '',
      args: [],
    );
  }

  /// `Create one to start measuring consistency and its relationship with your mood.`
  String get habits_empty_description {
    return Intl.message(
      'Create one to start measuring consistency and its relationship with your mood.',
      name: 'habits_empty_description',
      desc: '',
      args: [],
    );
  }

  /// `Create habit`
  String get habits_create_title {
    return Intl.message(
      'Create habit',
      name: 'habits_create_title',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get habits_name_label {
    return Intl.message('Name', name: 'habits_name_label', desc: '', args: []);
  }

  /// `Enter a name.`
  String get habits_name_error {
    return Intl.message(
      'Enter a name.',
      name: 'habits_name_error',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get habits_description_label {
    return Intl.message(
      'Description',
      name: 'habits_description_label',
      desc: '',
      args: [],
    );
  }

  /// `Category`
  String get habits_category_label {
    return Intl.message(
      'Category',
      name: 'habits_category_label',
      desc: '',
      args: [],
    );
  }

  /// `Health`
  String get habits_category_health {
    return Intl.message(
      'Health',
      name: 'habits_category_health',
      desc: '',
      args: [],
    );
  }

  /// `Mind`
  String get habits_category_mind {
    return Intl.message(
      'Mind',
      name: 'habits_category_mind',
      desc: '',
      args: [],
    );
  }

  /// `Social`
  String get habits_category_social {
    return Intl.message(
      'Social',
      name: 'habits_category_social',
      desc: '',
      args: [],
    );
  }

  /// `Productivity`
  String get habits_category_productivity {
    return Intl.message(
      'Productivity',
      name: 'habits_category_productivity',
      desc: '',
      args: [],
    );
  }

  /// `Other`
  String get habits_category_other {
    return Intl.message(
      'Other',
      name: 'habits_category_other',
      desc: '',
      args: [],
    );
  }

  /// `Daily Progress`
  String get habits_daily_progress_title {
    return Intl.message(
      'Daily Progress',
      name: 'habits_daily_progress_title',
      desc: '',
      args: [],
    );
  }

  /// `You've completed {completed} of {total} habits today!`
  String habits_daily_progress_message(Object completed, Object total) {
    return Intl.message(
      'You\'ve completed $completed of $total habits today!',
      name: 'habits_daily_progress_message',
      desc: '',
      args: [completed, total],
    );
  }

  /// `Consistency is the key to mental clarity.`
  String get habits_daily_progress_subtitle {
    return Intl.message(
      'Consistency is the key to mental clarity.',
      name: 'habits_daily_progress_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Insights`
  String get habits_insights_button {
    return Intl.message(
      'Insights',
      name: 'habits_insights_button',
      desc: '',
      args: [],
    );
  }

  /// `Today's Habits`
  String get habits_today_title {
    return Intl.message(
      'Today\'s Habits',
      name: 'habits_today_title',
      desc: '',
      args: [],
    );
  }

  /// `e.g., Drink Water`
  String get habits_name_hint {
    return Intl.message(
      'e.g., Drink Water',
      name: 'habits_name_hint',
      desc: '',
      args: [],
    );
  }

  /// `Choose Icon`
  String get habits_icon_label {
    return Intl.message(
      'Choose Icon',
      name: 'habits_icon_label',
      desc: '',
      args: [],
    );
  }

  /// `Frequency`
  String get habits_frequency_label {
    return Intl.message(
      'Frequency',
      name: 'habits_frequency_label',
      desc: '',
      args: [],
    );
  }

  /// `Daily`
  String get habits_frequency_daily {
    return Intl.message(
      'Daily',
      name: 'habits_frequency_daily',
      desc: '',
      args: [],
    );
  }

  /// `Weekly`
  String get habits_frequency_weekly {
    return Intl.message(
      'Weekly',
      name: 'habits_frequency_weekly',
      desc: '',
      args: [],
    );
  }

  /// `Custom`
  String get habits_frequency_custom {
    return Intl.message(
      'Custom',
      name: 'habits_frequency_custom',
      desc: '',
      args: [],
    );
  }

  /// `Create Habit`
  String get habits_create_button {
    return Intl.message(
      'Create Habit',
      name: 'habits_create_button',
      desc: '',
      args: [],
    );
  }

  /// `Edit Habit`
  String get habits_edit_title {
    return Intl.message(
      'Edit Habit',
      name: 'habits_edit_title',
      desc: '',
      args: [],
    );
  }

  /// `Save Changes`
  String get habits_save_changes {
    return Intl.message(
      'Save Changes',
      name: 'habits_save_changes',
      desc: '',
      args: [],
    );
  }

  /// `Select at least one day.`
  String get habits_days_error {
    return Intl.message(
      'Select at least one day.',
      name: 'habits_days_error',
      desc: '',
      args: [],
    );
  }

  /// `Days per week: {days}`
  String habits_days_per_week(Object days) {
    return Intl.message(
      'Days per week: $days',
      name: 'habits_days_per_week',
      desc: '',
      args: [days],
    );
  }

  /// `Save`
  String get habits_save {
    return Intl.message('Save', name: 'habits_save', desc: '', args: []);
  }

  /// `Weekly target: {days} days`
  String habits_weekly_target(Object days) {
    return Intl.message(
      'Weekly target: $days days',
      name: 'habits_weekly_target',
      desc: '',
      args: [days],
    );
  }

  /// `Search`
  String get search_title {
    return Intl.message('Search', name: 'search_title', desc: '', args: []);
  }

  /// `Search emotions, notes, or habits`
  String get search_hint {
    return Intl.message(
      'Search emotions, notes, or habits',
      name: 'search_hint',
      desc: '',
      args: [],
    );
  }

  /// `Habits`
  String get search_habits_title {
    return Intl.message(
      'Habits',
      name: 'search_habits_title',
      desc: '',
      args: [],
    );
  }

  /// `No matching habits were found.`
  String get search_habits_empty {
    return Intl.message(
      'No matching habits were found.',
      name: 'search_habits_empty',
      desc: '',
      args: [],
    );
  }

  /// `Emotions`
  String get search_emotions_title {
    return Intl.message(
      'Emotions',
      name: 'search_emotions_title',
      desc: '',
      args: [],
    );
  }

  /// `No matching emotions were found.`
  String get search_emotions_empty {
    return Intl.message(
      'No matching emotions were found.',
      name: 'search_emotions_empty',
      desc: '',
      args: [],
    );
  }

  /// `No detail`
  String get search_no_detail {
    return Intl.message(
      'No detail',
      name: 'search_no_detail',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notifications_title {
    return Intl.message(
      'Notifications',
      name: 'notifications_title',
      desc: '',
      args: [],
    );
  }

  /// `Reminders active`
  String get notifications_active_title {
    return Intl.message(
      'Reminders active',
      name: 'notifications_active_title',
      desc: '',
      args: [],
    );
  }

  /// `Your reminders are enabled from preferences.`
  String get notifications_active_description {
    return Intl.message(
      'Your reminders are enabled from preferences.',
      name: 'notifications_active_description',
      desc: '',
      args: [],
    );
  }

  /// `Reminders disabled`
  String get notifications_inactive_title {
    return Intl.message(
      'Reminders disabled',
      name: 'notifications_inactive_title',
      desc: '',
      args: [],
    );
  }

  /// `Enable notifications in your profile to receive reminders.`
  String get notifications_inactive_description {
    return Intl.message(
      'Enable notifications in your profile to receive reminders.',
      name: 'notifications_inactive_description',
      desc: '',
      args: [],
    );
  }

  /// `Mood log up to date`
  String get notifications_mood_logged_title {
    return Intl.message(
      'Mood log up to date',
      name: 'notifications_mood_logged_title',
      desc: '',
      args: [],
    );
  }

  /// `You still need to log how you feel today`
  String get notifications_mood_missing_title {
    return Intl.message(
      'You still need to log how you feel today',
      name: 'notifications_mood_missing_title',
      desc: '',
      args: [],
    );
  }

  /// `You already logged at least one emotion today. Nice work.`
  String get notifications_mood_logged_description {
    return Intl.message(
      'You already logged at least one emotion today. Nice work.',
      name: 'notifications_mood_logged_description',
      desc: '',
      args: [],
    );
  }

  /// `Logging an emotion today helps improve your weekly insights.`
  String get notifications_mood_missing_description {
    return Intl.message(
      'Logging an emotion today helps improve your weekly insights.',
      name: 'notifications_mood_missing_description',
      desc: '',
      args: [],
    );
  }

  /// `All clear with your habits`
  String get notifications_habits_clear_title {
    return Intl.message(
      'All clear with your habits',
      name: 'notifications_habits_clear_title',
      desc: '',
      args: [],
    );
  }

  /// `You do not have habits pending today, or you already completed them all.`
  String get notifications_habits_clear_description {
    return Intl.message(
      'You do not have habits pending today, or you already completed them all.',
      name: 'notifications_habits_clear_description',
      desc: '',
      args: [],
    );
  }

  /// `Pending: {name}`
  String notifications_pending_title(Object name) {
    return Intl.message(
      'Pending: $name',
      name: 'notifications_pending_title',
      desc: '',
      args: [name],
    );
  }

  /// `You have not marked this habit today yet. You are at {completed}/{target} this week.`
  String notifications_pending_description(Object completed, Object target) {
    return Intl.message(
      'You have not marked this habit today yet. You are at $completed/$target this week.',
      name: 'notifications_pending_description',
      desc: '',
      args: [completed, target],
    );
  }

  /// `MindTrack Coach`
  String get coach_title {
    return Intl.message(
      'MindTrack Coach',
      name: 'coach_title',
      desc: '',
      args: [],
    );
  }

  /// `AI Coach`
  String get coach_hero_label {
    return Intl.message(
      'AI Coach',
      name: 'coach_hero_label',
      desc: '',
      args: [],
    );
  }

  /// `Actionable suggestions based on your recent activity.`
  String get coach_hero_description {
    return Intl.message(
      'Actionable suggestions based on your recent activity.',
      name: 'coach_hero_description',
      desc: '',
      args: [],
    );
  }

  /// `There are still few logs this week. Try noting at least one emotion in the morning and one at night to improve your patterns.`
  String get coach_insight_low_logs {
    return Intl.message(
      'There are still few logs this week. Try noting at least one emotion in the morning and one at night to improve your patterns.',
      name: 'coach_insight_low_logs',
      desc: '',
      args: [],
    );
  }

  /// `Your average emotional intensity is trending high. Consider a short pause today: guided breathing, a short walk, or journaling.`
  String get coach_insight_high_intensity {
    return Intl.message(
      'Your average emotional intensity is trending high. Consider a short pause today: guided breathing, a short walk, or journaling.',
      name: 'coach_insight_high_intensity',
      desc: '',
      args: [],
    );
  }

  /// `Your habit consistency is below 50%. Focus on completing just one key habit today to regain traction.`
  String get coach_insight_low_habits {
    return Intl.message(
      'Your habit consistency is below 50%. Focus on completing just one key habit today to regain traction.',
      name: 'coach_insight_low_habits',
      desc: '',
      args: [],
    );
  }

  /// `You still have {count} habit(s) pending today. The easiest one to complete right now may give you a useful momentum boost.`
  String coach_insight_pending_habits(Object count) {
    return Intl.message(
      'You still have $count habit(s) pending today. The easiest one to complete right now may give you a useful momentum boost.',
      name: 'coach_insight_pending_habits',
      desc: '',
      args: [count],
    );
  }

  /// `Your most frequent recent emotion is {name}. It is worth checking what activities or people usually appear alongside it.`
  String coach_insight_top_emotion(Object name) {
    return Intl.message(
      'Your most frequent recent emotion is $name. It is worth checking what activities or people usually appear alongside it.',
      name: 'coach_insight_top_emotion',
      desc: '',
      args: [name],
    );
  }

  /// `Your metrics look balanced. Keep the rhythm and review your most consistent habits to reinforce what is already working.`
  String get coach_insight_balanced {
    return Intl.message(
      'Your metrics look balanced. Keep the rhythm and review your most consistent habits to reinforce what is already working.',
      name: 'coach_insight_balanced',
      desc: '',
      args: [],
    );
  }

  /// `Logs`
  String get coach_stat_logs {
    return Intl.message('Logs', name: 'coach_stat_logs', desc: '', args: []);
  }

  /// `Intensity`
  String get coach_stat_intensity {
    return Intl.message(
      'Intensity',
      name: 'coach_stat_intensity',
      desc: '',
      args: [],
    );
  }

  /// `Habits`
  String get coach_stat_habits {
    return Intl.message(
      'Habits',
      name: 'coach_stat_habits',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'es'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
