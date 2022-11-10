import 'dart:async';
import 'package:musicplayer/screen/playlist.dart';
import 'package:flutter/material.dart';

class BottomPlayer extends StatefulWidget {
  const BottomPlayer({super.key});

  @override
  State<BottomPlayer> createState() => BottomPlayerState();
}

class BottomPlayerState extends State<BottomPlayer> {
  // CONNECTING VARIABLES
  static var isps = false;
  static var ispl = false;
  static var mscl;

  // HERE VARIABLES
  var music;
  var isPaused;
  var isPlaying;
  var player;
  @override
  void initState() {
    Timer.periodic(const Duration(seconds: 0), (t) {
      updateplayer();
    });
    super.initState();
  }

  void updateplayer() {
    setState(() {
      music = mscl;
      isPaused = isps;
      isPlaying = ispl;
    });
  }

  void playMusic() async {
    setState(() {
      isps = false;
    });
    if (isPaused) {
    } else {
      await player.setFilePath(music.data);
    }
    await player.play();
  }

  void pauseMusic() async {
    setState(() {
      isps = true;
    });
    await player.pause();
    print("Paused");
  }

  void stopMusic() async {
    await player.stop();
  }

  void nextMusic() async {
    await player.seekToNext();
  }

  void previousMusic() async {
    await player.seekToPrevious();
  }

  void shuffleMusic() async {
    await player.setShuffleModeEnabled(true);
  }

  void seekMusic(line) async {
    await player.seek(Duration(seconds: line), index: 2);
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    if (music != null) {
      return Container(
        color: Colors.black,
        child: SizedBox(
          height: 50,
          width: deviceWidth,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/music.jpg"),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  child: Text(
                    music.title,
                    style: const TextStyle(
                        fontSize: 12, overflow: TextOverflow.fade),
                  ),
                ),
              ),
              Expanded(
                child: CircleAvatar(
                  child: IconButton(
                    icon: Icon(
                      isPaused ? Icons.play_arrow : Icons.pause,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      isPaused ? playMusic() : pauseMusic();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return const SizedBox();
    }
  }
}
