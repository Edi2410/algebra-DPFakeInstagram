import 'package:dartz/dartz.dart';
import 'package:dp_project/core/error/failure.dart';
import 'package:dp_project/feature/profile/domain/entity/custom_user.dart';
import 'package:dp_project/feature/profile/domain/entity/package_info.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract interface class UserDataRepository {
  Future<Either<Failure, CustomUser>> getUserData(final User user);

  Future<Either<Failure, void>> createUserDataIfNotExist(
      final User user, PackageInfo? packageInfo);

  Future<Either<Failure, void>> updatePackageInfo(
      final CustomUser customUser, final PackageInfo packageInfo);
}
