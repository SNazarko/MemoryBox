import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/models/audio_model.dart';
import 'package:memory_box/repositories/audio_repositories.dart';
import 'package:memory_box/resources/app_colors.dart';
import 'package:memory_box/resources/app_icons.dart';
import 'package:memory_box/resources/constants.dart';
import 'package:memory_box/widgets/appbar_clipper.dart';
import 'package:memory_box/widgets/player_mini/player_mini.dart';
import 'package:memory_box/widgets/popup_menu_button.dart';

import '../authorization_page/registration_page/registration_page.dart';

class _DeletePageArguments {
  _DeletePageArguments({this.auth, this.user}) {
    init();
  }
  FirebaseAuth? auth;
  User? user;

  void init() {
    auth = FirebaseAuth.instance;
    user = auth!.currentUser;
  }
}

class DeletePage extends StatelessWidget {
  DeletePage({Key? key}) : super(key: key);
  static const routeName = '/delete_page';
  final _DeletePageArguments arguments = _DeletePageArguments();
  static Widget create() {
    return DeletePage();
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
                arguments.user == null
                    ? const ModelDeleteNotIsAuthorization()
                    : const ModelDelete(),
                const _AppbarHeader(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ModelDeleteNotIsAuthorization extends StatelessWidget {
  const ModelDeleteNotIsAuthorization({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 200.0,
        ),
        Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 50.0,
              horizontal: 40.0,
            ),
            child: Column(
              children: [
                RichText(
                  text: TextSpan(
                      text: '     Для открытия полного \n '
                          '            функционала \n '
                          '   приложения вам нужно \n '
                          ' зарегистрироваться',
                      style: const TextStyle(
                        fontSize: 20.0,
                        color: AppColor.colorText50,
                      ),
                      children: [
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushNamed(
                                  context, RegistrationPage.routeName);
                            },
                          text: ' здесь',
                          style: const TextStyle(
                            fontSize: 20.0,
                            color: AppColor.pink,
                          ),
                        )
                      ]),
                )
              ],
            )),
      ],
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
        done: audio.done!,
        id: '${audio.id}',
        collection: audio.collections!,
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
            stream: repositories.readAudioSort('all'),
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

class ModelDelete extends StatelessWidget {
  const ModelDelete({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [Text('дата'), _ListPlayers()],
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
