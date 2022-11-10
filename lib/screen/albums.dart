import 'package:musicplayer/modules/music.dart';
import 'package:musicplayer/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:musicplayer/widgets/appbar.dart';

class Albums extends StatefulWidget {
  const Albums({
    super.key,
    required this.mode,
  });
  final mode;

  @override
  State<Albums> createState() => AlbumsState();
}

class AlbumsState extends State<Albums> {
  List albums = [];
  @override
  void initState() {
    refresh();
    super.initState();
  }

  void refresh() {
    getOfflineAudioAlbums().then(
      (value) {
        setState(() {
          albums = value;
        });
      },
    );
  }

  final GlobalKey<AlbumsState> _refreshIndicatorKey = GlobalKey<AlbumsState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarPage(
        name: "${widget.mode} Albums",
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        color: Colors.grey,
        backgroundColor: Colors.black,
        strokeWidth: 2.5,
        onRefresh: () async {
          return refresh();
        },
        child: GridView.builder(
          padding: const EdgeInsets.all(10),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20),
          itemCount: albums.length,
          itemBuilder: (BuildContext ctx, index) {
            return Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white12,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(albums[index]),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "20",
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      drawer: const EphoDrawer(page: "offlineAlbums"),
    );
  }
}
