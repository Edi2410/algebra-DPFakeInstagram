import 'package:firebase_auth/firebase_auth.dart';
import 'package:json_annotation/json_annotation.dart';

class UserJsonConverter implements JsonConverter<User?, Map<String, dynamic>?> {
  const UserJsonConverter();

  @override
  User? fromJson(Map<String, dynamic>? json) {
    if (json == null) return null;

    throw UnimplementedError('Firebase User cannot be deserialized from JSON.');
  }

  @override
  Map<String, dynamic>? toJson(User? user) {
    if (user == null) return null;
    return {
      'uid': user.uid,
      'email': user.email,
    };
  }
}
