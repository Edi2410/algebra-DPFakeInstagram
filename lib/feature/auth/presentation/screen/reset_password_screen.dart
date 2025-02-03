import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dp_project/core/style/style_extensions.dart';
import 'package:dp_project/feature/auth/presentation/widget/reset_password_form.dart';
import 'package:dp_project/feature/common/presentation/widget/custom_app_bar.dart';

class ResetPasswordScreen extends ConsumerStatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends ConsumerState<ResetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
          title: 'Reset Password',
          isBackButtonVisible: true,
        isTitleCentered: true,
        elevation: 10,

      ),
      body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                    child: Image(
                      image: AssetImage('assets/images/reset_password_email'
                          '.png'),
                    ),
                  ),
                  Text(
                    "Please enter your email address to reset your password.",
                    style: context.textStandard,
                    softWrap: true,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  const ResetPasswordForm(),

                ],
              ),
            ),
          )),
    );
  }
}
