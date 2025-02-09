import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dp_project/feature/photos/data/db/photo_sql.dart';
import 'package:dp_project/feature/photos/domain/entity/photo.dart';
import 'package:dp_project/feature/photos/domain/repository/photo_repository.dart';
import 'package:dp_project/core/error/failure.dart';

class PhotoRepositoryImpl implements PhotoRepository {
  final PhotoSql _api;

  const PhotoRepositoryImpl(this._api);

  @override
  Future<Either<Failure, void>> addPhoto(
    Photo photo,
    File image,
    String format,
    String size,
  ) async {
    try {
      await _api.addPhoto(photo, image, format, size);
      return const Right(null);
    } catch (e) {
      return Left(GeneralError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deletePhoto(String photoId, String uid) async {
    try {
      await _api.deletePhoto(photoId, uid);
      return const Right(null);
    } catch (e) {
      return Left(GeneralError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Photo>?>> getAllPhotos() async {
    try {
      final photos = await _api.getAllPhotos();
      return Right(photos);
    } catch (e) {
      return Left(GeneralError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> editPhoto(Photo photo) async {
    try {
      await _api.updatePhoto(photo);
      return const Right(null);
    } catch (e) {
      return Left(GeneralError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Photo>?>> getMyPhoto(String uid) async {
    try {
      final photos = await _api.getMyPhotos(uid);
      return Right(photos);
    } catch (e) {
      return Left(GeneralError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Photo>?>> searchPhoto(String query) async {
    try {
      final photos = await _api.searchPhoto(query);
      return Right(photos);
    } catch (e) {
      return Left(GeneralError(message: e.toString()));
    }
  }
}
