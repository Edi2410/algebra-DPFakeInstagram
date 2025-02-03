import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserFirebaseAuthApi {
  final FirebaseAuth instance;

  const UserFirebaseAuthApi(this.instance);

  Future<User?> signInUser(final String email, final String password) async {
    final credential = await instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    return credential.user;
  }

  Future<User?> signUpUser(final String email, final String password) async {
    final credential = await instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return credential.user;
  }

  Future<void> resetPassword(final String email) =>
      instance.sendPasswordResetEmail(email: email);

  Future<void> signOut() => instance.signOut();

  Future<void> deleteUser() => instance.currentUser!.delete();

  Future<void> resendVerificationEmail() =>
      instance.currentUser!.sendEmailVerification();

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<UserCredential> signInWithGithub() async {
    final GithubAuthProvider githubProvider = GithubAuthProvider();

    if (kIsWeb) {
      return await FirebaseAuth.instance.signInWithPopup(githubProvider);
    } else {
      return await FirebaseAuth.instance.signInWithProvider(githubProvider);
    }
  }


}
