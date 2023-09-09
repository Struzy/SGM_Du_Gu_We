import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../widgets/basic_overlay.dart';
import 'build_video_player.dart';

Widget buildVideo(VideoPlayerController controller) => Stack(
  children: <Widget>[
    buildVideoPlayer(controller),
    Positioned.fill(
      child: BasicOverlay(
        controller: controller,
      ),
    ),
  ],
);