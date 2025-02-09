import 'package:dp_project/core/di.dart';
import 'package:dp_project/feature/common/presentation/utility/show_custom_alert_dialog.dart';
import 'package:dp_project/feature/profile/domain/entity/custom_user.dart';
import 'package:dp_project/feature/profile/domain/entity/package_info.dart';
import 'package:dp_project/feature/profile/domain/usecase/user_use_case.dart';
import 'package:dp_project/feature/profile/presentation/controller/state/user_data_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserDataNotifier extends Notifier<UserDataState> {

  late final UserUseCase _userUseCases;
  CustomUser? user;

  @override
  UserDataState build() {
    _userUseCases = ref.watch(userUseCasesProvider);
    getUserData();
    return state;
  }

  Future<void> getUserData() async {
    final authUser = FirebaseAuth.instance.currentUser;
    state = const LoadingUserData();
    final result = await _userUseCases.getUserData(authUser!);
    result.fold(
      (error) {
        ref.read(errorLogsNotifierProvider.notifier).addErrorLog('getUserData',
            error.toString());
        state = ErrorUserDataState(error: error);
      },
      (user) {
        ref.read(infoLogsNotifierProvider.notifier).addInfoLog('getUserData '
            'success');
        state = SuccessUserData(user);
        this.user = user;
      },
    );
  }

  Future<void> updatePackageInfo(final CustomUser customUser, final
  PackageInfo packageInfo, BuildContext context) async {
    final result = await _userUseCases.updatePackageInfo(customUser, packageInfo);
    result.fold(
      (error) {
        ref.read(errorLogsNotifierProvider.notifier).addErrorLog('updatePackageInfo',
            error.toString());
        state = ErrorUserDataState(error: error);
      },
      (_) {
        ref.read(infoLogsNotifierProvider.notifier).addInfoLog('updatePackageInfo '
            'success');
        getUserData();
        if (context.mounted){
          Navigator.of(context).pop();
          showCustomAlertDialog(context, 'Package info updated successfully '
              'and will be active after midnight');
        }


      },
    );
  }
}
