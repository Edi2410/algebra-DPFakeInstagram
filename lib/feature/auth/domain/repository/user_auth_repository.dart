import 'package:dartz/dartz.dart';
import 'package:dp_project/core/error/failure.dart';
import 'package:firebase_auth/firebase_auth.dart';


abstract interface class UserAuthRepository {
  Future<Either<Failure, User?>> signInUser(final String email, final String
  password);
  Future<Either<Failure, User?>> signUpUser(final String email, final String
  password);
  Future<Either<Failure, void>> resetPassword(final String email);

  Future<Either<Failure, void>> signOutUser();

  Future<Either<Failure, void>> resendVerificationEmail();

  Future<Either<Failure, void>> deleteUser();

  Future<Either<Failure, UserCredential>> signInWithGoogle();

  Future<Either<Failure, UserCredential>> signInWithGithub();

}