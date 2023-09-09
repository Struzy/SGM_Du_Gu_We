import 'package:assets_audio_player/src/playable.dart';
import 'package:flutter/material.dart';
import 'package:sgm_du_gu_we/constants/padding.dart';
import '../constants/box_size.dart';
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
      final titleComparison = a.metas.title?.compareTo(b.metas.title!);

      return titleComparison;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const nav.NavigationDrawer(),
        appBar: AppBar(
          title: const Text('Videothek'),
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
                  hintText: 'Nach Namen durchsuchen...',
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
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VideoPlayerDetailScreen(
                              title: audio.metas.title,
                              url: audio.url,
                            ),
                          ),
                        );
                      },
                      leading: Image.network(
                        audio.thumbNail,
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
                        audio.metas.title,
                      ),
                      subtitle: Text(
                        audio.metas.author,
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
          .where((audio) => audio.metas.title.toLowerCase().contains(
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
