import 'package:dp_project/feature/profile/domain/entity/free_package.dart';
import 'package:dp_project/feature/profile/domain/entity/gold_package.dart';
import 'package:dp_project/feature/profile/domain/entity/pro_package.dart';

getUserPackageByName(String packageName) {
  switch (packageName) {
    case 'Free':
      return FreePackage();
    case 'Pro':
      return ProPackage(FreePackage());
    case 'Gold':
      return GoldPackage(FreePackage());
    default:
      return FreePackage();
  }
}