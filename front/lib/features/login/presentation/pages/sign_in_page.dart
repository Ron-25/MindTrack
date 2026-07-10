import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:mind_track/app/generated/l10n.dart';
import 'package:mind_track/app/injector.dart';
import 'package:mind_track/app/routes/route_names.dart';
import 'package:mind_track/core/utils/toast_utils.dart';
import 'package:mind_track/app/theme/app_colors.dart';
import 'package:mind_track/features/login/presentation/blocs/login_bloc.dart';
import 'package:mind_track/features/login/presentation/blocs/login_event.dart';
import 'package:mind_track/features/login/presentation/blocs/login_state.dart';
import 'package:mind_track/features/login/presentation/widgets/email_text_field.dart';
import 'package:mind_track/features/login/presentation/widgets/password_text_field.dart';
import 'package:mind_track/shared/widget/app_circle_icon.dart';
import 'package:mind_track/shared/widget/app_primary_button.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> with WidgetsBindingObserver {
  bool _obscurePassword = true;
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  double _lastKeyboardInset = 0;
  final LoginBloc loginBloc = Injector.get<LoginBloc>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _lastKeyboardInset = WidgetsBinding
        .instance
        .platformDispatcher
        .views
        .first
        .viewInsets
        .bottom;
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    final double currentInset = WidgetsBinding
        .instance
        .platformDispatcher
        .views
        .first
        .viewInsets
        .bottom;
    if (_lastKeyboardInset > 0 && currentInset == 0) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
    _lastKeyboardInset = currentInset;
  }

  @override
  Widget build(BuildContext context) {
    final S translations = S.of(context);
    return BlocListener<LoginBloc, LoginState>(
      bloc: loginBloc,
      listenWhen: (LoginState previous, LoginState current) {
        return previous.logIn != current.logIn ||
            previous.errorMessage != current.errorMessage;
      },
      listener: (BuildContext context, LoginState state) {
        if (state.logIn) {
          Navigator.of(context).pushReplacementNamed(RouteNames.home);
        }
        if (state.isFailure && state.errorMessage != null) {
          ThToast.error(
            context: context,
            title: translations.error_title,
            description: state.errorMessage!,
            margin: const EdgeInsets.only(left: 60, right: 20),
            applyBlurEffect: false,
          );
        }
      },
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
          systemNavigationBarColor: AppColors.background,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
        child: Scaffold(
          appBar: AppBar(
            title: Text(translations.sign_in),
            centerTitle: true,
            backgroundColor: AppColors.background,
          ),
          backgroundColor: AppColors.background,
          body: FormBuilder(
            key: _formKey,
            child: ListView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              physics: const AlwaysScrollableScrollPhysics(),
              children: <Widget>[
                Divider(
                  color: Colors.grey.withOpacity(0.5),
                  height: 1,
                  thickness: 1,
                ),
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    gradient: AppColors.splashGradient,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(height: 35),
                      const Center(
                        child: AppCircleIcon(icon: Icons.bolt_rounded),
                      ),
                      const SizedBox(height: 10),
                      Center(
                        child: Text(
                          translations.sign_in,
                          style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        translations.login_subtitle,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 15,
                          height: 1.7,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 40),
                      Padding(
                        padding: const EdgeInsets.only(left: 40, right: 40),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              translations.email_address,
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                fontSize: 15,
                                color: AppColors.textSecondary,
                              ),
                            ),
                            const SizedBox(height: 8),
                            EmailTextField(
                              hintText: translations.email_address,
                              requiredErrorText:
                                  translations.email_required_error,
                              invalidErrorText:
                                  translations.email_invalid_error,
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: <Widget>[
                                Text(
                                  translations.password,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                                const Spacer(),
                                TextButton(
                                  onPressed: () => Navigator.of(
                                    context,
                                  ).pushNamed(RouteNames.forgotPassword),
                                  child: Text(
                                    translations.forgot_password,
                                    style: const TextStyle(
                                      color: AppColors.primary,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            //const SizedBox(height: 8),
                            PasswordTextField(
                              hintText: translations.password,
                              obscureText: _obscurePassword,
                              onToggleVisibility: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                              requiredErrorText:
                                  translations.password_required_error,
                              minLengthErrorText:
                                  translations.password_min_length_error,
                              uppercaseErrorText:
                                  translations.password_uppercase_error,
                              lowercaseErrorText:
                                  translations.password_lowercase_error,
                              numberErrorText:
                                  translations.password_number_error,
                              specialCharacterErrorText:
                                  translations.password_special_char_error,
                            ),
                            const SizedBox(height: 24),
                            BlocBuilder<LoginBloc, LoginState>(
                              bloc: loginBloc,
                              buildWhen: (LoginState prev, LoginState curr) =>
                                  prev.isSubmitting != curr.isSubmitting,
                              builder:
                                  (
                                    BuildContext context,
                                    LoginState state,
                                  ) => AppPrimaryButton(
                                    text: translations.sign_in_button,
                                    isLoading: state.isSubmitting,
                                    onPressed: () {
                                      if (_formKey.currentState
                                              ?.saveAndValidate() ??
                                          false) {
                                        final Map<String, dynamic> formData =
                                            _formKey.currentState!.value;
                                        loginBloc.add(
                                          LoginEmailChanged(
                                            (formData['email'] as String?) ??
                                                '',
                                          ),
                                        );
                                        loginBloc.add(
                                          LoginPasswordChanged(
                                            (formData['password'] as String?) ??
                                                '',
                                          ),
                                        );
                                        loginBloc.add(LoginSubmitted());
                                      }
                                    },
                                    padding: EdgeInsets.zero,
                                  ),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Divider(
                                    color: Colors.grey.withOpacity(0.5),
                                    thickness: 1,
                                    endIndent: 10,
                                  ),
                                ),
                                Text(
                                  translations.or_continue_with,
                                  style: TextStyle(
                                    color: Colors.grey[700],
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                  ),
                                ),
                                Expanded(
                                  child: Divider(
                                    color: Colors.grey.withOpacity(0.5),
                                    thickness: 1,
                                    indent: 10,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                side: BorderSide(color: Colors.grey.shade300),
                                backgroundColor: Colors.white,
                                elevation: 0,
                              ),
                              onPressed: () {},
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Image.network(
                                    'https://www.keyweo.com/wp-content/uploads/2022/03/el-logo-g-de-google.png',
                                    height: 50,
                                    width: 50,
                                  ),
                                  Text(
                                    translations.continue_with_google,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            translations.dont_have_account,
                            style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 15,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(
                                context,
                              ).pushNamed(RouteNames.signUp);
                            },
                            child: Text(
                              translations.sign_up,
                              style: const TextStyle(
                                color: Colors.cyanAccent,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
