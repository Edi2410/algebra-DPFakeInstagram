import 'package:dp_project/core/error/failure.dart';
import 'package:dp_project/feature/photos/domain/entity/photo.dart';

sealed class MyPhotoState {
  const MyPhotoState();
}

class LoadingMyPhotos extends MyPhotoState {
  const LoadingMyPhotos();
}

class ErrorMyPhotos extends MyPhotoState {
  final Failure? error;

  const ErrorMyPhotos({this.error});
}

class SuccessMyPhotos extends MyPhotoState {
  final List<Photo> myPhotos;

  const SuccessMyPhotos(this.myPhotos);
}

class EmptyMyPhoto extends MyPhotoState {
  const EmptyMyPhoto();
}
