import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sgm_du_gu_we/constants/color.dart';
import 'package:sgm_du_gu_we/constants/font_size.dart';
import 'package:sgm_du_gu_we/constants/padding.dart';
import 'package:video_player/video_player.dart';
import '../constants/box_size.dart';
import '../constants/circle_avatar.dart';
import '../constants/timer.dart';
import '../models/video.dart';
import '../models/video_list.dart';
import '../widgets/build_video.dart';

List<Video> videos = getVideos();
List<Video> filteredVideos = List<Video>.from(videos);

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({super.key});

  static const String id = 'video_player_screen';

  @override
  VideoPlayerScreenState createState() => VideoPlayerScreenState();
}

class VideoPlayerScreenState extends State<VideoPlayerScreen> {
  final TextEditingController searchController = TextEditingController();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    filteredVideos.sort((a, b) {
      final titleComparison = a.title.compareTo(b.title);

      return titleComparison;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Videothek'),
      ),
      body: SafeArea(
        child: Padding(
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
                  itemCount: filteredVideos.length,
                  itemBuilder: (context, index) {
                    final video = filteredVideos[index];

                    return ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VideoPlayerDetailScreen(
                              title: video.title,
                              url: video.url,
                            ),
                          ),
                        );
                      },
                      leading: Image.network(
                        video.thumbNail,
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
                        video.title,
                      ),
                      subtitle: Text(
                        video.author,
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
      filteredVideos = videos
          .where((video) => video.title.toLowerCase().contains(
                searchQuery.toLowerCase(),
              ))
          .toList();
    } else {
      filteredVideos = List<Video>.from(videos);
    }
    setState(() {
      // Update the UI with the filtered list
    });
  }
}

class VideoPlayerDetailScreen extends StatefulWidget {
  const VideoPlayerDetailScreen(
      {super.key, required this.url, required this.title});

  final String title;
  final Uri url;

  @override
  State<VideoPlayerDetailScreen> createState() =>
      VideoPlayerDetailScreenState();
}

class VideoPlayerDetailScreenState extends State<VideoPlayerDetailScreen> {
  VideoPlayerController controller =
      VideoPlayerController.networkUrl(Uri.parse(''));
  late StreamController<Duration> timeController;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    filteredVideos.sort((a, b) {
      final titleComparison = a.title.compareTo(b.title);

      return titleComparison;
    });
    controller = VideoPlayerController.networkUrl(widget.url)
      ..addListener(() => setState(() {}))
      ..setLooping(true)
      ..initialize().then((_) => controller.play());
    timer = Timer.periodic(
        const Duration(
          seconds: kTimerVideo,
        ), (_) {
      if (mounted) {
        timeController.add(controller.value.position);
      }
    });
    timeController = StreamController<Duration>();
  }

  @override
  void dispose() {
    controller.dispose();
    timeController.close();
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMuted = controller.value.volume == 0;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              controller.value.isInitialized
                  ? Container(
                      alignment: Alignment.center,
                      child: buildVideo(controller),
                    )
                  : const CircularProgressIndicator(),
              const SizedBox(
                height: kBoxHeight,
              ),
              if (controller.value.isInitialized)
                StreamBuilder<Duration>(
                  stream: timeController.stream,
                  builder: (context, snapshot) {
                    final position = snapshot.data ?? Duration.zero;
                    final remaining = controller.value.duration - position;
                    return Text(
                      '${formatDuration(position)}/${formatDuration(remaining)}',
                      style: const TextStyle(
                        fontSize: kFontsizeSubtitle,
                      ),
                    );
                  },
                ),
              const SizedBox(
                height: kBoxHeight + 40.0,
              ),
              CircleAvatar(
                radius: kRadiusVideoPlayButton,
                backgroundColor: kSGMColorGreen,
                child: IconButton(
                  onPressed: () => controller.setVolume(isMuted ? 1 : 0),
                  icon: Icon(
                    isMuted ? Icons.volume_mute : Icons.volume_up,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Format duration of current playing video
String formatDuration(Duration duration) {
  final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
  final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
  return '$minutes:$seconds';
}

// Get all the videos
List<Video> getVideos() {
  VideoList videoList = VideoList();

  return videoList.videoList;
}
