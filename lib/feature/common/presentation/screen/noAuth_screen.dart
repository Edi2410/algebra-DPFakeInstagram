import 'package:dp_project/core/route_generator.dart';
import 'package:dp_project/feature/common/presentation/widget/custom_primary_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dp_project/core/style/style_extensions.dart';

class NoauthScreen extends StatelessWidget {
  const NoauthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authUser = FirebaseAuth.instance.currentUser;

    return SafeArea(
      child: Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 4.0, horizontal: 32.0),
                  child: Text(
                    "You are not authorized to view this page",
                    style: context.textTitle.copyWith(
                      fontSize: 24,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 4.0, horizontal: 32.0),
                  child: CustomPrimaryButton(
                    labelText: "Login",
                    onPressed: () {
                      Navigator.of(context).pushNamed(RouteGenerator.signInScreen);
                    },
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
