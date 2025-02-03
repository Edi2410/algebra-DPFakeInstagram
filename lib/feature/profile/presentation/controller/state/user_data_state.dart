import 'package:dp_project/core/error/failure.dart';
import 'package:dp_project/feature/profile/domain/entity/custom_user.dart';

sealed class UserDataState {
  const UserDataState();
}

class LoadingUserData extends UserDataState {
  const LoadingUserData();
}

class ErrorUserDataState extends UserDataState {
  final Failure? error;


  const ErrorUserDataState({this.error});
}

class SuccessUserData extends UserDataState {
  final CustomUser user;

  const SuccessUserData(this.user);
}
