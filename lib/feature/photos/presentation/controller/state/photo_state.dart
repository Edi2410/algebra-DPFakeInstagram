import 'package:dp_project/core/error/failure.dart';
import 'package:dp_project/feature/photos/domain/entity/photo.dart';

sealed class PhotoState {
  const PhotoState();
}

class LoadingPhotos extends PhotoState {
  const LoadingPhotos();
}

class ErrorPhotos extends PhotoState {
  final Failure? error;

  const ErrorPhotos({this.error});
}

class SuccessPhotos extends PhotoState {
  final List<Photo> photos;

  const SuccessPhotos(this.photos);
}

class EmptyPhoto extends PhotoState {
  const EmptyPhoto();
}
