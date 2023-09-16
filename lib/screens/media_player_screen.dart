import 'dart:async';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:sgm_du_gu_we/constants/padding.dart';
import '../constants/box_size.dart';
import '../constants/color.dart';
import '../constants/duration.dart';
import '../constants/font_family.dart';
import '../constants/image.dart';
import '../models/audio_list.dart';
import '../widgets/playing_controls.dart';
import '../widgets/position_seek.dart';
import '../widgets/songs_selector.dart';

List<Audio> audios = getAudios();
List<Audio> filteredAudios = List<Audio>.from(audios);

class MediaPlayerScreen extends StatefulWidget {
  const MediaPlayerScreen({super.key});

  static const String id = 'media_player_screen';

  @override
  MediaPlayerScreenState createState() => MediaPlayerScreenState();
}

class MediaPlayerScreenState extends State<MediaPlayerScreen> {
  final TextEditingController searchController = TextEditingController();
  bool isLoading = true;
  late AssetsAudioPlayer audioPlayer;
  final List<StreamSubscription> subscriptions = [];

  @override
  void initState() {
    super.initState();
    filteredAudios.sort((a, b) {
      final titleComparison = a.metas.title!.compareTo(b.metas.title!);

      return titleComparison;
    });

    audioPlayer = AssetsAudioPlayer.newPlayer();
    subscriptions.add(audioPlayer.playlistAudioFinished.listen((data) {}));
    subscriptions.add(audioPlayer.audioSessionId.listen((sessionId) {}));

    openPlayer();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  Audio find(List<Audio> source, String fromPath) {
    return source.firstWhere((element) => element.path == fromPath);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Mediathek',
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(
            kPadding,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextField(
                  controller: searchController,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  decoration: const InputDecoration(
                    icon: Icon(
                      Icons.search,
                    ),
                    hintText: 'Nach Titeln durchsuchen...',
                  ),
                  onChanged: (value) {
                    filterVideos(value);
                  },
                ),
                const SizedBox(
                  height: kBoxHeight,
                ),
                Stack(
                  fit: StackFit.passthrough,
                  children: <Widget>[
                    StreamBuilder<Playing?>(
                        stream: audioPlayer.current,
                        builder: (context, playing) {
                          if (playing.data != null) {
                            final audio = find(filteredAudios,
                                playing.data!.audio.assetAudioPath);
                            return Padding(
                                padding: const EdgeInsets.all(
                                  kPadding,
                                ),
                                child: audio.metas.image?.path == null
                                    ? const SizedBox()
                                    : Image.network(
                                        audio.metas.image!.path,
                                        height: kImageHeight,
                                        width: kImageWidth,
                                        fit: BoxFit.contain,
                                        loadingBuilder: loadingBuilder,
                                      ));
                          }
                          return const SizedBox.shrink();
                        }),
                  ],
                ),
                const SizedBox(
                  height: kBoxHeight,
                ),
                const SizedBox(
                  height: kBoxHeight,
                ),
                audioPlayer.builderCurrent(
                    builder: (context, Playing? playing) {
                  return Column(
                    children: <Widget>[
                      audioPlayer.builderLoopMode(
                        builder: (context, loopMode) {
                          return PlayerBuilder.isPlaying(
                              player: audioPlayer,
                              builder: (context, isPlaying) {
                                return PlayingControls(
                                  loopMode: loopMode,
                                  isPlaying: isPlaying,
                                  isPlaylist: true,
                                  onStop: () {
                                    audioPlayer.stop();
                                  },
                                  toggleLoop: () {
                                    audioPlayer.toggleLoop();
                                  },
                                  onPlay: () {
                                    audioPlayer.playOrPause();
                                  },
                                  onNext: () {
                                    audioPlayer.next(
                                      keepLoopMode: true,
                                    );
                                  },
                                  onPrevious: () {
                                    audioPlayer.previous();
                                  },
                                );
                              });
                        },
                      ),
                      audioPlayer.builderRealtimePlayingInfos(
                          builder: (context, RealtimePlayingInfos? infos) {
                        if (infos == null) {
                          return const SizedBox();
                        }
                        return Column(
                          children: [
                            PositionSeekWidget(
                              currentPosition: infos.currentPosition,
                              duration: infos.duration,
                              seekTo: (to) {
                                audioPlayer.seek(to);
                              },
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    audioPlayer.seekBy(
                                      const Duration(
                                        seconds: -kDuration,
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    '-10',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: kSpartanMB,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: kBoxWidthPlayingControls,
                                ),
                                TextButton(
                                  onPressed: () {
                                    audioPlayer.seekBy(
                                      const Duration(
                                        seconds: kDuration,
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    '+10',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: kSpartanMB,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        );
                      }),
                    ],
                  );
                }),
                const SizedBox(
                  height: kBoxHeight,
                ),
                audioPlayer.builderCurrent(
                    builder: (BuildContext context, Playing? playing) {
                  return SongsSelector(
                    audios: filteredAudios,
                    onPlaylistSelected: (filteredAudios) {
                      audioPlayer.open(
                        Playlist(audios: filteredAudios),
                        showNotification: true,
                        headPhoneStrategy:
                            HeadPhoneStrategy.pauseOnUnplugPlayOnPlug,
                        audioFocusStrategy: const AudioFocusStrategy.request(
                            resumeAfterInterruption: true),
                      );
                    },
                    onSelected: (audio) async {
                      try {
                        await audioPlayer.open(
                          audio,
                          autoStart: true,
                          showNotification: true,
                          playInBackground: PlayInBackground.enabled,
                          audioFocusStrategy: const AudioFocusStrategy.request(
                              resumeAfterInterruption: true,
                              resumeOthersPlayersAfterDone: true),
                          headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplug,
                          notificationSettings: const NotificationSettings(),
                        );
                      } catch (e) {
                        showSnackBar(
                          'Lied konnte nicht abgespielt werden.',
                        );
                      }
                    },
                    playing: playing,
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Filter the list based on a search query
  // This function will take the search query as input and update the list
  // players accordingly
  void filterVideos(String searchQuery) {
    if (searchQuery.isNotEmpty) {
      filteredAudios = audios
          .where((audio) => audio.metas.title!.toLowerCase().contains(
                searchQuery.toLowerCase(),
              ))
          .toList();
    } else {
      filteredAudios = List<Audio>.from(audios);
    }
    setState(() {
      // Update the UI with the filtered list
    });
  }

  // Loading builder
  Widget loadingBuilder(
      BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
    if (loadingProgress == null) {
      isLoading = false;
      return child;
    }
    return const CircularProgressIndicator(
      color: kSGMColorGreen,
    );
  }

  // Show snack bar
  void showSnackBar(String snackBarText) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          snackBarText,
        ),
      ),
    );
  }

  void openPlayer() async {
    await audioPlayer.open(
      Playlist(
        audios: filteredAudios,
        startIndex: 0,
      ),
      showNotification: true,
      autoStart: false,
    );
  }
}

// Get all the videos
List<Audio> getAudios() {
  AudioList audioList = AudioList();

  return audioList.audios;
}
