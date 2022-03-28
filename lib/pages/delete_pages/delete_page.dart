import 'package:cloud_firestore/cloud_firestore.dart';
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
import 'package:provider/provider.dart';

import '../../models/collections_model.dart';
import '../../repositories/collections_repositories.dart';
import '../authorization_page/registration_page/registration_page.dart';
import 'delete_page_model.dart';

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
            height: 200.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 25.0, left: 12.0, right: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: const Icon(
                  Icons.menu,
                  color: AppColor.white,
                ),
              ),
              const Text(
                'Недавно',
                style: kTitleTextStyle2,
              ),
              _PopupMenuDeletePage()
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 70.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'удаленные',
                style: kTitleTextStyle2,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class DeletePage extends StatelessWidget {
  DeletePage({Key? key}) : super(key: key);
  static const routeName = '/delete_page';
  final _DeletePageArguments arguments = _DeletePageArguments();
  static Widget create() {
    return
        // ChangeNotifierProvider<DeletePageModel>(
        // create: (BuildContext context) => DeletePageModel(),
        // child:
        DeletePage();
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   // centerTitle: true,
      //   leading: Expanded(
      //     child: IconButton(
      //       onPressed: () {
      //         Scaffold.of(context).openDrawer();
      //       },
      //       icon: const Icon(Icons.menu),
      //     ),
      //   ),
      //   elevation: 0.0,
      //
      //   title: Expanded(
      //     child: const Text(
      //       'Недавно',
      //       style: kTitleTextStyle2,
      //     ),
      //   ),
      //   actions: const [Expanded(child: _PopupMenuDeletePage())],
      // ),
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

class _ListPlayers extends StatelessWidget {
  _ListPlayers({Key? key}) : super(key: key);
  final AudioRepositories repositories = AudioRepositories();

  Widget buildAudioDel(AudioModel audio) => PlayerMini(
        duration: '${audio.duration}',
        url: '${audio.audioUrl}',
        name: '${audio.audioName}',
        done: audio.done!,
        id: '${audio.id}',
        collection: audio.collections!,
        popupMenu: DeleteAudio(
          idAudio: '${audio.id}',
        ),
      );

  Widget buildAudioDone(AudioModel audio) => PlayerMini(
      duration: '${audio.duration}',
      url: '${audio.audioUrl}',
      name: '${audio.audioName}',
      done: audio.done!,
      id: '${audio.id}',
      collection: audio.collections!,
      popupMenu: DoneDelete(
        done: audio.done!,
        id: '${audio.id}',
      ));

  @override
  Widget build(BuildContext context) {
    final state = context.watch<DeletePageModel>().getItemDone;
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
                if (audio.isEmpty) {
                  return const Center(
                      child: Text(
                    'Вы еще ничего \n     не удалили',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: AppColor.colorText50,
                    ),
                  ));
                } else {
                  return ListView(
                      padding: const EdgeInsets.only(top: 210, bottom: 110),
                      children: state
                          ? audio.map(buildAudioDone).toList()
                          : audio.map(buildAudioDel).toList());
                }
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

class _PopupMenuDeletePage extends StatelessWidget {
  _PopupMenuDeletePage({Key? key}) : super(key: key);
  final CollectionsRepositories repositories = CollectionsRepositories();
  List<String> idAudioList = [];
  List<String> idAudioListAll = [];

  Future<void> getIdCollection(BuildContext context) async {
    await FirebaseFirestore.instance
        .collection(repositories.user!.phoneNumber!)
        .doc('id')
        .collection('DeleteCollections')
        .where('done', isEqualTo: true)
        .get()
        .then((querySnapshot) {
      for (var result in querySnapshot.docs) {
        final String idAudio = result.data()['id'];
        idAudioList.add(idAudio);
      }
    });
  }

  Future<void> getIdCollectionAll(BuildContext context) async {
    await FirebaseFirestore.instance
        .collection(repositories.user!.phoneNumber!)
        .doc('id')
        .collection('DeleteCollections')
        .get()
        .then((querySnapshot) {
      for (var result in querySnapshot.docs) {
        final String idAudioAll = result.data()['id'];
        idAudioListAll.add(idAudioAll);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<DeletePageModel>().getItemDone;
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
        itemBuilder: state
            ? (context) => [
                  popupMenuItem(
                    'Снять выделение',
                    () {
                      context.read<DeletePageModel>().stateCollections();
                    },
                  ),
                  popupMenuItem(
                    'Удалить',
                    () async {
                      await getIdCollection(context);
                      for (var item in idAudioList) {
                        await repositories.deleteCollection(
                            item, 'DeleteCollections');
                      }
                    },
                  ),
                  popupMenuItem(
                    'Восстановить',
                    () async {
                      await getIdCollection(context);
                      for (var item in idAudioList) {
                        await repositories.copyPastCollections(
                          item,
                          'DeleteCollections',
                          'Collections',
                        );
                        await repositories.deleteCollection(
                            item, 'DeleteCollections');
                      }
                    },
                  ),
                ]
            : (context) => [
                  popupMenuItem(
                    'Выбрать несколько',
                    () {
                      context.read<DeletePageModel>().stateCollections();
                    },
                  ),
                  popupMenuItem(
                    'Удалить все',
                    () async {
                      await getIdCollection(context);
                      for (var item in idAudioListAll) {
                        await repositories.deleteCollection(
                            item, 'DeleteCollections');
                      }
                    },
                  ),
                  popupMenuItem(
                    'Восстановить все',
                    () async {
                      await getIdCollectionAll(context);
                      for (var item in idAudioListAll) {
                        await repositories.copyPastCollections(
                          item,
                          'DeleteCollections',
                          'Collections',
                        );
                        await repositories.deleteCollection(
                            item, 'DeleteCollections');
                      }
                    },
                  ),
                ]);
  }
}

class DoneDelete extends StatefulWidget {
  const DoneDelete({
    Key? key,
    required this.id,
    required this.done,
    // required this.collection,
  }) : super(key: key);
  final String? id;
  // final List collection;
  final bool? done;

  @override
  State<DoneDelete> createState() => _DoneDeleteState();
}

class _DoneDeleteState extends State<DoneDelete> {
  final CollectionsRepositories repositories = CollectionsRepositories();
  bool done = false;
  String? idCollection;

  Future<void> getIdCollection(BuildContext context) async {
    await FirebaseFirestore.instance
        .collection(repositories.user!.phoneNumber!)
        .doc('id')
        .collection('CollectionsTale')
        .where('done', isEqualTo: true)
        .get()
        .then((querySnapshot) {
      for (var result in querySnapshot.docs) {
        idCollection = result.data()['id'];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Stack(
        children: [
          GestureDetector(
            onTap: () async {
              done = !done;
              if (done) {
                repositories.doneAudioItem(
                  widget.id!,
                  true,
                  'DeleteCollections',
                );
                setState(() {});
              }
              if (!done) {
                repositories.doneAudioItem(
                  widget.id!,
                  false,
                  'DeleteCollections',
                );
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
                  color: widget.done! ? AppColor.colorText : AppColor.white,
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
