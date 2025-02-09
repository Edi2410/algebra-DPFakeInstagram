import 'package:dp_project/core/di.dart';
import 'package:dp_project/core/route_generator.dart';
import 'package:dp_project/core/style/style_extensions.dart';
import 'package:dp_project/feature/common/presentation/screen/empty_screen.dart';
import 'package:dp_project/feature/common/presentation/screen/error_screen.dart';
import 'package:dp_project/feature/common/presentation/screen/loading_screen.dart';
import 'package:dp_project/feature/common/presentation/widget/custom_text_field.dart';
import 'package:dp_project/feature/photos/domain/entity/photo.dart';
import 'package:dp_project/feature/photos/presentation/controller/state/search_photo_state.dart';
import 'package:dp_project/feature/photos/presentation/widget/photo_card_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dp_project/feature/common/presentation/widget/custom_app_bar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:flutter_hooks/flutter_hooks.dart'; // HookWidget import

class SearchPhotoScreen extends HookConsumerWidget {
  const SearchPhotoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchPhotoState = ref.watch(searchPhotoNotifierProvider);
    final searchController =
        useTextEditingController();
    useEffect(() {
      searchController.addListener(() {
        final query = searchController.text.trim();
        if (query.isNotEmpty) {
          ref.read(searchPhotoNotifierProvider.notifier).searchedPhotos(query);
        }
      });
      return null;
    }, [searchController]);

    return switch (searchPhotoState) {
      LoadingSearchPhotos() => const LoadingScreen(),
      ErrorSearchPhotos() => const ErrorScreen(),
      SuccessSearchPhotos() => _buildSuccessScreen(
          context, searchPhotoState.photos, searchController, ref),
    };
  }

  Widget _buildSuccessScreen(BuildContext context, List<Photo> photos,
      TextEditingController searchController, WidgetRef ref) {
    final authUser = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: const CustomAppBar(
        title: "Search Photo",
        isBackButtonVisible: true,
        isTitleCentered: true,
      ),
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ReactiveForm(
              formGroup: FormGroup({
                'search': FormControl<String>(), // Reactive Form field
              }),
              child: CustomTextField(
                controller: searchController,
                labelText: "Search by author, description, or title",
                formControlName: 'search', // Binds to Reactive Form
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
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
          ),
        ],
      ),
    );
  }
}
