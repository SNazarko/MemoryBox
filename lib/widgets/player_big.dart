import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/resources/app_colors.dart';

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
  final String timerStart = '00:00';
  final String timerEnd = '30:00';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            // thumbShape: const RoundedAmebaThumbShape(radius: 10),
            thumbColor: const Color(ColorApp.colorText),
            activeTickMarkColor: const Color(ColorApp.colorText),
            inactiveTrackColor: const Color(ColorApp.colorText),
            inactiveTickMarkColor: const Color(ColorApp.colorText),
          ),
          child: Slider(
            value: 0.0,
            min: 0.0,
            max: 2000.0,
            onChanged: (double value) {},
            //divisions: 100
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(timerStart),
              Text(timerEnd),
            ],
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
              iconSize: 100.0,
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
