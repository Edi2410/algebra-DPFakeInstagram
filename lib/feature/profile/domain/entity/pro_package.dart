

import 'package:dp_project/feature/profile/domain/decorators/package_decorator.dart';


class ProPackage extends PackageDecorator {
  ProPackage(super.packageInfo);

  @override
  int getDailyUploadLimit() => 100;

  @override
  double getMaxSpendingLimit() => 10;

  @override
  String getPackageName() => 'Pro';

  @override
  int getUploadSizeLimit() => 1000000;

  String getProSpecific() => "ovaj je najveca faca";
}