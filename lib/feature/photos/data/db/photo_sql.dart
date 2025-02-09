import 'dart:io';

import 'package:cloudinary_url_gen/cloudinary.dart';
import 'package:cloudinary_url_gen/transformation/delivery/delivery.dart';
import 'package:cloudinary_url_gen/transformation/delivery/delivery_actions.dart';
import 'package:cloudinary_url_gen/transformation/resize/resize.dart';
import 'package:cloudinary_url_gen/transformation/transformation.dart';
import 'package:dio/dio.dart';
import 'package:dp_project/core/sql_db.dart';
import 'package:dp_project/feature/photos/domain/entity/photo.dart';

var cloudinary = Cloudinary.fromStringUrl(
  'cloudinary://546187957783985:xm1kZDrtCivPup7DX9qYZ7rJ0SE@dcrfeyi2f',
);
const cloudinaryUploadUrl =
    'https://api.cloudinary.com/v1_1/dcrfeyi2f/image/upload';

class PhotoSql {
  final SqlDb _sqlDb;

  PhotoSql(this._sqlDb);

  Future<void> addPhoto(
    Photo photoData,
    File image,
    String format,
    String size,
  ) async {
    final database = await _sqlDb.db;

    final cloudinaryImagePath = await _uploadImage(image, format, size);

    await database.insert('Photo', {
      'uid': photoData.uid,
      'author': photoData.author,
      'description': photoData.description,
      'hashtags': photoData.hashtags,
      'url': cloudinaryImagePath,
    });
  }

  _uploadImage(
    File image,
    String format,
    String size,
  ) async {
    final Dio dio = Dio();

    final FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(image.path),
      'upload_preset': 'dp-project',
    });

    final Response response =
        await dio.post(cloudinaryUploadUrl, data: formData);

    String urlTest = cloudinary.image(response.data['public_id'])
        .transformation(
          Transformation()
              .resize(
                Resize.fit()
                  ..width(size.split('x').first)
                  ..height(size.split('x').last),
              )
              .delivery(
                Delivery.format(
                  _getPhotoFormat(format),
                ),
              ),
        ).toString();


    return urlTest;
  }

  Future<void> updatePhoto(Photo photo) async {
    final database = await _sqlDb.db;
    await database.update(
      'Photo',
      {
        'description': photo.description,
        'hashtags': photo.hashtags,
      },
      where: 'id = ? AND uid = ?',
      whereArgs: [photo.id, photo.uid],
    );
  }

  Future<void> deletePhoto(String photoId, String uid) async {
    final database = await _sqlDb.db;
    await database.delete(
      'Photo',
      where: 'id = ? AND uid = ?',
      whereArgs: [photoId, uid],
    );
  }

  Future<List<Photo>> getMyPhotos (String uid) async {
    final database = await _sqlDb.db;
    List<Photo> photos = [];
    var sqlPhotos = await database.query(
      'Photo',
      where: 'uid = ?',
      whereArgs: [uid],
      orderBy: 'date DESC',
      limit: 10,
    );

    if (sqlPhotos.isNotEmpty) {
      sqlPhotos
          .map((photo) => photos.add(Photo(
          id: photo['id'].toString(),
          uid: photo['uid'].toString(),
          size: photo['size'].toString(),
          url: photo['url'].toString(),
          uploadDate: DateTime.parse(
              photo['date'].toString().replaceFirst(' ', 'T')),
          description: photo['description'].toString(),
          author: photo['author'].toString(),
          hashtags: photo['hashtags'].toString())))
          .toList();
    }

    return photos;
  }


  Future<List<Photo>> getAllPhotos() async {
    final database = await _sqlDb.db;
    List<Photo> photos = [];
    var sqlPhotos = await database.query(
      'Photo',
      orderBy: 'date DESC',
      limit: 10,
    );

    if (sqlPhotos.isNotEmpty) {
      sqlPhotos
          .map((photo) => photos.add(Photo(
              id: photo['id'].toString(),
              uid: photo['uid'].toString(),
              size: photo['size'].toString(),
              url: photo['url'].toString(),
              uploadDate: DateTime.parse(
                  photo['date'].toString().replaceFirst(' ', 'T')),
              description: photo['description'].toString(),
              author: photo['author'].toString(),
              hashtags: photo['hashtags'].toString())))
          .toList();
    }

    return photos;
  }

  String _getPhotoFormat(String format) {
    switch (format) {
      case 'jpg':
        return Format.jpg;
      case 'png':
        return Format.png;
      case 'bmp':
        return Format.bmp;
      default:
        return Format.jpg;
    }
  }

  Future<List<Photo>> searchPhoto(String query) async {
    final database = await _sqlDb.db;
    List<Photo> photos = [];

    var sqlPhotos = await database.query(
      'Photo',
      where: 'description LIKE ? OR hashtags LIKE ? OR author LIKE ?',
      whereArgs: ['%$query%', '%$query%', '%$query%'],
      orderBy: 'date DESC',
      limit: 10,
    );

    if (sqlPhotos.isNotEmpty) {
      sqlPhotos
          .map((photo) => photos.add(Photo(
        id: photo['id'].toString(),
        uid: photo['uid'].toString(),
        size: photo['size'].toString(),
        url: photo['url'].toString(),
        uploadDate: DateTime.parse(photo['date'].toString().replaceFirst(' ', 'T')),
        description: photo['description'].toString(),
        author: photo['author'].toString(),
        hashtags: photo['hashtags'].toString(),
      )))
          .toList();
    }

    return photos;
  }


}
