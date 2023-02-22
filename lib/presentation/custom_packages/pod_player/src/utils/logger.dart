import 'dart:developer';

import '../../pod_player.dart';

void podLog(String message) =>
    CustomPodVideoPlayer.enableLogs ? log(message, name: 'POD') : null;
