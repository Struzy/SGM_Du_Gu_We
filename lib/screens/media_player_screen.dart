import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:sgm_du_gu_we/models/song_list.dart';
import 'package:sgm_du_gu_we/constants/padding.dart';
import '../models/song.dart';
import '../widgets/navigation_drawer.dart';

class MediaPlayerScreen extends StatefulWidget {
  const MediaPlayerScreen({super.key});

  static const String id = 'media_player_screen';

  @override
  MediaPlayerScreenState createState() => MediaPlayerScreenState();
}

class MediaPlayerScreenState extends State<MediaPlayerScreen> {
  AudioPlayer audioPlayer = AudioPlayer();
  String currentSong = '';
  bool isPlaying = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const NavigationDrawer(),
        appBar: AppBar(
          title: const Text(
            'Media Player',
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(
            kPadding,
          ),
          child: ListView.builder(
            //itemCount: songs.length,
            itemBuilder: (context, index) {
              //final song = songs[index];
              return ListTile(
                //leading: CachedNetworkImage(
                  //imageUrl: song.coverPath,
                  //placeholder: (context, url) =>
                  //const CircularProgressIndicator(),
                  //errorWidget: (context, url, error) => const Icon(
                    //Icons.error,
                  //),
                //),
                //title: Text(song.title,),
                //onTap: () => playSong(song.songPath),
              );
            },
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.stop,
                ),
                onPressed: stopSong,
              ),
              IconButton(
                icon: const Icon(
                  Icons.pause,
                ),
                onPressed: pauseSong,
              ),
              IconButton(
                icon: const Icon(
                  Icons.skip_next,
                ),
                onPressed: skipToNextSong,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Load songs
  Future<List<String>> loadSongs() async {
    List<Reference> references = await FirebaseStorage.instance.ref().child('Lieder').listAll().then((value) => value.items);
    return Future.value(references.map((ref) => ref.name).toList());
  }

  // Play song
  Future<void> playSong(String songUrl) async {
    if (isPlaying) {
      await audioPlayer.stop();
    }
    int result = await audioPlayer.play(songUrl);
    if (result == 1) {
      setState(() {
        isPlaying = true;
        currentSong = songUrl;
      });
    }
  }

  // Pause song
  Future<void> pauseSong() async {
    if (isPlaying) {
      await audioPlayer.pause();
      setState(() {
        isPlaying = false;
      });
    }
  }

  // Stop song
  Future<void> stopSong() async {
    if (isPlaying) {
      await audioPlayer.stop();
      setState(() {
        isPlaying = false;
        currentSong = '';
      });
    }
  }

  // Skip to next song
  Future<void> skipToNextSong() async {
    //int currentIndex = songList.indexOf(currentSong);
    //if (currentIndex < songList.length - 1) {
      //String nextSong = songList[currentIndex + 1];
      //await playSong(nextSong);
    } //else {
      // If it's the last song, stop playing
      //stopSong();
    }
  //}
//}

// Get all the songs
List<Song> loadSongs() {
  SongList songList = SongList();

  return songList.songList;
}