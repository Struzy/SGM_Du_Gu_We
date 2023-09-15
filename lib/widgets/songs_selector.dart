import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:sgm_du_gu_we/constants/color.dart';
import '../constants/box_size.dart';
import '../constants/font_family.dart';

class SongsSelector extends StatelessWidget {
  final Playing? playing;
  final List<Audio> audios;
  final Function(Audio) onSelected;
  final Function(List<Audio>) onPlaylistSelected;

  SongsSelector(
      {super.key,
      required this.playing,
      required this.audios,
      required this.onSelected,
      required this.onPlaylistSelected});

  Widget image(Audio item) {
    if (item.metas.image == null) {
      return const SizedBox(
        height: kHeightMetasImage,
        width: kWidthMetasImage,
      );
    }

    return item.metas.image?.type == ImageType.network
        ? Image.network(
            item.metas.image!.path,
            height: kHeightMetasImage,
            width: kWidthMetasImage,
            fit: BoxFit.cover,
            loadingBuilder: loadingBuilder,
          )
        : Image.asset(
            item.metas.image!.path,
            height: kHeightMetasImage,
            width: kWidthMetasImage,
            fit: BoxFit.cover,
          );
  }

  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        FractionallySizedBox(
          widthFactor: 1,
          child: TextButton(
            onPressed: () {
              onPlaylistSelected(audios);
            },
            child: const Center(
              child: Text(
                'Alle als Playlist',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: kSpartanMB,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: kBoxHeight,
        ),
        Flexible(
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final audio = audios[index];
              final isPlaying = audio.path == playing?.audio.assetAudioPath;

              return ListTile(
                  leading: Material(
                    shape: const CircleBorder(),
                    clipBehavior: Clip.antiAlias,
                    child: image(audio),
                  ),
                  title: Text(audio.metas.title.toString(),
                      style: TextStyle(
                        color: isPlaying ? kSGMColorBlue : Colors.black,
                      )),
                  subtitle: Text(
                    audio.metas.artist.toString(),
                  ),
                  onTap: () {
                    onSelected(audio);
                  });
            },
            itemCount: audios.length,
          ),
        ),
      ],
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
