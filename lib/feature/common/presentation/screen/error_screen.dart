import 'package:flutter/material.dart';
import 'package:dp_project/core/style/style_extensions.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Image(
                    image: AssetImage("assets/images/error_404_image.png")),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 4.0, horizontal: 32.0),
                  child: Text(
                    "There was an error",
                    style: context.textTitle.copyWith(
                      fontSize: 24,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 4.0, horizontal: 32.0),
                  child: Text(
                      "Please try again later or check your internet connection",
                      style: context.textStandard.copyWith(
                        color: context.textColor.withOpacity(0.8),
                      ),
                      textAlign: TextAlign.center,
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
