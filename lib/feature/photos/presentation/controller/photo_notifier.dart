import 'dart:io';

import 'package:dp_project/feature/common/presentation/utility/show_custom_alert_dialog.dart';
import 'package:dp_project/feature/photos/domain/entity/photo.dart';
import 'package:dp_project/feature/photos/domain/usecase/photo_use_case.dart';
import 'package:dp_project/feature/photos/presentation/controller/state/photo_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dp_project/core/di.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:permission_handler/permission_handler.dart';

class PhotoNotifier extends Notifier<PhotoState> {
  late final PhotoUseCase _photoUseCase;
  List<Photo>? places;
  late Photo? place;

  @override
  PhotoState build() {
    _photoUseCase = ref.read(photoUseCasesProvider);
    getAllPhotos();
    return const LoadingPhotos();
  }

  Future<void> getAllPhotos() async {
    state = const LoadingPhotos();
    final result = await _photoUseCase.getAllPhotos();
    result.fold(
      (failure) => state = ErrorPhotos(error: failure),
      (photos) {
        if (photos == null || photos.isEmpty) {
          state = const EmptyPhoto();
        } else {
          places = photos;
          state = SuccessPhotos(photos);
        }
      },
    );
  }


  Future<void> addPhoto(
    BuildContext context,
    Photo photo,
    File image,
    String format,
    String size,
  ) async {
    state = const LoadingPhotos();
    final result = await _photoUseCase.addPhoto(photo, image, format, size);
    result.fold(
      (failure) => state = ErrorPhotos(error: failure),
      (_) => {
        getAllPhotos(),
        Navigator.of(context).pop(),
      },
    );
  }

  Future<void> downloadPhoto(BuildContext context, String photoUrh) async {
    try {
      final p = await Permission.photos.request();
      if (p == PermissionStatus.granted || p == PermissionStatus.limited) {

        String? photoId = await ImageDownloader.downloadImage(
          photoUrh,
          destination: AndroidDestinationType.directoryPictures,
        );

        if (photoId == null) {
          if (context.mounted) {
            showCustomAlertDialog(context, 'Failed to download photo');
          }
          throw Exception();
        }

        if (context.mounted) {
          showCustomAlertDialog(
              context,
              'Success. Photo downloaded '
              'successfully');
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> editPhoto(BuildContext context, Photo photo) async {
    state = const LoadingPhotos();
    final result = await _photoUseCase.editPhoto(photo);
    result.fold(
      (failure) {
        return state = ErrorPhotos(error: failure);
      },
      (_) {
        getAllPhotos();
        Navigator.pop(context);
      },
    );
  }

}
