import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlayerBig extends StatelessWidget {
  PlayerBig(
      {Key? key,
      this.playStopFunction,
      this.playStopIcon,
      this.replayFunction,
      this.forwardFunction})
      : super(key: key);
  final playStopFunction;
  final playStopIcon;
  final replayFunction;
  final forwardFunction;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 7),
              thumbColor: const Color(0xFF3A3A55),
              activeTickMarkColor: const Color(0xFF3A3A55),
              inactiveTrackColor: const Color(0xFF3A3A55),
              inactiveTickMarkColor: const Color(0xFF3A3A55)),
          child: Slider(
            value: 0,
            min: 0.0,
            max: 2000.0,
            onChanged: (double value) {},
            //divisions: 100
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: replayFunction,
              icon: const Icon(
                Icons.replay_10,
              ),
            ),
            IconButton(
              iconSize: 100,
              onPressed: playStopFunction,
              icon: playStopIcon,
            ),
            IconButton(
                onPressed: forwardFunction, icon: const Icon(Icons.forward_10)),
          ],
        ),
      ],
    );
  }
}
