import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import '../constants/box_size.dart';
import '../constants/icon_size.dart';
import 'asset_audio_player_icons.dart';

class PlayingControls extends StatelessWidget {
  final bool isPlaying;
  final LoopMode? loopMode;
  final bool isPlaylist;
  final Function()? onPrevious;
  final Function() onPlay;
  final Function()? onNext;
  final Function()? toggleLoop;
  final Function()? onStop;

  const PlayingControls({
    super.key,
    required this.isPlaying,
    this.isPlaylist = false,
    this.loopMode,
    this.toggleLoop,
    this.onPrevious,
    required this.onPlay,
    this.onNext,
    this.onStop,
  });

  Widget loopIcon(BuildContext context) {
    const iconSize = kLoopIcon;
    if (loopMode == LoopMode.none) {
      return const Icon(
        Icons.loop,
        size: iconSize,
        color: Colors.grey,
      );
    } else if (loopMode == LoopMode.playlist) {
      return const Icon(
        Icons.loop,
        size: iconSize,
        color: Colors.black,
      );
    } else {
      return const Stack(
        alignment: Alignment.center,
        children: [
          Icon(
            Icons.loop,
            size: iconSize,
            color: Colors.black,
          ),
          Center(
            child: Text(
              '1',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            if (toggleLoop != null) toggleLoop!();
          },
          child: loopIcon(context),
        ),
        TextButton(
          onPressed: isPlaylist ? onPrevious : null,
          child: const Icon(
            AssetAudioPlayerIcons.to_start,
            size: kPlayingControlIcons,
            color: Colors.black,
          ),
        ),
        TextButton(
          onPressed: onPlay,
          child: Icon(
            isPlaying
                ? AssetAudioPlayerIcons.pause
                : AssetAudioPlayerIcons.play,
            size: kPlayingControlIcons,
            color: Colors.black,
          ),
        ),
        TextButton(
          onPressed: isPlaylist ? onNext : null,
          child: const Icon(
            AssetAudioPlayerIcons.to_end,
            size: kPlayingControlIcons,
            color: Colors.black,
          ),
        ),
        if (onStop != null)
          TextButton(
            onPressed: onStop,
            child: const Icon(
              AssetAudioPlayerIcons.stop,
              size: kPlayingControlIcons,
              color: Colors.black,
            ),
          ),
      ],
    );
  }
}
