import 'package:control_style/control_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dp_project/core/style/style_extensions.dart';
import 'package:reactive_forms/reactive_forms.dart';

class CustomDropdownField extends HookConsumerWidget {
  final String labelText;
  final String formControlName;
  final List<DropdownMenuItem> items;
  final Map<String, String Function(Object)>? validationMessages;
  final bool isPasswordField;

  const CustomDropdownField({
    super.key,
    required this.labelText,
    required this.items,
    required this.formControlName,
    this.validationMessages,
    this.isPasswordField = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        ReactiveDropdownField(
          formControlName: formControlName,
          items: items,
          decoration: InputDecoration(
            errorStyle: context.textError.copyWith(
              color: context.errorColor,
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            border: DecoratedInputBorder(
              child: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide.none,
              ),
              shadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 10,
                  offset: const Offset(0, 0),
                ),
              ],
            ),
            hintText: labelText,
            filled: true,
            fillColor: Colors.white,
          ),
          validationMessages: validationMessages,
        )
      ],
    );
  }
}
