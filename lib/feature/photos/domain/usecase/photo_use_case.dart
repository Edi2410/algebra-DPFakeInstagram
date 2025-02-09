import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dp_project/core/error/failure.dart';
import 'package:dp_project/feature/photos/domain/entity/photo.dart';
import 'package:dp_project/feature/photos/domain/repository/photo_repository.dart';

class PhotoUseCase {
  final PhotoRepository _photoRepository;

  const PhotoUseCase(this._photoRepository);

  Future<Either<Failure, List<Photo>?>> getAllPhotos() async {
    return await _photoRepository.getAllPhotos();
  }

  Future<Either<Failure, void>> editPhoto(final Photo photo) async {
    return await _photoRepository.editPhoto(photo);
  }

  Future<Either<Failure, void>> addPhoto(
    final Photo photo,
    final File image,
    final String format,
    final String size,
  ) async {
    return await _photoRepository.addPhoto(photo, image, format, size);
  }

  Future<Either<Failure, void>> deletePhoto(final String photoId, final String
  uid)
  async {
    return await _photoRepository.deletePhoto(photoId, uid);
  }

  Future<Either<Failure, List<Photo>?>> getMyPhoto(String uid) async {
    return await _photoRepository.getMyPhoto(uid);
  }

  Future<Either<Failure, List<Photo>?>> searchPhoto(String query) async {
    return await _photoRepository.searchPhoto(query);
  }
}
