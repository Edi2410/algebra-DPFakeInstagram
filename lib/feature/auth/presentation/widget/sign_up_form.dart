import 'package:dp_project/feature/profile/domain/entity/custom_user.dart';
import 'package:dp_project/feature/profile/domain/entity/free_package.dart';
import 'package:dp_project/feature/profile/domain/entity/gold_package.dart';
import 'package:dp_project/feature/profile/domain/entity/package_info.dart';
import 'package:dp_project/feature/profile/domain/entity/pro_package.dart';
import 'package:dp_project/feature/common/presentation/widget/custom_dropdown_field.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dp_project/core/di.dart';
import 'package:dp_project/feature/common/presentation/widget/custom_primary_button.dart';
import 'package:dp_project/feature/common/presentation/widget/custom_text_field.dart';
import 'package:reactive_forms/reactive_forms.dart';

class SignUpForm extends HookConsumerWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formGroup = FormGroup({
      'email': FormControl<String>(
        validators: [Validators.required, Validators.email],
      ),
      'password': FormControl<String>(
        validators: [Validators.required, Validators.minLength(8)],
      ),
      'confirmPassword': FormControl<String>(
        validators: [Validators.required],
      ),
      'chosenPackage': FormControl<PackageInfo>(
        validators: [Validators.required],
      ),
    }, validators: [
      const MustMatchValidator('password', 'confirmPassword', true)
    ]);

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
          const SizedBox(height: 15),
          CustomTextField(
            formControlName: 'password',
            labelText: 'Password',
            isPasswordField: true,
            validationMessages: {
              ValidationMessage.required: (_) => 'Please enter your password',
              ValidationMessage.minLength: (_) =>
                  'Password must be at least 8 characters',
            },
          ),
          const SizedBox(height: 15),
          CustomTextField(
            formControlName: 'confirmPassword',
            labelText: 'Confirm Password',
            isPasswordField: true,
            validationMessages: {
              ValidationMessage.required: (_) =>
                  'Please enter your password again',
              ValidationMessage.mustMatch: (_) => 'Passwords do not match',
            },
          ),
          const SizedBox(height: 15),
          CustomDropdownField(
            labelText: "Chose package",
            items:
             [
              DropdownMenuItem(
                value: FreePackage(),
                child: const Text('Free'),
              ),
              DropdownMenuItem(
                value: ProPackage(FreePackage()),
                child: const Text('Pro'),
              ),
              DropdownMenuItem(
                value: GoldPackage(FreePackage()),
                child: const Text('Gold'),
              ),
            ],
            formControlName: 'chosenPackage',
            validationMessages: {
              ValidationMessage.required: (_) => 'Please select a package',
            },
          ),
          const SizedBox(height: 40),
          CustomPrimaryButton(
            labelText: 'Sign up',
            onPressed: () {
              formGroup.markAllAsTouched();
              if (formGroup.valid) {
                ref.read(authNotifierProvider.notifier).signUp(
                      context,
                      formGroup.control('email').value,
                      formGroup.control('password').value,
                      formGroup.control('chosenPackage').value,
                    );
              }
            },
          ),
        ]),
      ),
    );
  }
}
