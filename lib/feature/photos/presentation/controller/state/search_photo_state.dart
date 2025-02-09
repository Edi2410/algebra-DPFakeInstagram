import 'package:dp_project/core/error/failure.dart';
import 'package:dp_project/feature/photos/domain/entity/photo.dart';

sealed class SearchPhotoState {
  const SearchPhotoState();
}

class LoadingSearchPhotos extends SearchPhotoState {
  const LoadingSearchPhotos();
}

class ErrorSearchPhotos extends SearchPhotoState {
  final Failure? error;

  const ErrorSearchPhotos({this.error});
}

class SuccessSearchPhotos extends SearchPhotoState {
  final List<Photo> photos;

  const SuccessSearchPhotos(this.photos);
}
