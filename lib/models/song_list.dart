import 'package:sgm_du_gu_we/models/song.dart';

class SongList {
  List<Song> songList = [
    Song(
      title: 'SGM - Wir sind die SGM',
      coverPath: 'gs://sgm-duguwe.appspot.com/App Icon/sgm_du_gu_we.PNG',
      songPath: 'gs://sgm-duguwe.appspot.com/Lieder/SGM_Wir_sind_die_SGM.mp3',
    ),
    Song(
      title: 'SVD - Die Boys in grün-weiß (Remastered)',
      coverPath: 'gs://sgm-duguwe.appspot.com/App Icon/SVD.jpg',
      songPath:
          'gs://sgm-duguwe.appspot.com/Lieder/SVD_Die_Boys_in_gruen_weiss.mp3',
    ),
    Song(
      title: 'SVD - Die Boys in grün-weiß (alte Version)',
      coverPath: 'gs://sgm-duguwe.appspot.com/App Icon/SVD.jpg',
      songPath:
          'gs://sgm-duguwe.appspot.com/Lieder/SV_Durchhausen_Die_Boys_in_Gruenweiss.mp3',
    ),
    Song(
      title: 'SVD - Wir sind der SVD',
      coverPath: 'gs://sgm-duguwe.appspot.com/App Icon/SVD.jpg',
      songPath:
          'gs://sgm-duguwe.appspot.com/Lieder/SV_Durchhausen_Wir_sind_der_SVD.mp3',
    ),
  ];
}
