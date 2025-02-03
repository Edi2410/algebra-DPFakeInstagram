import 'package:dp_project/feature/profile/domain/entity/custom_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dp_project/core/error/failure.dart';

sealed class AuthState {
  const AuthState();
}

class LoadingAuth extends AuthState {
  const LoadingAuth();
}

class UnauthenticatedAuthState extends AuthState {
  final Failure? error;
  final bool fromSignIn;

  const UnauthenticatedAuthState({this.error, required this.fromSignIn});
}

class AuthenticatedAuth extends AuthState {
  final User authUser;

  const AuthenticatedAuth(this.authUser);
}
