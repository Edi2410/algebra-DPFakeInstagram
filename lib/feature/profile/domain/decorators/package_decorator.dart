import 'package:dp_project/feature/profile/domain/entity/package_info.dart';


class PackageDecorator implements PackageInfo {
  final PackageInfo _packageInfo;

  PackageDecorator(this._packageInfo);

  @override
  int getDailyUploadLimit() => _packageInfo.getDailyUploadLimit();

  @override
  double getMaxSpendingLimit() => _packageInfo.getMaxSpendingLimit();

  @override
  String getPackageName() => _packageInfo.getPackageName();

  @override
  int getUploadSizeLimit() => _packageInfo.getUploadSizeLimit();
}