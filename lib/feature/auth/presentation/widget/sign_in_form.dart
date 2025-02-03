import 'package:dp_project/feature/common/presentation/widget/custom_secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dp_project/core/di.dart';
import 'package:dp_project/core/route_generator.dart';
import 'package:dp_project/core/style/style_extensions.dart';
import 'package:dp_project/feature/common/presentation/widget/custom_primary_button.dart';
import 'package:dp_project/feature/common/presentation/widget/custom_text_field.dart';
import 'package:reactive_forms/reactive_forms.dart';

class SignInForm extends HookConsumerWidget {
  const SignInForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final formGroup = FormGroup({
      'email': FormControl<String>(
        validators: [Validators.required, Validators.email],
        value: "graovacedi@gmail.com"
      ),
      'password': FormControl<String>(
        validators: [Validators.required],
        value: "test1234"
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
          const SizedBox(height: 15),
          CustomTextField(
            formControlName: 'password',
            labelText: 'Password',
            isPasswordField: true,
            validationMessages: {
              ValidationMessage.required: (_) => 'Please enter your password',
            },
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(RouteGenerator.resetPasswordScreen);
              },
              child: Text("Forgot password?",
                  style: context.textStandard.copyWith(
                    color: context.textColor,
                  ),),
            ),
          ),
          const SizedBox(height: 20),
          CustomPrimaryButton(
            labelText: 'Sign in',
            onPressed: () {
              formGroup.markAllAsTouched();
              if (formGroup.valid) {

                ref.read(authNotifierProvider.notifier).signIn(
                      context,
                      formGroup.control('email').value,
                      formGroup.control('password').value,
                    );
              }
            },
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 120,
                child: CustomSecondaryButton(
                  labelText: 'Google',
                  onPressed: () {
                    ref.read(authNotifierProvider.notifier).signInWithGoogle
                      (context);
                  },
                ),
              ),
              const SizedBox(width: 20),
              SizedBox(
                width: 120,
                child: CustomSecondaryButton(
                  labelText: 'Github',
                  onPressed: () {
                    ref.read(authNotifierProvider.notifier).signInWithGithub
                      (context);
                  },
                ),
              ),
            ],
          )

        ]),
      ),
    );
  }
}
