import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:niamu_project/core/error/failure.dart';
import 'package:niamu_project/feature/auth/domain/repository/user_repository.dart';

class AuthUseCase {
  final UserRepository _userRepository;

  const AuthUseCase(this._userRepository);

  Future<Either<Failure, User?>> signIn(String email, String password) async {
    return await _userRepository.signInUser(email, password);
  }

  Future<Either<Failure, User?>> signUp(String email, String password) async {
    return await _userRepository.signUpUser(email, password);
  }

  Future<Either<Failure, void>> resetPassword(String email,) async {
    return await _userRepository.resetPassword(email);
  }

  Future<Either<Failure, void>> signOutUser() async {
    return await _userRepository.signOutUser();
  }

  Future<Either<Failure, void>> deleteUser() async {
    return await _userRepository.deleteUser();
  }

  Future<Either<Failure, void>> resendVerificationEmail() async {
    return await _userRepository.resendVerificationEmail();
  }
}