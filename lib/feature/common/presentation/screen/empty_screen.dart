import 'package:dp_project/core/route_generator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dp_project/core/style/style_extensions.dart';

class EmptyScreen extends StatelessWidget {
  const EmptyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authUser = FirebaseAuth.instance.currentUser;

    return SafeArea(
      child: Scaffold(
        floatingActionButton: authUser != null
            ? FloatingActionButton(
                backgroundColor: context.primaryColor,
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(RouteGenerator.addNewPhotoScreen);
                },
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 32,
                ),
              )
            : null,
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Image(
                    image: AssetImage("assets/images/empty_favorites.png")),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 4.0, horizontal: 32.0),
                  child: Text(
                    "No data found",
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
                    "There is no data available for this section",
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
