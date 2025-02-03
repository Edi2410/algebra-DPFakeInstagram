import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dp_project/core/route_generator.dart';
import 'package:dp_project/core/style/style_extensions.dart';
import 'package:dp_project/feature/auth/presentation/widget/sign_up_form.dart';
import 'package:dp_project/feature/common/presentation/widget/custom_app_bar.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Register",
        elevation:10,
        isBackButtonVisible: true,
        isTitleCentered: true,
      ),
      body: SafeArea(
          child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 60),
                child: Image(
                  height: 150,
                  image: AssetImage('assets/images/login_image.png'),
                ),
              ),
              Text(
                "Please create an account to continue.",
                style: context.textStandard,
              ),
              const SizedBox(height: 20),
              const SignUpForm(),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: context.textStandard,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed(RouteGenerator.signInScreen);
                    },
                    child: Text(
                      "Sign in",
                      style: context.textStandard.copyWith(
                        color: context.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      )),
    );
  }
}
