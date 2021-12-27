import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:memory_box/bloc_all/bloc_all_bloc.dart';
import 'package:memory_box/screens/screens_element/appbar_clipper.dart';
import 'package:memory_box/screens/screens_element/bottom_nav_bar.dart';
import 'package:memory_box/screens/screens_element/player_mini.dart';

import '../constants.dart';

class AudioRecordingsPage extends StatelessWidget {
  const AudioRecordingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Stack(
            children: [
              _ListPlayers(),
              _AppbarHeader(),
            ],
          ),
          BottomNavBar(),
        ],
      ),
    );
  }
}

class _AppbarHeader extends StatelessWidget {
  const _AppbarHeader({Key? key}) : super(key: key);
  final int qualityAudio = 20;
  final String time = '10:30';

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(),
        ClipPath(
          clipper: AppbarClipper(),
          child: Container(
            color: kColorAppbar,
            width: double.infinity,
            height: 210,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 25, left: 10, right: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                iconSize: 30,
                color: Colors.white,
                onPressed: () {},
                icon: const Icon(
                  Icons.menu,
                ),
              ),
              const Text(
                'Аудиозаписи',
                style: kTitleTextStyle2,
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.more_horiz),
                color: Colors.white,
                iconSize: 30,
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 70,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'Все в одном месте',
                style: kTitle2TextStyle2,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 105,
            left: 10,
            right: 10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$qualityAudio аудио',
                    style: kTitle2TextStyle2,
                  ),
                  Text(
                    '$time часов',
                    style: kTitle2TextStyle2,
                  ),
                ],
              ),
              _AppbarPlayer(),
            ],
          ),
        )
      ],
    );
  }
}

class _AppbarPlayer extends StatelessWidget {
  const _AppbarPlayer({Key? key, this.playAll, this.repeat}) : super(key: key);
  final playAll;
  final repeat;
  @override
  Widget build(BuildContext context) {
    final PlayAllRepeatBloc playAllRepeat = context.read<PlayAllRepeatBloc>();
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            playAllRepeat.add(
              RepeatEvent(),
            );
          },
          child: BlocBuilder<PlayAllRepeatBloc, Color>(
            builder: (context, state) {
              return Container(
                height: 46,
                width: 200,
                decoration: BoxDecoration(
                    color: state,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(50),
                    )),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      width: 40,
                      height: 40,
                      child: Image.asset(
                        'images/vector.png',
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        GestureDetector(
          onTap: () {
            playAllRepeat.add(
              PlayAllEvent(),
            );
          },
          child: Container(
            child: Padding(
              padding: EdgeInsets.only(right: 1, top: 1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    child: Image.asset(
                      'images/play_aud.png',
                    ),
                  ),
                  const Text(
                    'Запустить все',
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF8C84E2),
                    ),
                  ),
                ],
              ),
            ),
            height: 46,
            width: 150,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(50),
                )),
          ),
        ),
      ],
    );
  }
}

class _ListPlayers extends StatelessWidget {
  const _ListPlayers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: screenHeight * 0.905,
      child: Flexible(
        flex: 1,
        child: Container(
          child: ListView(
            children: [
              SizedBox(
                height: screenHeight * 0.28,
              ),
              PlayerMini(),
              PlayerMini(),
              PlayerMini(),
              PlayerMini(),
              PlayerMini(),
              PlayerMini(),
              PlayerMini(),
              PlayerMini(),
              PlayerMini(),
            ],
          ),
        ),
      ),
    );
  }
}
