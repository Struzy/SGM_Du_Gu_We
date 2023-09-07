import 'package:flutter/material.dart';
import 'package:sgm_du_gu_we/constants/color.dart';
import 'package:sgm_du_gu_we/constants/padding.dart';
import 'package:video_player/video_player.dart';
import '../constants/box_size.dart';
import '../models/video.dart';
import '../models/video_list.dart';
import '../widgets/navigation_drawer.dart' as nav;

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
  late VideoPlayerController controller;
  final url = getVideos().first.url;

  @override
  void initState() {
    super.initState();
    filteredVideos.sort((a, b) {
      final titleComparison =
      a.title.compareTo(b.title);

      return titleComparison;
    });
    controller = VideoPlayerController.networkUrl(url)
      ..addListener(() => setState(() {}))
      ..setLooping(true)
      ..initialize().then((_) => controller.play());
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMuted = controller.value.volume == 0;

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
                child: /*ListView.builder(
                  itemCount: filteredVideos.length,
                  itemBuilder: (context, index) {
                    final player = filteredVideos[index];

                    return ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SquadDetailScreen(
                              profilePicture: player.profilePicture,
                              name: player.name,
                            ),
                          ),
                        );
                      },
                      leading: Image.network(
                        player.profilePicture,
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
                        player.name,
                      ),
                    );
                  },
                ),*/
              ),
              VideoPlayerWidget(controller: controller),
              const SizedBox(
                height: 32,
              ),
              if (controller.value.isInitialized)
                CircleAvatar(
                  radius: 30,
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

// Get all the videos
List<Video> getVideos() {
  VideoList videoList = VideoList();

  return videoList.videoList;
}

class VideoPlayerWidget extends StatelessWidget {
  const VideoPlayerWidget({super.key, required this.controller});

  final VideoPlayerController controller;

  @override
  Widget build(BuildContext context) => controller.value.isInitialized
      ? Container(
          alignment: Alignment.topCenter,
          child: buildVideo(),
        )
      : const CircularProgressIndicator();

  Widget buildVideo() => Stack(
        children: <Widget>[
          buildVideoPlayer(),
          Positioned.fill(child: BasicOverlayWidget(controller: controller)),
        ],
      );

  Widget buildVideoPlayer() => AspectRatio(
        aspectRatio: controller.value.aspectRatio,
        child: VideoPlayer(
          controller,
        ),
      );
}

class BasicOverlayWidget extends StatelessWidget {
  const BasicOverlayWidget({super.key, required this.controller});

  final VideoPlayerController controller;

  @override
  Widget build(BuildContext context) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () =>
            controller.value.isPlaying ? controller.pause() : controller.play(),
        child: Stack(
          children: <Widget>[
            buildPlay(),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: buildIndicator(),
            ),
          ],
        ),
      );

  Widget buildIndicator() => VideoProgressIndicator(
        controller,
        allowScrubbing: true,
      );

  Widget buildPlay() => controller.value.isPlaying
      ? Container()
      : Container(
          alignment: Alignment.center,
          color: Colors.black26,
          child: const Icon(
            Icons.play_arrow,
            color: Colors.white,
            size: 80,
          ),
        );
}
