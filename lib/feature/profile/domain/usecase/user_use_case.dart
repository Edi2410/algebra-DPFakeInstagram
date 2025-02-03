import 'package:dartz/dartz.dart';
import 'package:dp_project/core/error/failure.dart';
import 'package:dp_project/feature/profile/domain/entity/custom_user.dart';
import 'package:dp_project/feature/profile/domain/entity/package_info.dart';
import 'package:dp_project/feature/profile/domain/repository/user_data_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserUseCase {
  final UserDataRepository _userRepository;

  UserUseCase(this._userRepository);

  Future<Either<Failure, CustomUser>> getUserData(final User user) async =>
      await _userRepository.getUserData(user);

  Future<Either<Failure, void>> createUserDataIfNotExist(
          final User user, PackageInfo? packageInfo) async =>
      await _userRepository.createUserDataIfNotExist(user, packageInfo);

  Future<Either<Failure, void>> updatePackageInfo(
          final CustomUser customUser, final PackageInfo packageInfo) async =>
      await _userRepository.updatePackageInfo(customUser, packageInfo);
}
