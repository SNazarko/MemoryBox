import 'package:firebase_auth/firebase_auth.dart';
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

import '../../models/collections_model.dart';
import '../../repositories/collections_repositories.dart';
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
                    : _ListPlayers(),
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
      popupMenu: DoneDelete()
      // DeleteAudio(idAudio: '${audio.id}',),
      );

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        SizedBox(
          height: screenHeight * 0.95,
          child: StreamBuilder<List<AudioModel>>(
            stream: repositories.readAudioDelete('all'),
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
  ModelDelete({Key? key}) : super(key: key);
  final CollectionsRepositories repositories = CollectionsRepositories();

  Widget buildCollections(CollectionsModel collections) => _DeleteCollections(
        dataTime: collections.titleCollections!,
      );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 90.0),
      child: StreamBuilder<List<CollectionsModel>>(
        stream: repositories.readCollectionsDelete(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Ошыбка${snapshot.hasError}');
          }
          if (snapshot.hasData) {
            final collections = snapshot.data!;
            return ListView(
              padding: const EdgeInsets.only(top: 127, bottom: 110),
              children: collections.map(buildCollections).toList(),
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

class _DeleteCollections extends StatelessWidget {
  const _DeleteCollections({Key? key, required this.dataTime})
      : super(key: key);
  final String dataTime;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: Column(
        children: [
          Text(dataTime),
          Container(
            height: 100,
            color: Colors.grey,
          )
        ],
      ),
    );
  }
}

class DeleteAudio extends StatelessWidget {
  const DeleteAudio({Key? key, required this.idAudio}) : super(key: key);
  final String idAudio;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: GestureDetector(
          onTap: () {
            CollectionsRepositories()
                .deleteCollection(idAudio, 'DeleteCollections');
          },
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

class DoneDelete extends StatefulWidget {
  const DoneDelete({
    Key? key,
    // required this.id,
    // required this.done,
    // required this.collection,
  }) : super(key: key);
  // final String? id;
  // final List collection;
  // final bool? done;

  @override
  State<DoneDelete> createState() => _DoneDeleteState();
}

class _DoneDeleteState extends State<DoneDelete> {
  bool done = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Stack(
        children: [
          GestureDetector(
            onTap: () async {
              done = !done;
              if (!done) {
                setState(() {});
              }
              if (done) {
                setState(() {});
              }
            },
            child: Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                border: Border.all(color: AppColor.colorText),
                borderRadius: const BorderRadius.all(
                  Radius.circular(25.0),
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.done,
                  color: done ? AppColor.colorText : AppColor.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
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
