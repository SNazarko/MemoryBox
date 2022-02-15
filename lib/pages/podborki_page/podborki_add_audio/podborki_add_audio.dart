import 'package:flutter/material.dart';
import 'package:memory_box/models/audio_model.dart';
import 'package:memory_box/pages/podborki_page/podborki_add_audio/podborki_add_audio_model.dart';
import 'package:memory_box/repositories/audio_repositories.dart';
import 'package:memory_box/resources/app_colors.dart';
import 'package:memory_box/resources/app_icons.dart';
import 'package:memory_box/resources/constants.dart';
import 'package:memory_box/widgets/appbar_clipper.dart';
import 'package:memory_box/widgets/bottom_nav_bar.dart';
import 'package:memory_box/widgets/done_widget/done_widget.dart';
import 'package:memory_box/widgets/icon_back.dart';
import 'package:memory_box/widgets/player_mini.dart';
import 'package:memory_box/widgets/player_mini_podborki.dart';
import 'package:provider/provider.dart';

class PodborkiAddAudio extends StatelessWidget {
  const PodborkiAddAudio({Key? key}) : super(key: key);
  static const rootName = '/podborki_add_audio';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomNavBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                _ListPlayers(),
                const _AppbarHeaderProfileEdit(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _AppbarHeaderProfileEdit extends StatelessWidget {
  const _AppbarHeaderProfileEdit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(),
        ClipPath(
          clipper: AppbarClipper(),
          child: Container(
            color: AppColor.colorAppbar2,
            width: double.infinity,
            height: 220.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15, top: 15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconBack(
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: Text(
                  'Вибрать',
                  style: kTitleTextStyle2,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: Text(
                    'Добавить',
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                        color: AppColor.white100),
                  ),
                ),
              ),
            ],
          ),
        ),
        SearchPanel(),
      ],
    );
  }
}

class SearchPanel extends StatelessWidget {
  const SearchPanel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, top: 121.0, right: 12.0),
      child: Expanded(
        child: Container(
          height: 60,
          decoration: const BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 29),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    width: screenWidth * 0.65,
                    child: TextField(
                      onChanged: (_searchtxt) {
                        context
                            .read<PodborkiAddAudioModel>()
                            .setSearchtxt(_searchtxt);
                      },
                      style: const TextStyle(
                        fontSize: 20.0,
                        color: AppColor.colorText,
                      ),
                      decoration: const InputDecoration(
                        hintText: 'Поиск',
                        hintStyle: TextStyle(
                          fontSize: 20.0,
                          color: AppColor.colorText50,
                        ),
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                      ),
                    )),
                GestureDetector(
                  onTap: () {},
                  child: Image.asset(
                    AppIcons.search,
                    color: AppColor.colorText,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ListPlayers extends StatelessWidget {
  _ListPlayers({Key? key}) : super(key: key);
  final AudioRepositories repositories = AudioRepositories();
  Widget buildAudio(AudioModel audio) => PlayerMiniPodborki(
        duration: '${audio.duration}',
        url: '${audio.audioUrl}',
        name: '${audio.audioName}',
        done: audio.done ?? false,
      );

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Container(
          height: screenHeight * 0.95,
          child: StreamBuilder<List<AudioModel>>(
            stream: repositories.readAudio(),
            builder: (
              context,
              snapshot,
            ) {
              if (snapshot.hasError) {
                return const Text('Ошибка');
              }
              if (snapshot.hasData) {
                final audio = snapshot.data!;
                return ListView(
                  padding: const EdgeInsets.only(top: 230, bottom: 40),
                  children: audio.map(buildAudio).toList(),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
