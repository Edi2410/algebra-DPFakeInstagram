
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
    return state;
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
      (failure) {
        ref
            .read(errorLogsNotifierProvider.notifier)
            .addErrorLog('getMyPhotos', failure.toString());
        return state = ErrorMyPhotos(error: failure);
      },
      (photos) {
        if (photos == null || photos.isEmpty) {
          ref.read(infoLogsNotifierProvider.notifier).addInfoLog('getMyPhotos'
              ' empty');
          state = const EmptyMyPhoto();
        } else {
          ref.read(infoLogsNotifierProvider.notifier).addInfoLog('getMyPhotos'
              ' success');
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
      (failure) {
        ref.read(errorLogsNotifierProvider.notifier).addErrorLog('deletePhoto',
            failure.toString());
        return state = ErrorMyPhotos(error: failure);
      },
      (_) {
        ref.read(infoLogsNotifierProvider.notifier).addInfoLog('deletePhoto');
        getMyPhotos();
      },
    );
  }

  Future<void> editPhoto(BuildContext context, Photo photo) async {
    state = const LoadingMyPhotos();
    final result = await _photoUseCase.editPhoto(photo);
    result.fold(
      (failure) {
        ref.read(errorLogsNotifierProvider.notifier).addErrorLog('editPhoto',
            failure.toString());
        return state = ErrorMyPhotos(error: failure);
      },
      (_) {
        ref.read(infoLogsNotifierProvider.notifier).addInfoLog('editPhoto '
            'success');
        getMyPhotos();
        if (context.mounted) {
          showCustomAlertDialog(context, 'Photo edited.');
        }
        Navigator.of(context).overlay;
      },
    );
  }
}
