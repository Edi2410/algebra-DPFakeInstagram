import 'dart:io';
import 'package:dp_project/feature/common/presentation/utility/show_custom_alert_dialog.dart';
import 'package:dp_project/feature/photos/domain/entity/photo.dart';
import 'package:dp_project/feature/photos/domain/usecase/photo_use_case.dart';
import 'package:dp_project/feature/photos/presentation/controller/state/my_photo_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dp_project/core/di.dart';

class MyPhotoNotifier extends Notifier<MyPhotoState> {
  late final PhotoUseCase _photoUseCase;
  List<Photo>? myPhotos;

  @override
  MyPhotoState build() {
    _photoUseCase = ref.read(photoUseCasesProvider);
    getMyPhotos();
    return const LoadingMyPhotos();
  }


  Future<void> getMyPhotos() async {
    state = const LoadingMyPhotos();
    final authUser = FirebaseAuth.instance.currentUser;

    if (authUser == null) {
      state = const EmptyMyPhoto();
      return;
    }
    final result = await _photoUseCase.getMyPhoto(authUser.uid);

    result.fold(
          (failure) => state = ErrorMyPhotos(error: failure),
          (photos) {
        if (photos == null || photos.isEmpty) {
          state = const EmptyMyPhoto();
        } else {
          myPhotos = photos;
          state = SuccessMyPhotos(photos);
        }
      },
    );
  }


  Future<void> deletePhoto(String photoId, String uid) async {
    state = const LoadingMyPhotos();
    final result = await _photoUseCase.deletePhoto(photoId, uid);
    result.fold(
          (failure) => state = ErrorMyPhotos(error: failure),
          (_) {
        getMyPhotos();
      },
    );
  }

  Future<void> editPhoto(BuildContext context, Photo photo) async {
    state = const LoadingMyPhotos();
    final result = await _photoUseCase.editPhoto(photo);
    result.fold(
          (failure) {
        print(failure);
        return state = ErrorMyPhotos(error: failure);
      },
          (_) {
        getMyPhotos();
        if (context.mounted) {
          showCustomAlertDialog(
              context,
              'Photo edited.');
        }
        Navigator.of(context).overlay;
      },
    );
  }
}
