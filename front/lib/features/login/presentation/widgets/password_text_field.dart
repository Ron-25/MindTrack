import 'package:flutter/material.dart';
import 'package:mind_track/app/theme/mt_colors.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class PasswordTextField extends StatelessWidget {
  const PasswordTextField({
    required this.hintText,
    required this.obscureText,
    required this.onToggleVisibility,
    required this.requiredErrorText,
    required this.minLengthErrorText,
    required this.uppercaseErrorText,
    required this.lowercaseErrorText,
    required this.numberErrorText,
    required this.specialCharacterErrorText,
    super.key,
    this.name = 'password',
  });

  final String name;
  final String hintText;
  final bool obscureText;
  final VoidCallback onToggleVisibility;
  final String requiredErrorText;
  final String minLengthErrorText;
  final String uppercaseErrorText;
  final String lowercaseErrorText;
  final String numberErrorText;
  final String specialCharacterErrorText;

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: name,
      obscureText: obscureText,
      textInputAction: TextInputAction.done,
      onTapOutside: (_) => FocusScope.of(context).unfocus(),
      validator: FormBuilderValidators.compose(<FormFieldValidator<String>>[
        FormBuilderValidators.required(errorText: requiredErrorText),
        FormBuilderValidators.minLength(8, errorText: minLengthErrorText),
        FormBuilderValidators.match(
          RegExp(r'(?=.*[A-Z])'),
          errorText: uppercaseErrorText,
        ),
        FormBuilderValidators.match(
          RegExp(r'(?=.*[a-z])'),
          errorText: lowercaseErrorText,
        ),
        FormBuilderValidators.match(
          RegExp(r'(?=.*[0-9])'),
          errorText: numberErrorText,
        ),
        FormBuilderValidators.match(
          RegExp(r'(?=.*[!@#$%^&*(),.?":{}|<>])'),
          errorText: specialCharacterErrorText,
        ),
      ]),
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: context.mtColors.card,
        prefixIcon: const Icon(Icons.lock_outline),
        suffixIcon: IconButton(
          icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility),
          onPressed: onToggleVisibility,
        ),
      ),
    );
  }
}
