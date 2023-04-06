
import 'package:flutter/material.dart';

const String youtubeBaseUrl = "https://www.googleapis.com/youtube/v3/";
const String autoCompleteBaseUrl =
    "https://suggestqueries.google.com/complete/";
bool isThatMobile = true;
bool isThatAndroid = true;
Size screenSize = const Size(0, 0);

BuildContext? savedContext;
