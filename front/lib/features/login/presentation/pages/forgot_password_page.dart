import 'package:flutter/material.dart';
import 'package:mind_track/app/theme/mt_colors.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:mind_track/app/generated/l10n.dart';
import 'package:mind_track/app/injector.dart';
import 'package:mind_track/app/theme/app_colors.dart';
import 'package:mind_track/features/login/domain/repositories/auth_repository.dart';
import 'package:mind_track/features/login/presentation/widgets/email_text_field.dart';
import 'package:mind_track/features/login/presentation/widgets/password_text_field.dart';

/// Página para cambiar la contraseña directamente a partir del correo,
/// sin envío de correo de verificación.
class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final AuthRepository _authRepository = Injector.get<AuthRepository>();
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  bool _isSending = false;
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;
  String? _successMessage;

  @override
  Widget build(BuildContext context) {
    final S translations = S.of(context);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(translations.forgot_password_title),
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
          child: _successMessage == null
              ? _buildForm(translations)
              : _buildSuccess(translations),
        ),
      ),
    );
  }

  Widget _buildForm(S translations) {
    return FormBuilder(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.lock_reset_rounded,
                size: 36,
                color: AppColors.primary,
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            translations.forgot_password_description,
            style: TextStyle(
              fontSize: 15,
              height: 1.5,
              color: context.mtColors.textSecondary,
            ),
          ),
          const SizedBox(height: 28),
          Text(
            translations.email_address,
            style: TextStyle(
              fontSize: 15,
              color: context.mtColors.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          EmailTextField(
            hintText: translations.email_address,
            requiredErrorText: translations.email_required_error,
            invalidErrorText: translations.email_invalid_error,
          ),
          const SizedBox(height: 20),
          Text(
            translations.new_password,
            style: TextStyle(
              fontSize: 15,
              color: context.mtColors.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          PasswordTextField(
            name: 'new_password',
            hintText: translations.new_password,
            obscureText: _obscureNewPassword,
            onToggleVisibility: () {
              setState(() => _obscureNewPassword = !_obscureNewPassword);
            },
            requiredErrorText: translations.password_required_error,
            minLengthErrorText: translations.password_min_length_error,
            uppercaseErrorText: translations.password_uppercase_error,
            lowercaseErrorText: translations.password_lowercase_error,
            numberErrorText: translations.password_number_error,
            specialCharacterErrorText: translations.password_special_char_error,
          ),
          const SizedBox(height: 20),
          Text(
            translations.confirm_password,
            style: TextStyle(
              fontSize: 15,
              color: context.mtColors.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          FormBuilderTextField(
            name: 'confirm_password',
            obscureText: _obscureConfirmPassword,
            textInputAction: TextInputAction.done,
            onTapOutside: (_) => FocusScope.of(context).unfocus(),
            validator: FormBuilderValidators.compose(<FormFieldValidator<String>>[
              FormBuilderValidators.required(
                errorText: translations.confirm_password_required_error,
              ),
              (String? value) {
                final String newPassword =
                    _formKey.currentState?.fields['new_password']?.value
                        as String? ??
                    '';
                return value == newPassword
                    ? null
                    : translations.confirm_password_mismatch_error;
              },
            ]),
            decoration: InputDecoration(
              hintText: translations.confirm_password,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: context.mtColors.card,
              prefixIcon: const Icon(Icons.lock_outline),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureConfirmPassword
                      ? Icons.visibility_off
                      : Icons.visibility,
                ),
                onPressed: () {
                  setState(
                    () => _obscureConfirmPassword = !_obscureConfirmPassword,
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 28),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: _isSending ? null : _submit,
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              child: _isSending
                  ? const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : Text(
                      translations.forgot_password_button,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccess(S translations) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 32),
        Container(
          width: 72,
          height: 72,
          decoration: const BoxDecoration(
            color: Color(0xFFDCFCE7),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.mark_email_read_outlined,
            size: 36,
            color: Color(0xFF16A34A),
          ),
        ),
        const SizedBox(height: 24),
        Text(
          translations.forgot_password_success_title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Color(0xFF0F172A),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          _successMessage!,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15,
            height: 1.5,
            color: context.mtColors.textSecondary,
          ),
        ),
        const SizedBox(height: 32),
        SizedBox(
          width: double.infinity,
          child: FilledButton(
            onPressed: () => Navigator.of(context).pop(),
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.primary,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            child: Text(
              translations.forgot_password_back_to_login,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _submit() async {
    if (_formKey.currentState?.saveAndValidate() != true) {
      return;
    }
    final Map<String, dynamic> formData = _formKey.currentState!.value;
    final String email = (formData['email'] as String? ?? '').trim();
    final String newPassword = (formData['new_password'] as String? ?? '');

    setState(() => _isSending = true);
    try {
      final String message = await _authRepository.forgotPassword(
        email: email,
        newPassword: newPassword,
      );
      if (!mounted) {
        return;
      }
      setState(() {
        _isSending = false;
        _successMessage = message;
      });
    } catch (error) {
      if (!mounted) {
        return;
      }
      setState(() => _isSending = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.toString().replaceFirst('Exception: ', '')),
        ),
      );
    }
  }
}
