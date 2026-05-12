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
