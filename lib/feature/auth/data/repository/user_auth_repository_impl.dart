import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dp_project/core/error/failure.dart';
import 'package:dp_project/feature/auth/data/firabase/user_firebase_auth_api.dart';
import 'package:dp_project/feature/auth/domain/repository/user_auth_repository.dart';

class UserAuthRepositoryImpl implements UserAuthRepository {
  final UserFirebaseAuthApi _api;

  const UserAuthRepositoryImpl(this._api);

  @override
  Future<Either<Failure, void>> resetPassword(String email) async {
    try {
      final result = await _api.resetPassword(email);

      return Right(result);
    } on FirebaseAuthException catch (e) {
      return Left(FirebaseError(message: e.message ?? ''));
    } on Exception catch (e) {
      return Left(GeneralError(message: e.toString()));
    }

  }

  @override
  Future<Either<Failure, User?>> signInUser(String email, String password) async {
    try {
      final result = await _api.signInUser(email, password);
      return Right(result);
    } on FirebaseAuthException catch (e) {
      return Left(FirebaseError(message: e.message ?? ''));
    } on Exception catch (e) {
      return Left(GeneralError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, User?>> signUpUser(String email, String password) async {

    try {
      final result = await _api.signUpUser(email, password);
      return Right(result);
    } on FirebaseAuthException catch (e) {
      return Left(FirebaseError(message: e.message ?? ''));
    } on Exception catch (e) {
      return Left(GeneralError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> resendVerificationEmail() async {
    try{
      final result = _api.resendVerificationEmail();
      return Right(result);
    } on FirebaseAuthException catch (e) {
      return Left(FirebaseError(message: e.message ?? ''));
    } on Exception catch (e) {
      return Left(GeneralError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> signOutUser()async {
    try {
      final result = _api.signOut();
      return Right(result);
    } on FirebaseAuthException catch (e) {
      return Left(FirebaseError(message: e.message ?? ''));
    } on Exception catch (e) {
      return Left(GeneralError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteUser() async {
    try {
      final result = _api.deleteUser();
      return Right(result);
    } on FirebaseAuthException catch (e) {
      return Left(FirebaseError(message: e.message ?? ''));
    } on Exception catch (e) {
      return Left(GeneralError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserCredential>> signInWithGoogle() async {
    try {
      final result = await _api.signInWithGoogle();
      return Right(result);
    } on FirebaseAuthException catch (e) {
      return Left(FirebaseError(message: e.message ?? ''));
    } on Exception catch (e) {
      return Left(GeneralError(message: e.toString()));
    }
  }


  @override
  Future<Either<Failure, UserCredential>> signInWithGithub() async {
    try {
      final result = await _api.signInWithGithub();
      return Right(result);
    } on FirebaseAuthException catch (e) {
      return Left(FirebaseError(message: e.message ?? ''));
    } on Exception catch (e) {
      return Left(GeneralError(message: e.toString()));
    }
  }
}