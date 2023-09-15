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
      children: [
        GestureDetector(
          onTap: () {
            if (toggleLoop != null) toggleLoop!();
          },
          child: loopIcon(context),
        ),
        const SizedBox(
          width: kBoxWidthPlayingControls,
        ),
        TextButton(
          onPressed: isPlaylist ? onPrevious : null,
          child: const Icon(
            AssetAudioPlayerIcons.to_start,
            size: kPlayingControlIcons,
            color: Colors.black,
          ),
        ),
        const SizedBox(
          width: kBoxWidthPlayingControls,
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
        const SizedBox(
          width: kBoxWidthPlayingControls,
        ),
        TextButton(
          onPressed: isPlaylist ? onNext : null,
          child: const Icon(
            AssetAudioPlayerIcons.to_end,
            size: kPlayingControlIcons,
            color: Colors.black,
          ),
        ),
        const SizedBox(
          width: kBoxWidthStopControl,
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
