import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/resources/app_colors.dart';
import 'package:just_audio/just_audio.dart' as ap;

class PlayerMini extends StatefulWidget {
  const PlayerMini({Key? key, required this.url, required this.name})
      : super(key: key);
  final url;
  final name;
  @override
  State<PlayerMini> createState() => _PlayerMiniState();
}

class _PlayerMiniState extends State<PlayerMini> {
  final player = ap.AudioPlayer();
  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  void dispose() {
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

  Future<void> stop() async {
    await player.stop();
    return player.seek(const Duration(milliseconds: 0));
  }

  Widget _buildControl() {
    Icon icon;
    Color color;

    if (player.playerState.playing) {
      icon = Icon(Icons.pause, color: Colors.red, size: 70);
      color = Colors.red.withOpacity(0.1);
    } else {
      final theme = Theme.of(context);
      icon = Icon(Icons.play_arrow, color: theme.primaryColor, size: 70);
      color = theme.primaryColor.withOpacity(0.1);
    }

    return ClipOval(
      child: Material(
        color: color,
        child: InkWell(
          child: SizedBox(width: 80, height: 80, child: icon),
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
        height: 75.0,
        width: double.infinity,
        child: Row(
          children: [
            _buildControl(),
            // Container(
            //   width: 70.0,
            //   height: 70.0,
            //   child: Image.asset(
            //     'assets/images/4x/play_aud.png',
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    style: const TextStyle(
                      fontSize: 14.0,
                    ),
                  ),
                  const Text(
                    '30 минут',
                    style: TextStyle(
                      color: AppColor.colorText,
                    ),
                  ),
                ],
              ),
            ),
            const Expanded(
              child: SizedBox(),
            ),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.more_horiz,
                  size: 30.0,
                ))
          ],
        ),
      ),
    );
  }
}
