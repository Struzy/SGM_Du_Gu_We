import 'dart:async';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:sgm_du_gu_we/constants/padding.dart';
import '../constants/box_size.dart';
import '../constants/color.dart';
import '../constants/font_size.dart';
import '../models/audio_list.dart';
import '../widgets/navigation_drawer.dart' as nav;

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

  @override
  void initState() {
    super.initState();
    filteredAudios.sort((a, b) {
      final titleComparison = a.metas.title!.compareTo(b.metas.title!);

      return titleComparison!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const nav.NavigationDrawer(),
        appBar: AppBar(
          title: const Text('Mediathek'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(
            kPadding,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
              Expanded(
                child: ListView.builder(
                  itemCount: filteredAudios.length,
                  itemBuilder: (context, index) {
                    final audio = filteredAudios[index];

                    return ListTile(
                      onTap: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MediaPlayerDetailScreen(
                              musicCover: audio.metas.image!.path,
                              title: audio.metas.title!,
                              artist: audio.metas.artist!,
                              audio: audio,
                            ),
                          ),
                        );
                      },
                      leading: Image.network(
                        audio.metas.image!.path,
                        fit: BoxFit.cover,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) {
                            isLoading = false;
                            return child;
                          }
                          return const CircularProgressIndicator();
                        },
                      ),
                      title: Text(
                        audio.metas.title!,
                      ),
                      subtitle: Text(
                        audio.metas.artist!,
                      ),
                    );
                  },
                ),
              ),
            ],
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
}

class MediaPlayerDetailScreen extends StatefulWidget {
  const MediaPlayerDetailScreen(
      {super.key,
      required this.title,
      required this.musicCover,
      required this.artist,
      required this.audio});

  final String title;
  final String musicCover;
  final String artist;
  final Audio audio;

  @override
  State<MediaPlayerDetailScreen> createState() =>
      MediaPlayerDetailScreenState();
}

class MediaPlayerDetailScreenState extends State<MediaPlayerDetailScreen> {
  bool isLoading = true;
  bool isPlaying = true;
  IconData playBtn = Icons.pause;
  late AssetsAudioPlayer audioPlayer;
  final List<StreamSubscription> subscriptions = [];

  Widget slider() {
    return Slider.adaptive(
        activeColor: Colors.black,
        inactiveColor: Colors.black54,
        value: audioPlayer.currentPosition.value.inSeconds.toDouble(),
        max: audioPlayer.currentPosition.value.inSeconds.toDouble(),
        onChanged: (value) {
          seekToSec(value.toInt());
        });
  }

  void seekToSec(int sec) {
    Duration newPos = Duration(seconds: sec);
    audioPlayer.seek(newPos);
  }

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

  void openPlayer() async {
    await audioPlayer.open(
      Playlist(audios: audios, startIndex: 0),
      showNotification: true,
      autoStart: true,
    );
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
            'Media Player',
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: kPadding + 50.0,
                ),
                child: SizedBox(
                  height: 150.0,
                  width: 150.0,
                  child: Image.network(
                    widget.musicCover,
                    fit: BoxFit.cover,
                    loadingBuilder: loadingBuilder,
                  ),
                ),
              ),
              const SizedBox(
                height: kBoxHeight,
              ),
              Text(
                widget.title,
                style: const TextStyle(
                  fontSize: kFontsizeTitle,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: kBoxHeight,
              ),
              Text(
                widget.artist,
                style: const TextStyle(
                  fontSize: kFontsizeSubtitle,
                ),
              ),
              const SizedBox(
                height: kBoxHeight + 50.0,
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(
                        30.0,
                      ),
                      topRight: Radius.circular(
                        30.0,
                      ),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      slider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.skip_previous,
                            ),
                            iconSize: 45.0,
                          ),
                          IconButton(
                            onPressed: () {
                              audioPlayer.playOrPause();
                              if (!isPlaying) {
                                setState(() {
                                  playBtn = Icons.pause;
                                  isPlaying = true;
                                });
                              } else {
                                setState(() {
                                  playBtn = Icons.play_arrow;
                                  isPlaying = false;
                                });
                              }
                            },
                            icon: Icon(
                              playBtn,
                            ),
                            iconSize: 62.0,
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.skip_next,
                            ),
                            iconSize: 45.0,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
}

// Format duration of current playing song
String formatDuration(Duration duration) {
  final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
  final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
  return '$minutes:$seconds';
}

// Get all the videos
List<Audio> getAudios() {
  AudioList audioList = AudioList();

  return audioList.audios;
}
