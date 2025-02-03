import 'package:dp_project/feature/profile/domain/entity/custom_converters/package_info_converter.dart';
import 'package:dp_project/feature/profile/domain/entity/custom_converters/user_json_converter.dart';
import 'package:dp_project/feature/profile/domain/entity/package_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'custom_user.g.dart';

@JsonSerializable()
class CustomUser {
  @UserJsonConverter()
  final User? user;
  @PackageInfoJsonConverter()
  final PackageInfo packageInfo;
  final bool isAdministrator;


  CustomUser({required this.user, required this.packageInfo, this
      .isAdministrator = false});


  factory CustomUser.fromJson(Map<String, dynamic> json) => _$CustomUserFromJson(json);
  Map<String, dynamic> toJson() => _$CustomUserToJson(this);

}