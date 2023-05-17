import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:youtube/core/utility/private_key.dart';

class AuthService {
  static signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      final googleAuth = await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      UserCredential cred =
          await FirebaseAuth.instance.signInWithCredential(credential);

      accessToken = cred.credential?.accessToken ?? "";
    } catch (e) {
      if (kDebugMode) print("error------------------> ${e.toString()}");
    }
  }
}
