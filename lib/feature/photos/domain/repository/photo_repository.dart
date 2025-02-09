import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dp_project/core/error/failure.dart';
import 'package:dp_project/feature/photos/domain/entity/photo.dart';

abstract interface class PhotoRepository {
  Future<Either<Failure, List<Photo>?>> getAllPhotos();

  Future<Either<Failure, void>> editPhoto(final Photo photo);

  Future<Either<Failure, void>> addPhoto(
    final Photo photo,
    final File image,
    final String format,
    final String size,
  );

  Future<Either<Failure, void>> deletePhoto(
      final String photoId, final String uid);

  Future<Either<Failure, List<Photo>?>> getMyPhoto(String uid);

  Future<Either<Failure, List<Photo>?>> searchPhoto(String query);
}
