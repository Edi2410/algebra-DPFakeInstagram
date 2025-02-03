
import 'package:freezed_annotation/freezed_annotation.dart';

part 'photo.g.dart';

@JsonSerializable()
class Photo {
  final String? id;
  final String uid;
  final String author;
  final DateTime? uploadDate;
  final String description;
  final String hashtags;
  final String? url;
  final String? size;







  factory Photo.fromJson(Map<String, dynamic> json) => _$PhotoFromJson
    (json);

  Photo({required this.id, required this.uid, required this.author, required this.uploadDate, required this.description, required this.hashtags, required this.url, required this.size});

  Map<String, dynamic> toJson() => _$PhotoToJson(this);


}