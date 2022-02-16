import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/pages/podborki_page/podborki_item/podborki_item_page_model.dart';
import 'package:memory_box/resources/app_icons.dart';
import 'package:memory_box/resources/constants.dart';
import 'package:provider/provider.dart';

class ButtonPlayPause extends StatefulWidget {
  const ButtonPlayPause({
    Key? key,
  }) : super(key: key);

  @override
  State<ButtonPlayPause> createState() => _ButtonPlayPauseState();
}

class _ButtonPlayPauseState extends State<ButtonPlayPause>
    with TickerProviderStateMixin {
  bool playPause = true;
  late AnimationController controller;
  // late Animation animation;

  void anim() {
    controller =
        AnimationController(duration: Duration(seconds: 1), vsync: this);
    controller.forward();
    controller.addListener(() {
      print(controller.value);
      // setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        anim();
        playPause = !playPause;
        context.read<PodborkiItemPageModel>().setPlayPause(!playPause);
        context.read<PodborkiItemPageModel>().setAnim(controller.value);
        setState(() {});
      },
      child: SizedBox(
        width: 168.0,
        height: 48.0,
        child: Stack(
          children: [
            Opacity(
              opacity: 0.75,
              child: Container(
                width: 168.0,
                height: 48.0,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(25),
                  ),
                  color: Colors.grey,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                children: [
                  Image.asset(
                    playPause ? AppIcons.play_white : AppIcons.pause_white,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      playPause ? 'Запустить все' : 'Остановить',
                      style: kTitle2TextStyle,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
