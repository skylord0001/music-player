import 'package:flutter/material.dart';

class EphoDrawer extends StatelessWidget {
  const EphoDrawer({super.key, required this.page});

  final page;
  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final index = page;
    return Drawer(
      width: 230,
      child: Column(
        children: [
          SizedBox(
            child: Container(
              alignment: Alignment.centerLeft,
              height: 85,
              color: Colors.black,
              padding: EdgeInsets.zero,
              child: DrawerHeader(
                margin: const EdgeInsets.all(0.0),
                padding: const EdgeInsets.only(
                  left: 18,
                  top: 10,
                  bottom: 10,
                ),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide.none,
                  ),
                ),
                child: Image.asset('assets/images/musicplayer white.png'),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(0),
              children: [
                ListTile(
                  tileColor: index == "login" ? Colors.white24 : null,
                  leading: const Icon(Icons.person),
                  title: const Text('Login or Register'),
                  onTap: () => null,
                ),

                // OFFLINE
                const Divider(),
                const ListTile(
                  leading: Icon(Icons.offline_bolt),
                  title: Text('Offline Musics'),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 60,
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        tileColor:
                            index == "offlinePlayList" ? Colors.white24 : null,
                        leading: const Icon(Icons.playlist_play),
                        title: const Text('PlayList'),
                        onTap: () {
                          Navigator.pushNamed(context, "/offlinePlayList");
                        },
                      ),
                      ListTile(
                        tileColor:
                            index == "offlineGenres" ? Colors.white24 : null,
                        leading: const Icon(Icons.music_note_rounded),
                        title: const Text('Genres'),
                        onTap: () {
                          Navigator.pushNamed(context, "/offlineGenres");
                        },
                      ),
                      ListTile(
                        tileColor:
                            index == "offlineDjs" ? Colors.white24 : null,
                        leading: const Icon(Icons.headphones),
                        title: const Text('Djs'),
                        onTap: () {
                          Navigator.pushNamed(context, "/offlineDjs");
                        },
                      ),
                      ListTile(
                        tileColor:
                            index == "offlineAlbums" ? Colors.white24 : null,
                        leading: const Icon(Icons.album_rounded),
                        title: const Text('Albums'),
                        onTap: () {
                          Navigator.pushNamed(context, "/offlineAlbums");
                        },
                      ),
                    ],
                  ),
                ),
                const Divider(),

                // ONLINE
                const ListTile(
                  leading: Icon(Icons.online_prediction),
                  title: Text('Online Musics'),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 60,
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        tileColor:
                            index == "onlinePlayList" ? Colors.white24 : null,
                        leading: const Icon(Icons.playlist_play),
                        title: const Text('PlayList'),
                        onTap: () => null,
                      ),
                      ListTile(
                        tileColor:
                            index == "onlineGenres" ? Colors.white24 : null,
                        leading: const Icon(Icons.music_note_rounded),
                        title: const Text('Genres'),
                        onTap: () => null,
                      ),
                      ListTile(
                        tileColor: index == "onlineDjs" ? Colors.white24 : null,
                        leading: const Icon(Icons.headphones),
                        title: const Text('Djs'),
                        onTap: () => null,
                      ),
                      ListTile(
                        tileColor:
                            index == "onlineAlbums" ? Colors.white24 : null,
                        leading: const Icon(Icons.album_rounded),
                        title: const Text('Albums'),
                        onTap: () => null,
                      ),
                    ],
                  ),
                ),
                const Divider(),
                ListTile(
                  tileColor: index == 8 ? Colors.white24 : null,
                  title: const Text('About'),
                  leading: const Icon(Icons.info_outline_rounded),
                  onTap: () => null,
                ),
                ListTile(
                  title: const Text('FAQ'),
                  leading: const Icon(Icons.question_mark_outlined),
                  onTap: () => null,
                ),
                ListTile(
                  title: const Text('SHARE'),
                  leading: const Icon(Icons.share),
                  onTap: () => null,
                ),
                const Divider(),
                SizedBox(
                  height: deviceHeight / 9,
                ),
                Container(
                  alignment: Alignment.bottomLeft,
                  child: Column(
                    children: const [
                      Text(
                        '© 2022 Dev Femi Badmus',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
