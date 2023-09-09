import 'package:assets_audio_player/assets_audio_player.dart';
import '../constants/music_directory.dart';
import '../constants/sgm_logo_directory.dart';

class AudioList {
  final audios = <Audio>[
    Audio.network(
      kWeAreTheSGM,
      metas: Metas(
        id: 'Online',
        title: 'Wir sind die SGM',
        artist: 'SGM Du/Gu/We',
        album: 'SGM Durchhausen/Gunningen',
        image: const MetasImage.network(kSGMLogo),
      ),
    ),
    Audio.network(
      kTheBoysInGreenWhite,
      metas: Metas(
        id: 'Online',
        title: 'Die Boys in grün weiß',
        artist: 'SVD',
        album: 'SV Durchhausen',
        image: const MetasImage.network(kSVDLogo),
      ),
    ),
    Audio.network(
      kTheBoysInGreenWhiteRetroVersion,
      metas: Metas(
        id: 'Online',
        title: 'Die Boys in grün weiß (Retro Version)',
        artist: 'SVD',
        album: 'SV Durchhausen',
        image: const MetasImage.network(kSVDLogo),
      ),
    ),
    Audio.network(
      kWeAreTheSVD,
      metas: Metas(
        id: 'Online',
        title: 'Wir sind der SVD',
        artist: 'SVD',
        album: 'SV Durchhausen',
        image: const MetasImage.network(kSVDLogo),
      ),
    ),
  ];
}
