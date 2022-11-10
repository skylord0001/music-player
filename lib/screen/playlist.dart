import 'package:musicplayer/modules/music.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:musicplayer/widgets/appbar.dart';
import 'package:musicplayer/widgets/bottom.dart';
import 'package:musicplayer/widgets/drawer.dart';
import 'package:flutter/material.dart';

class PlayList extends StatefulWidget {
  const PlayList({
    super.key,
    required this.mode,
    this.playing,
  });
  final mode;
  final playing;

  @override
  State<PlayList> createState() => PlayListState();
}

class PlayListState extends State<PlayList> {
  var a;
  List musicList = [];
  int nextPlay = 0;
  bool isPlaying = false;

  @override
  void initState() {
    refresh();
    super.initState();
  }

  Future<void> refresh() async {
    if (widget.mode == "Offline") {
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
            print(musicList);
          });
        },
      );
    }
    await Future.delayed(const Duration(seconds: 2));
  }

  final GlobalKey<PlayListState> _refreshIndicatorKey =
      GlobalKey<PlayListState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarPage(
        name: "${widget.mode} PlayList",
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        color: Colors.grey,
        backgroundColor: Colors.black,
        strokeWidth: 2.5,
        onRefresh: () async {
          return refresh();
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(6, 25, 6, 105),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _recentlyAdded(musicList),
              _recentlyAdded(musicList),
            ],
          ),
        ),
      ),
      drawer: const EphoDrawer(page: "offlinePlayList"),
      bottomSheet: const BottomPlayer(),
    );
  }

  void playMusic(music) {
    setState(() {
      isPlaying = true;
    });
    platform.invokeMethod('playMusic', {'audioUrl': music.data});
  }

  Widget _recentlyAdded(musicList) {
    var musicLis = musicList.reversed;
    var musics = musicLis.toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Recently Added',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 20, 10, 40),
          child: songs(musics),
        ),
      ],
    );
  }

  Widget songs(music) {
    final dw = MediaQuery.of(context).size.width;
    return Container(
      height: dw / 2,
      width: dw,
      constraints: const BoxConstraints(
        minWidth: 300,
      ),
      child: CarouselSlider.builder(
        options: CarouselOptions(
          enableInfiniteScroll: false,
          aspectRatio: 2.0,
          enlargeCenterPage: false,
          autoPlayCurve: Curves.linear,
          disableCenter: true,
          padEnds: false,
          viewportFraction: 0.989,
        ),
        itemCount: (music.length / 2).round(),
        itemBuilder: (context, index, realIdx) {
          final int first = index * 2;
          final int second = first + 1;
          return Row(
            children: [
              first,
              if (music.length - first != 1) second,
            ].map(
              (idx) {
                return Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    width: dw / 2.5,
                    height: dw,
                    margin: const EdgeInsets.only(
                      left: 0,
                      right: 20,
                    ),
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          spreadRadius: 2,
                          blurRadius: 2,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 0,
                        ),
                        GestureDetector(
                          onTap: () {
                            playMusic(music[idx]);
                          },
                          child: Container(
                            height: dw / 2.5,
                            width: dw / 2,
                            color: widget.playing == music[idx].id
                                ? null
                                : Colors.white24,
                            decoration: widget.playing == music[idx].id
                                ? const BoxDecoration(
                                    image: DecorationImage(
                                      image:
                                          AssetImage("assets/images/music.jpg"),
                                    ),
                                  )
                                : null,
                            child: Icon(
                              widget.playing == music[idx].id
                                  ? null
                                  : Icons.play_arrow,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 38,
                          width: dw / 2,
                          child: Container(
                            decoration: const BoxDecoration(
                                border: Border(
                              top: BorderSide(
                                width: 2,
                                color: Colors.white38,
                              ),
                            )),
                            child: Container(
                              color: Colors.black,
                              padding: const EdgeInsets.all(5),
                              alignment: Alignment.center,
                              child: Text(
                                music[idx].title,
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ).toList(),
          );
        },
      ),
    );
  }
}
