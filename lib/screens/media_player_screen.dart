import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:sgm_du_gu_we/constants/padding.dart';
import '../widgets/navigation_drawer.dart' as nav;

class MediaPlayerScreen extends StatefulWidget {
  const MediaPlayerScreen({super.key});

  static const String id = 'media_player_screen';

  @override
  MediaPlayerScreenState createState() => MediaPlayerScreenState();
}

class MediaPlayerScreenState extends State<MediaPlayerScreen> {
  final assetsAudioPlayer = AssetsAudioPlayer();

  @override
  void initState() {
    super.initState();
    loadAudioFromWeb(assetsAudioPlayer);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const nav.NavigationDrawer(),
        appBar: AppBar(
          title: const Text(
            'Media Player',
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(
            kPadding,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                StreamBuilder(
                  stream: assetsAudioPlayer.current,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) return CircularProgressIndicator();
                    final Playing? playing = snapshot.data;
                    return Text('dummy');
                  },
                ),
                SizedBox(height: 20.0),
                // Play/Pause Button
                IconButton(
                  icon: Icon(Icons.play_arrow),
                  onPressed: () {
                    assetsAudioPlayer.playOrPause();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void loadAudioFromWeb(AssetsAudioPlayer assetsAudioPlayer) {
    final audio = Audio.network(
      'https://firebasestorage.googleapis.com/v0/b/sgm-duguwe.appspot.com/o/Lieder%2FSGM_Wir_sind_die_SGM.mp3?alt=media&token=0f44daf8-8a96-4b47-9a0b-10f2b0b0c03f', // Replace with your audio URL
    );
    assetsAudioPlayer.open(audio);
  }
}
