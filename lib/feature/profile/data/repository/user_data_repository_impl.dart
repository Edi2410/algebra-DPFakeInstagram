import 'package:dartz/dartz.dart';
import 'package:dp_project/feature/profile/data/db/user_sql_api.dart';
import 'package:dp_project/feature/profile/domain/entity/custom_user.dart';
import 'package:dp_project/feature/profile/domain/entity/package_info.dart';
import 'package:dp_project/feature/profile/domain/repository/user_data_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dp_project/core/error/failure.dart';

class UserDataRepositoryImpl implements UserDataRepository {
  final UserSqlApi _api;

  const UserDataRepositoryImpl(this._api);

  @override
  Future<Either<Failure, void>> createUserDataIfNotExist(
      User user, PackageInfo? packageInfo) async {
    try {
      final result = await _api.createUserDataIfNotExist(user, packageInfo);
      return Right(result);
    } catch (e) {
      return Left(GeneralError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, CustomUser>> getUserData(User user) async {
    try {
      final result = await _api.getUserData(user);
      return Right(result);
    } catch (e) {
      return Left(GeneralError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updatePackageInfo(
      CustomUser customUser, PackageInfo packageInfo) async {
    try {
      final result = await _api.updatePackageInfo(customUser, packageInfo);
      return Right(result);
    } catch (e) {
      return Left(GeneralError(message: e.toString()));
    }
  }
}
