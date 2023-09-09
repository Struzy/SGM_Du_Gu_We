import 'package:sgm_du_gu_we/models/video.dart';
import '../constants/sgm_logo_directory.dart';
import '../constants/video_directory.dart';

class VideoList {
  List<Video> videoList = [
    Video(
      thumbNail: kSGMLogo,
      title: 'Die SGM bleibt zuhause',
      author: 'SGM Durchhausen/Gunningen',
      url: Uri.parse(
        kSGMStaysAtHome,
      ),
    ),
  ];
}
