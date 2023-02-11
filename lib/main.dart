import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:youtube/core/my_app.dart';
import 'package:youtube/core/utility/injector.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await initializeDependencies();
  runApp(const MyApp());
}
