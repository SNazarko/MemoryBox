import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:memory_box/models/audio_model.dart';
import 'package:memory_box/pages/podborki_page/podborki_edit/podborki_edit_model.dart';
import 'package:memory_box/repositories/audio_repositories.dart';
import 'package:memory_box/repositories/user_repositories.dart';
import 'package:memory_box/resources/app_colors.dart';
import 'package:memory_box/resources/app_icons.dart';
import 'package:memory_box/resources/constants.dart';
import 'package:memory_box/widgets/appbar_clipper.dart';
import 'package:memory_box/widgets/bottom_nav_bar.dart';
import 'package:memory_box/widgets/container_shadow.dart';
import 'package:memory_box/widgets/done_widget/done_widget.dart';
import 'package:memory_box/widgets/icon_back.dart';
import 'package:memory_box/widgets/icon_camera.dart';
import 'package:memory_box/widgets/image_pick.dart';
import 'package:memory_box/widgets/player_mini.dart';
import 'package:memory_box/widgets/player_mini_podborki.dart';

import 'audio_recordings_page.dart';

class Test extends StatelessWidget {
  const Test({Key? key}) : super(key: key);
  static const rootName = '/test';

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      bottomNavigationBar: const BottomNavBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                const _AppbarHeaderProfileEdit(),
                _FotoContainer(),
              ],
            ),
            SubTitle(),
            ListPodborok(
              screenHeight: screenHeight / 2.4,
            ),
          ],
        ),
      ),
    );
  }
}

class SubTitle extends StatefulWidget {
  SubTitle({Key? key}) : super(key: key);

  @override
  State<SubTitle> createState() => _SubTitleState();
}

class _SubTitleState extends State<SubTitle> {
  bool allText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 15.0,
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 28.0,
          ),
          child: Text(
              'Сказка о маленьком принце. Он родился в старой деревне и задавался всего-лишь '
              'одним вопросом - “Кто я такой?”. Он познакомился со старенькой бабушкой, '
              'которая рассказала ему легенду о малыше Кокки...',
              style: kBodi2TextStyle,
              maxLines: allText ? 4 : 100,
              overflow: TextOverflow.ellipsis),
        ),
        Align(
          alignment: Alignment.center,
          child: GestureDetector(
            onTap: () {
              allText = !allText;
              setState(() {});
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                allText ? 'Подробнее' : 'Скрить...',
                style: const TextStyle(
                    color: AppColor.colorText50, fontSize: 13.0),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class _FotoContainer extends StatelessWidget {
  _FotoContainer({Key? key}) : super(key: key);
  String? singleImage;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(
        left: 15.0,
        top: 130.0,
        right: 15.0,
      ),
      child: ContainerShadow(
        image: Image.network(
          'https://firebasestorage.googleapis.com/v0/b/memory-box-6cb96.appspot.com/o/userAudio%2Faudio1821989074040555513.m4a?alt=media&token=391d314b-7a2b-49cb-8bf6-09d28c7fe067',
          fit: BoxFit.fitWidth,
        ),
        width: screenWidth * 0.955,
        height: 200.0,
        widget: const Text(''),
        radius: 20.0,
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
            height: 280.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 30.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconBack(
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.more_horiz,
                    size: 30.0,
                    color: AppColor.white,
                  ))
            ],
          ),
        ),
        const Padding(
            padding: EdgeInsets.only(
              top: 90.0,
              left: 15.0,
              right: 15.0,
            ),
            child: Text(
              'Сказка о малыше Коки',
              style: TextStyle(
                fontSize: 24.0,
                color: AppColor.white100,
                fontWeight: FontWeight.w700,
              ),
            )),
      ],
    );
  }
}

class ListPodborok extends StatelessWidget {
  ListPodborok({Key? key, required this.screenHeight}) : super(key: key);
  AudioRepositories repositories = AudioRepositories();
  final double screenHeight;

  Widget buildAudio(AudioModel audio) => PlayerMini(
        duration: '${audio.duration}',
        url: '${audio.audioUrl}',
        name: '${audio.audioName}',
      );
  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight * 0.78,
      child: StreamBuilder<List<AudioModel>>(
        stream: repositories.readAudio(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Ошибка');
          }
          if (snapshot.hasData) {
            final audio = snapshot.data!;
            return ListView(
              padding: const EdgeInsets.all(0.0),
              children: audio.map(buildAudio).toList(),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
