import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/models/audio_model.dart';
import 'package:memory_box/repositories/audio_repositories.dart';
import 'package:memory_box/resources/app_colors.dart';
import 'package:memory_box/resources/app_icons.dart';
import 'package:memory_box/resources/constants.dart';
import 'package:memory_box/widgets/appbar_clipper.dart';
import 'package:memory_box/widgets/player_mini/player_mini.dart';
import 'package:memory_box/widgets/popup_menu_button.dart';

class DeletePage extends StatelessWidget {
  const DeletePage({Key? key}) : super(key: key);
  static const routeName = '/delete_page';
  static Widget create() {
    return const DeletePage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          icon: const Icon(Icons.menu),
        ),
        elevation: 0.0,
        title: const Text(
          'Недавно',
          style: kTitleTextStyle2,
        ),
        actions: const [PopupMenuDeletePage()],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(
              children: [
                _ListPlayers(),
                const _AppbarHeader(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _AppbarHeader extends StatelessWidget {
  const _AppbarHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(),
        ClipPath(
          clipper: AppbarClipper(),
          child: Container(
            color: AppColor.colorAppbar,
            width: double.infinity,
            height: 125.0,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'удаленные',
              style: kTitleTextStyle2,
            ),
          ],
        ),
      ],
    );
  }
}

class _ListPlayers extends StatelessWidget {
  _ListPlayers({Key? key}) : super(key: key);
  final AudioRepositories repositories = AudioRepositories();
  Widget buildAudio(AudioModel audio) => PlayerMini(
        duration: '${audio.duration}',
        url: '${audio.audioUrl}',
        name: '${audio.audioName}',
        popupMenu: const DeleteAudio(),
      );

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        SizedBox(
          height: screenHeight * 0.95,
          child: StreamBuilder<List<AudioModel>>(
            stream: repositories.readAudio(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text('Ошибка');
              }
              if (snapshot.hasData) {
                final audio = snapshot.data!;
                return ListView(
                  padding: const EdgeInsets.only(top: 127, bottom: 110),
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

class DeleteAudio extends StatelessWidget {
  const DeleteAudio({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: GestureDetector(
          onTap: () {},
          child: SizedBox(
            width: 25.0,
            height: 25.0,
            child: Image.asset(
              AppIcons.rec_delete,
              fit: BoxFit.fill,
            ),
          )),
    );
  }
}

class PopupMenuAudioRecordingPage extends StatelessWidget {
  const PopupMenuAudioRecordingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: const Icon(
        Icons.more_horiz,
      ),
      iconSize: 40,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      itemBuilder: (context) => [
        popupMenuItem(
          'Переименовать',
          () {},
        ),
        popupMenuItem(
          'Добавить в подборку',
          () {},
        ),
        popupMenuItem(
          'Удалить ',
          () {},
        ),
        popupMenuItem(
          'Поделиться',
          () {},
        ),
      ],
    );
  }
}

class PopupMenuDeletePage extends StatelessWidget {
  const PopupMenuDeletePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        icon: const Icon(
          Icons.more_horiz,
          color: AppColor.white,
        ),
        iconSize: 40,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        itemBuilder: (context) => [
              popupMenuItem(
                'Выбрать несколько',
                () {},
              ),
              popupMenuItem(
                'Удалить все',
                () {},
              ),
              popupMenuItem(
                'Восстановить все',
                () {},
              ),
            ]);
  }
}

//
// class ListPlayers extends StatelessWidget {
//   ListPlayers({Key? key}) : super(key: key);
//   final AudioRepositories repositories = AudioRepositories();
//   Widget buildAudio(AudioModel audio) => PlayerMini(
//     duration: '${audio.duration}',
//     url: '${audio.audioUrl}',
//     name: '${audio.audioName}',
//     popupMenu: const DeleteAudio(),
//   );
//
//   @override
//   Widget build(BuildContext context) {
//     final double screenHeight = MediaQuery.of(context).size.height;
//     return Column(
//       children: [
//         SizedBox(
//           height: screenHeight * 0.95,
//           child: StreamBuilder<List<AudioModel>>(
//             stream: repositories.readAudio(),
//             builder: (context, snapshot) {
//               if (snapshot.hasError) {
//                 return const Text('Ошибка');
//               }
//               if (snapshot.hasData) {
//                 final audio = snapshot.data!;
//                 return ListView(
//                   padding: const EdgeInsets.only(top: 127, bottom: 110),
//                   children: audio.map(buildAudio).toList(),
//                 );
//               } else {
//                 return const Center(
//                   child: CircularProgressIndicator(),
//                 );
//               }
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }
