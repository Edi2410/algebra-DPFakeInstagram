import 'package:dp_project/feature/profile/domain/entity/free_package.dart';
import 'package:dp_project/feature/profile/domain/entity/package_info.dart';
import 'package:dp_project/feature/profile/domain/usecase/user_use_case.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dp_project/core/di.dart';
import 'package:dp_project/core/route_generator.dart';
import 'package:dp_project/feature/auth/domain/usecase/auth_use_case.dart';
import 'package:dp_project/feature/auth/presentation/controller/state/auth_state.dart';
import 'package:dp_project/feature/common/presentation/utility/show_custom_alert_dialog.dart';

class AuthNotifier extends Notifier<AuthState> {
  late final AuthUseCase _authUseCases;
  late final UserUseCase _userUseCases;


  @override
  AuthState build() {
    _authUseCases = ref.watch(authUseCasesProvider);
    _userUseCases = ref.watch(userUseCasesProvider);
    final authUser = FirebaseAuth.instance.currentUser;
    return authUser != null
        ? AuthenticatedAuth(authUser)
        : const UnauthenticatedAuthState(fromSignIn: false);
  }

  Future<void> signIn(
      BuildContext context, String email, String password) async {
    state = const LoadingAuth();
    final result = await _authUseCases.signIn(email, password);
    result.fold(
      (error) {
        state = UnauthenticatedAuthState(error: error, fromSignIn: true);
        if (context.mounted) {
          showCustomAlertDialog(context, error.message);
        }
      },
      (user) {
        state = AuthenticatedAuth(user!);
        Navigator.of(context).pushNamed(RouteGenerator.homePageScreen);
      },
    );
  }

  Future<void> signUp(BuildContext context, String email, String password,
      PackageInfo chosenPackage) async {
    state = const LoadingAuth();
    final result = await _authUseCases.signUp(email, password);
    result.fold(
      (error) {
        if (context.mounted) {
          showCustomAlertDialog(context, error.message);
        }
        state = UnauthenticatedAuthState(error: error, fromSignIn: false);
      },
      (user) {

        AuthenticatedAuth(user!);
        _userUseCases.createUserDataIfNotExist(user, chosenPackage);
        user.sendEmailVerification();
        Navigator.of(context).pushNamed(RouteGenerator.verifyEmailScreen,
            arguments: ModalRoute.of(context)?.settings.name);
      },
    );
  }

  Future<void> resetPassword(BuildContext context, final String email) async {
    final results = await _authUseCases.resetPassword(email);
    results.fold(
      (error) {
        if (context.mounted) {
          showCustomAlertDialog(context, error.message);
        }
      },
      (_) {
        Navigator.of(context).pushNamed(RouteGenerator.verifyEmailScreen,
            arguments: ModalRoute.of(context)?.settings.name);
      },
    );
  }

  Future<void> signOut(BuildContext context) async {
    final results = await _authUseCases.signOutUser();
    results.fold((error) {
      if (context.mounted) {
        showCustomAlertDialog(context, error.message);
      }
    }, (_) {
      state = const UnauthenticatedAuthState(fromSignIn: false);
      Navigator.of(context).pushNamed(RouteGenerator.signInScreen);
    });
  }

  Future<void> resendVerificationEmail() async =>
      await _authUseCases.resendVerificationEmail();

  Future<void> deleteUser(BuildContext context) async {
    final results = await _authUseCases.deleteUser();

    results.fold((error) {
      if (context.mounted) {
        showCustomAlertDialog(context, error.message);
      }
    }, (_) {
      state = const UnauthenticatedAuthState(fromSignIn: false);
      Navigator.of(context).pushNamed(RouteGenerator.signInScreen);
    });
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    state = const LoadingAuth();
    final result = await _authUseCases.signInWithGoogle();
    result.fold(
      (error) {
        state = UnauthenticatedAuthState(error: error, fromSignIn: true);
        if (context.mounted) {
          showCustomAlertDialog(context, error.message);
        }
      },
      (user) {
        _userUseCases.createUserDataIfNotExist(user.user!, FreePackage());
        state = AuthenticatedAuth(user.user!);
        Navigator.of(context).pushNamed(RouteGenerator.homePageScreen);
      },
    );
  }

  Future<void> signInWithGithub(BuildContext context) async {
    state = const LoadingAuth();
    final result = await _authUseCases.signInWithGithub();
    result.fold(
      (error) {
        state = UnauthenticatedAuthState(error: error, fromSignIn: true);
        if (context.mounted) {
          showCustomAlertDialog(context, error.message);
        }
      },
      (user) {
        _userUseCases.createUserDataIfNotExist(user.user!, FreePackage());
        state = AuthenticatedAuth(user.user!);
        Navigator.of(context).pushNamed(RouteGenerator.homePageScreen);
      },
    );
  }


}
