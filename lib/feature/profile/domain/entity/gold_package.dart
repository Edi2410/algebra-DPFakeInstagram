import 'package:dp_project/feature/profile/domain/decorators/package_decorator.dart';

class GoldPackage extends PackageDecorator {
  GoldPackage(super.packageInfo);

  @override
  int getDailyUploadLimit() => 10000;

  @override
  double getMaxSpendingLimit() => 1000;

  @override
  String getPackageName() => 'Gold';

  @override
  int getUploadSizeLimit() => 1000000000;

  String getGoldSpecific() => "ovaj je najveca faca";
}
