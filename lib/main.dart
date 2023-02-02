import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:youtube/core/my_app.dart';

Future<void> main() async {
  await GetStorage.init();

  runApp(const MyApp());
}
