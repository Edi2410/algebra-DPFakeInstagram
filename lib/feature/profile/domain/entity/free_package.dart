
import 'package:dp_project/feature/profile/domain/decorators/package_decorator.dart';
import 'package:dp_project/feature/profile/domain/entity/package_info.dart';

class FreePackage implements PackageInfo {

  @override
  int getDailyUploadLimit() => 10;

  @override
  double getMaxSpendingLimit() => 0;

  @override
  String getPackageName() => 'Free';

  @override
  int getUploadSizeLimit() => 1000;


}