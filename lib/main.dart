import 'package:musicplayer/screen/albums.dart';
import 'package:musicplayer/screen/genres.dart';
import 'package:musicplayer/screen/playlist.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.black,
    statusBarColor: Colors.black,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'musicplayer Music',
      theme: ThemeData.dark(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
      /*theme: ThemeData(
        primarySwatch: Colors.blue,
      ),*/
      initialRoute: '/offlinePlayList',
      routes: {
        '/offlinePlayList': (context) => const PlayList(
              mode: "Offline",
            ),
        '/offlineAlbums': (context) => const Albums(
              mode: "Offline",
            ),
        '/offlineGenres': (context) => const Genres(
              mode: "Offline",
            ),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
