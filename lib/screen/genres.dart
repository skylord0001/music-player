import 'package:musicplayer/modules/music.dart';
import 'package:musicplayer/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:musicplayer/widgets/appbar.dart';

class Genres extends StatefulWidget {
  const Genres({
    super.key,
    required this.mode,
  });
  final mode;

  @override
  State<Genres> createState() => GenresState();
}

class GenresState extends State<Genres> {
  List musicList = [];
  @override
  void initState() {
    refresh();
    super.initState();
  }

  Future<void> refresh() async {
    if (widget.mode == "offline") {
      getOfflineMusics().then(
        (value) {
          setState(() {
            musicList = value.reversed.toList();
          });
        },
      );
    } else {
      getOnlineMusics().then(
        (value) {
          setState(() {
            musicList = value.reversed.toList();
          });
        },
      );
    }
    await Future.delayed(const Duration(seconds: 2));
  }

  final GlobalKey<GenresState> _refreshIndicatorKey = GlobalKey<GenresState>();

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
        // Pull from top to show refresh indicator.
        child: ListView.builder(
            itemCount: musicList.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: const CircleAvatar(
                  backgroundImage: AssetImage("assets/images/music.jpg"),
                ),
                title: Text(
                  musicList[index].title,
                  style: const TextStyle(
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                trailing: const Icon(
                  (Icons.more_vert),
                  color: Colors.grey,
                ),
              );
            }),
      ),
      drawer: const EphoDrawer(page: "offlineGenres"),
    );
  }
}
