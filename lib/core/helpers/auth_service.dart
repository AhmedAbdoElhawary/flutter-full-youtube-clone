import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:youtube/core/utility/private_key.dart';

class AuthService {
  static signInWithGoogle() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    final GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: ['https://www.googleapis.com/auth/youtube.force-ssl']);

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      accessToken = credential.accessToken ?? "";

      final UserCredential userCredential =
          await auth.signInWithCredential(credential);

      user = userCredential.user;
    }

    return user;
  }
}
