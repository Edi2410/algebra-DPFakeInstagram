import 'package:dp_project/feature/profile/domain/entity/free_package.dart';
import 'package:dp_project/feature/profile/domain/entity/gold_package.dart';
import 'package:dp_project/feature/profile/domain/entity/package_info.dart';
import 'package:dp_project/feature/profile/domain/entity/pro_package.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class PackageInfoJsonConverter implements JsonConverter<PackageInfo, Map<String, dynamic>> {
  const PackageInfoJsonConverter();

  @override
  PackageInfo fromJson(Map<String, dynamic> json) {
    PackageInfo packageInfo = FreePackage();

    switch (json['packageName']) {
      case 'FREE':
        return packageInfo;
      case 'PRO':
        return ProPackage(packageInfo);
      case 'GOLD':
        return GoldPackage(packageInfo);
      default:
        throw Exception('Unknown package type');
    }
  }

  @override
  Map<String, dynamic> toJson(PackageInfo packageInfo) {
    return {
      'packageName': packageInfo.getPackageName(),
      'dailyUploadLimit': packageInfo.getDailyUploadLimit(),
      'maxSpendingLimit': packageInfo.getMaxSpendingLimit(),
      'uploadSizeLimit': packageInfo.getUploadSizeLimit(),
    };
  }



}
