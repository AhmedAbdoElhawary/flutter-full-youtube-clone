import 'package:google_sign_in/google_sign_in.dart';
import 'package:youtube/core/utility/private_key.dart';

class AuthService {
  static final GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: ['https://www.googleapis.com/auth/youtube.force-ssl']);

  static signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    final googleAuth = await googleUser?.authentication;
    String? token = googleAuth?.accessToken ?? "";
    accessToken = token;
  }
}
