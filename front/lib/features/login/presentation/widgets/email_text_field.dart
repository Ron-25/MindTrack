import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class EmailTextField extends StatelessWidget {
  const EmailTextField({
    required this.hintText,
    required this.requiredErrorText,
    required this.invalidErrorText,
    super.key,
    this.name = 'email',
  });

  final String name;
  final String hintText;
  final String requiredErrorText;
  final String invalidErrorText;

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: name,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onTapOutside: (_) => FocusScope.of(context).unfocus(),
      validator: FormBuilderValidators.compose(<FormFieldValidator<String>>[
        FormBuilderValidators.required(errorText: requiredErrorText),
        FormBuilderValidators.email(errorText: invalidErrorText),
      ]),
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.white,
        prefixIcon: const Icon(Icons.mail_outline),
      ),
    );
  }
}
