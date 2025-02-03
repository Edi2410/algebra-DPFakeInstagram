import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dp_project/core/di.dart';
import 'package:dp_project/feature/common/presentation/widget/custom_primary_button.dart';
import 'package:dp_project/feature/common/presentation/widget/custom_text_field.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ResetPasswordForm extends HookConsumerWidget {
  const ResetPasswordForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formGroup = FormGroup({
      'email': FormControl<String>(
        validators: [Validators.required, Validators.email],
      ),
    });

    return ReactiveForm(
      formGroup: formGroup,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(children: [
          CustomTextField(
            formControlName: 'email',
            labelText: 'Email',
            validationMessages: {
              ValidationMessage.email: (_) => 'Please enter a valid email',
              ValidationMessage.required: (_) => 'Please enter your email',
            },
          ),
          const SizedBox(height: 20),
          CustomPrimaryButton(
            labelText: 'Reset password',
            onPressed: () {
              formGroup.markAllAsTouched();
              if (formGroup.valid) {
                ref.read(authNotifierProvider.notifier).resetPassword(
                  context,
                  formGroup.control('email').value,
                );
              }
            },
          ),
        ]),
      ),
    );
  }
}
