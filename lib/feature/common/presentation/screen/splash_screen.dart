import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:dp_project/core/route_generator.dart';
import 'package:dp_project/core/style/style_extensions.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _redirectToNextScreen(context, ref);

    return Scaffold(
      backgroundColor: context.backgroundColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(30.0),
              child: Image(
                image: AssetImage('assets/images/camping_image.png'),
              ),
            ),
            Lottie.asset('assets/animations/loading_dots.json', height: 100),
          ],
        ),
      ),
    );
  }

  void _redirectToNextScreen(BuildContext context, WidgetRef ref) {
    Future.delayed(const Duration(seconds: 1), () {
        Navigator.of(context).pushNamed(RouteGenerator.homePageScreen);
    });
  }
}
