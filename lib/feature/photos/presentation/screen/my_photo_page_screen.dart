import 'package:dp_project/core/di.dart';
import 'package:dp_project/core/route_generator.dart';
import 'package:dp_project/core/style/style_extensions.dart';
import 'package:dp_project/feature/common/presentation/screen/empty_screen.dart';
import 'package:dp_project/feature/common/presentation/screen/error_screen.dart';
import 'package:dp_project/feature/common/presentation/screen/loading_screen.dart';
import 'package:dp_project/feature/photos/presentation/controller/state/my_photo_state.dart';
import 'package:dp_project/feature/photos/presentation/widget/photo_card_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dp_project/feature/common/presentation/widget/custom_app_bar.dart';

class MyPhotoPageScreen extends ConsumerWidget {
  const MyPhotoPageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myPhotoState = ref.watch(myPhotoNotifierProvider);
    return switch (myPhotoState) {
      LoadingMyPhotos() => const LoadingScreen(),
      ErrorMyPhotos() => const ErrorScreen(),
      EmptyMyPhoto() => const EmptyScreen(),
      SuccessMyPhotos() => _buildSuccessScreen(context, myPhotoState.myPhotos),
    };
  }

  _buildSuccessScreen(BuildContext context, photos) {
    final authUser = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: const CustomAppBar(title: "Photos"),
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
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: photos.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              PhotoCard(photo: photos[index]),
              const SizedBox(height: 8),
            ],
          );
        },
      ),
    );
  }
}
