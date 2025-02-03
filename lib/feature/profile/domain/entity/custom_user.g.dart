// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'custom_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomUser _$CustomUserFromJson(Map<String, dynamic> json) => CustomUser(
      user: const UserJsonConverter()
          .fromJson(json['user'] as Map<String, dynamic>?),
      packageInfo: const PackageInfoJsonConverter()
          .fromJson(json['packageInfo'] as Map<String, dynamic>),
      isAdministrator: json['isAdministrator'] as bool? ?? false,
    );

Map<String, dynamic> _$CustomUserToJson(CustomUser instance) =>
    <String, dynamic>{
      'user': const UserJsonConverter().toJson(instance.user),
      'packageInfo':
          const PackageInfoJsonConverter().toJson(instance.packageInfo),
      'isAdministrator': instance.isAdministrator,
    };
