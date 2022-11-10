import 'package:flutter/material.dart';

class AppBarPage extends StatefulWidget implements PreferredSizeWidget {
  const AppBarPage({super.key, required this.name})
      : preferredSize = const Size.fromHeight(55.0);

  @override
  final Size preferredSize;
  final name;
  @override
  State<AppBarPage> createState() => _AppBarPageState();
}

class _AppBarPageState extends State<AppBarPage> {
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return deviceWidth <= 600 ? _phone() : _tablet(deviceWidth);
  }

  Widget _phone() {
    return Stack(
      alignment: Alignment.center,
      children: [
        AppBar(),
        Positioned(
          left: 0,
          bottom: 0,
          height: 55,
          child: _smallscreenleading(),
        ),
        Positioned(
          right: 0,
          bottom: 0,
          height: 55,
          child: _phonetrailing(),
        ),
      ],
    );
  }

  Widget _tablet(deviceWidth) {
    return Stack(
      alignment: Alignment.center,
      children: [
        AppBar(),
        Positioned(
          left: deviceWidth - 492,
          bottom: 0,
          height: 55,
          child: const Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
        ),
        Positioned(
          right: 0,
          bottom: 0,
          height: 55,
          child: _bigleading(),
        ),
      ],
    );
  }

// Leading and Trailing
  Widget _smallscreenleading() {
    return Row(
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: SizedBox(
            width: 30,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: Text(
            widget.name ?? "PlayList",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _phonetrailing() {
    return Row(
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: Icon(
            Icons.search,
            color: Colors.white,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: Icon(
            widget.name == "Offline PlayList" ? Icons.playlist_add : null,
          ),
        ),
      ],
    );
  }

  Widget _bigleading() {
    return const Padding(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: SizedBox(
        width: 480,
        child: TextField(
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 1.5,
                color: Color.fromARGB(255, 106, 106, 106),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 2,
                color: Colors.white24,
              ),
            ),
            contentPadding: EdgeInsets.only(left: 40),
            hintText: 'Search by artist, album, dj, song',
          ),
        ),
      ),
    );
  }
}
