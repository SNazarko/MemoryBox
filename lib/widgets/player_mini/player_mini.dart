import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/resources/app_colors.dart';
import 'package:just_audio/just_audio.dart' as ap;
import 'package:memory_box/resources/app_icons.dart';

class PlayerMini extends StatefulWidget {
  const PlayerMini({
    Key? key,
    required this.url,
    required this.name,
    required this.duration,
    required this.popupMenu,
    required this.done,
    required this.id,
    required this.collection,
  }) : super(key: key);
  final String url;
  final String name;
  final String duration;
  final Widget popupMenu;
  final bool done;
  final String id;
  final List collection;

  @override
  State<PlayerMini> createState() => _PlayerMiniState();
}

class _PlayerMiniState extends State<PlayerMini> {
  late StreamSubscription<ap.PlayerState> _playerStateChangedSubscription;
  final player = ap.AudioPlayer();
  @override
  void initState() {
    _playerStateChangedSubscription =
        player.playerStateStream.listen((state) async {
      if (state.processingState == ap.ProcessingState.completed) {
        await stop();
      }
      setState(() {});
    });
    _init();
    super.initState();
  }

  @override
  void dispose() {
    _playerStateChangedSubscription.cancel();
    player.dispose();
    super.dispose();
  }

  void _init() async {
    await player.setUrl(widget.url);
  }

  Future<void> play() {
    return player.play();
  }

  Future<void> pause() {
    return player.pause();
  }

  Future<void> nextN() {
    return player.seekToNext();
  }

  Future<void> stop() async {
    await player.stop();
    return player.seek(const Duration(milliseconds: 0));
  }

  Widget _buildControl() {
    Widget icon;

    if (player.playerState.playing) {
      icon = Padding(
        padding: const EdgeInsets.all(5.0),
        child: Image.asset(
          AppIcons.stop,
          fit: BoxFit.fill,
        ),
      );
    } else {
      icon = Image.asset(
        'assets/images/4x/play_aud.png',
        fit: BoxFit.fill,
      );
    }

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: ClipOval(
        child: Material(
          child: InkWell(
            child: SizedBox(width: 55, height: 55, child: icon),
            onTap: () {
              if (player.playerState.playing) {
                pause();
                setState(() {});
              } else {
                setState(() {});
                play();
              }
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20.0,
        right: 10.0,
        bottom: 10.0,
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(50.0),
          ),
        ),
        height: 65.0,
        width: double.infinity,
        child: Row(
          children: [
            _buildControl(),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    maxLines: 1,
                    overflow: TextOverflow.fade,
                    softWrap: true,
                    style: const TextStyle(
                      fontSize: 14.0,
                    ),
                  ),
                  Text(
                    '${widget.duration} минут',
                    style: const TextStyle(
                      color: AppColor.colorText50,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SizedBox(
                child: IconButton(
                    onPressed: () {
                      nextN();
                    },
                    icon: Icon(Icons.abc)),
              ),
            ),
            widget.popupMenu
          ],
        ),
      ),
    );
  }
}
