import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:youtube/core/my_app.dart';
import 'package:youtube/core/utility/injector.dart';
import 'package:youtube/core/utility/private_key.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await initializeDependencies();
  final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
  final googleAuth = await googleUser?.authentication;
  String? token = googleAuth?.accessToken ?? "";
  accessToken = "Bearer $token";
  runApp(const MyApp());
}

final GoogleSignIn googleSignIn =
    GoogleSignIn(scopes: ['https://www.googleapis.com/auth/youtube.force-ssl']);





