import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:sgm_du_gu_we/classes/album_list.dart';
import '../classes/album.dart';
import '../constants/padding.dart';

List<Album> albums = getAlbums();

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  static const String id = 'gallery_screen';

  @override
  GalleryScreenState createState() => GalleryScreenState();
}

class GalleryScreenState extends State<GalleryScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Galerie',
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(
            kPadding,
          ),
          child: GridView.count(
            crossAxisCount: 2,
            children: List.generate(albums.length, (index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AlbumScreen(
                        album: albums[index],
                      ),
                    ),
                  );
                },
                child: Card(
                  child: Column(
                    children: [
                      Expanded(
                        child: FutureBuilder(
                          future: FirebaseStorage.instance
                              .refFromURL(albums[index].albumCoverPath)
                              .getDownloadURL(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (snapshot.hasError) {
                              return const Center(
                                child: Text(
                                  'Beim Laden ist ein Fehler aufgetreten.',
                                ),
                              );
                            } else {
                              return Image.network(
                                snapshot.data.toString(),
                                fit: BoxFit.cover,
                              );
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(
                          10.0,
                        ),
                        child: Text(
                          albums[index].albumName,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class AlbumScreen extends StatelessWidget {
  const AlbumScreen({super.key, required this.album});

  final Album album;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            album.albumName,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(
            kPadding,
          ),
          child: GridView.count(
            crossAxisCount: 2,
            children: List.generate(album.picturePaths.length, (index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PictureScreen(
                        picturePath: album.picturePaths[index],
                      ),
                    ),
                  );
                },
                child: Card(
                  child: FutureBuilder(
                    future: FirebaseStorage.instance
                        .refFromURL(album.picturePaths[index])
                        .getDownloadURL(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        return const Center(
                          child: Text(
                            'Beim Laden ist ein Fehler aufgetreten.',
                          ),
                        );
                      } else {
                        return Image.network(
                          snapshot.data.toString(),
                          fit: BoxFit.cover,
                        );
                      }
                    },
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class PictureScreen extends StatelessWidget {
  const PictureScreen({super.key, required this.picturePath});

  final String picturePath;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
        ),
        body: Container(
          color: Colors.black,
          child: Center(
            child: FutureBuilder(
              future: FirebaseStorage.instance
                  .refFromURL(picturePath)
                  .getDownloadURL(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return const Text(
                    'Beim Laden ist ein Fehler aufgetreten.',
                  );
                } else {
                  return Image.network(
                    snapshot.data.toString(),
                    fit: BoxFit.contain,
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

// Get all the albums
List<Album> getAlbums() {
  AlbumList albumList = AlbumList();

  return albumList.albumList;
}
