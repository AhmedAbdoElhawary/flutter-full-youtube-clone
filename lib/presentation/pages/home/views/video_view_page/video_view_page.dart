import 'package:flutter/material.dart';
import 'package:youtube/core/resources/color_manager.dart';

class VideoViewPage extends StatelessWidget {
  const VideoViewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Container(color: ColorManager.green,child: Column(children: [
        Listener(child: Container(color: ColorManager.teal,height: 200,width: double.infinity,))
      ],),),),
    );
  }
}
