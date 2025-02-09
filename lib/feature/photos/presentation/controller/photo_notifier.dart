import 'dart:io';

import 'package:dp_project/feature/common/presentation/utility/show_custom_alert_dialog.dart';
import 'package:dp_project/feature/photos/domain/entity/photo.dart';
import 'package:dp_project/feature/photos/domain/usecase/photo_use_case.dart';
import 'package:dp_project/feature/photos/presentation/controller/state/photo_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dp_project/core/di.dart';
import 'package:http/http.dart' as http;
import "package:path/path.dart" as path;

import 'package:permission_handler/permission_handler.dart';

class PhotoNotifier extends Notifier<PhotoState> {
  late final PhotoUseCase _photoUseCase;
  List<Photo>? places;
  late Photo? place;

  @override
  PhotoState build() {
    _photoUseCase = ref.read(photoUseCasesProvider);
    getAllPhotos();
    return state;
  }

  Future<void> getAllPhotos() async {
    state = const LoadingPhotos();
    final result = await _photoUseCase.getAllPhotos();
    result.fold(
      (failure) {
        ref
            .read(errorLogsNotifierProvider.notifier)
            .addErrorLog('getAllPhotos', failure.toString());
        return state = ErrorPhotos(error: failure);
      },
      (photos) {
        if (photos == null || photos.isEmpty) {
          ref.read(infoLogsNotifierProvider.notifier).addInfoLog('getAllPhotos'
              ' empty');
          state = const EmptyPhoto();
        } else {
          ref.read(infoLogsNotifierProvider.notifier).addInfoLog('getAllPhotos '
              'success');
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
      (failure) {
        ref
            .read(errorLogsNotifierProvider.notifier)
            .addErrorLog('addPhoto', failure.toString());
        return state = ErrorPhotos(error: failure);
      },
      (_) => {
        ref.read(infoLogsNotifierProvider.notifier).addInfoLog('addPhoto'),
        getAllPhotos(),
        ref.read(myPhotoNotifierProvider.notifier).getMyPhotos(),
        Navigator.of(context).pop(),
      },
    );
  }

  Future<void> downloadPhoto(BuildContext context, String photoUrh) async {
    try {
      ref.read(infoLogsNotifierProvider.notifier).addInfoLog('downloadPhoto');
      final p = await Permission.photos.request();
      if (p == PermissionStatus.granted || p == PermissionStatus.limited) {
        // Download the image
        final response = await http.get(Uri.parse(photoUrh));
        if (response.statusCode == 200) {
          // Get the external storage directory (Downloads folder)

          // Get the path to the Downloads folder
          final downloadsDir = Directory('/storage/emulated/0/Download');

          // Generate the file name from the URL
          final fileName = path.basename(photoUrh);
          final file = File('${downloadsDir.path}/$fileName');

          // Write the image bytes to the file
          await file.writeAsBytes(response.bodyBytes);

          if (context.mounted) {
            ref.read(infoLogsNotifierProvider.notifier).addInfoLog(
                'downloadPhoto Success. Photo downloaded ');
            showCustomAlertDialog(
                context,
                'Success. Photo downloaded '
                'successfully');
          }
        } else {
          if (context.mounted) {
            ref.read(errorLogsNotifierProvider.notifier).addErrorLog(
                'downloadPhoto', 'Failed to download photo. Server error');
            showCustomAlertDialog(
                context, 'Failed to download photo. Library error');
          }
        }
      }
    } catch (e) {
      ref.read(errorLogsNotifierProvider.notifier).addErrorLog(
          'downloadPhoto', 'Failed to download photo. Library error');
      if (context.mounted) {
        showCustomAlertDialog(
            context, 'Failed to download photo. Library error');
      }
    }
  }

  Future<void> editPhoto(BuildContext context, Photo photo) async {
    state = const LoadingPhotos();
    final result = await _photoUseCase.editPhoto(photo);
    result.fold(
      (failure) {
        ref.read(errorLogsNotifierProvider.notifier).addErrorLog('editPhoto',
            failure.toString());
        return state = ErrorPhotos(error: failure);
      },
      (_) {
        ref.read(infoLogsNotifierProvider.notifier).addInfoLog('editPhoto '
            'success');
        getAllPhotos();
        Navigator.pop(context);
      },
    );
  }
}
