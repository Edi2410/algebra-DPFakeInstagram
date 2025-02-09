import 'package:control_style/control_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dp_project/core/style/style_extensions.dart';
import 'package:reactive_forms/reactive_forms.dart';

class CustomTextField extends HookConsumerWidget {
  final String labelText;
  final String formControlName;
  final Map<String, String Function(Object)>? validationMessages;
  final bool isPasswordField;
  final Function(FormControl<dynamic>)? onChanged;
  final TextEditingController? controller;

  const CustomTextField({
    super.key,
    required this.labelText,
    required this.formControlName,
    this.onChanged,
    this.validationMessages,
    this.isPasswordField = false,
    this.controller,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        ReactiveTextField(
          controller: controller,
          formControlName: formControlName,
          autocorrect: !isPasswordField,
          obscureText: isPasswordField,
          enableSuggestions: !isPasswordField,
          onChanged: onChanged,
          decoration: InputDecoration(
            errorStyle: context.textError.copyWith(
              color: context.errorColor,
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 20,
                vertical: 5),
            border: DecoratedInputBorder(

              child: OutlineInputBorder(

                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide.none,
              ),
              shadow: [BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 10,
                offset: const Offset(0, 0),
              ),],
            ),
            hintText: labelText,

          ),
          validationMessages: validationMessages,
        ),
      ],
    );


  }
}
