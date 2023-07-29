class Album {
  Album({
    required this.albumName,
    required this.albumCoverPath,
    required this.picturePaths,
  });

  final String albumName;
  final String albumCoverPath;
  final List<String> picturePaths;
}
