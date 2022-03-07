import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/models/audio_model.dart';
import 'package:memory_box/pages/search_page/search_page_model.dart';
import 'package:memory_box/repositories/audio_repositories.dart';
import 'package:memory_box/resources/app_colors.dart';
import 'package:memory_box/resources/app_icons.dart';
import 'package:memory_box/resources/constants.dart';
import 'package:memory_box/widgets/appbar_clipper.dart';
import 'package:memory_box/widgets/player_mini/player_mini.dart';
import 'package:memory_box/widgets/popup_menu_button.dart';
import 'package:provider/provider.dart';

import '../save_page.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);
  static const routeName = '/search_page';
  static Widget create() {
    return
        // ChangeNotifierProvider<SearchPageModel>(
        // create: (BuildContext context) => SearchPageModel(),
        // child:
        const SearchPage();
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
          'Поиск',
          style: kTitleTextStyle2,
        ),
        actions: const [PopupMenuSearchPage()],
      ),
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
            color: AppColor.colorAppbar,
            width: double.infinity,
            height: 160.0,
          ),
        ),
        const Align(
          alignment: Alignment.center,
          child: Text(
            'Найди потеряшку',
            style: kTitle2TextStyle2,
          ),
        ),
        const SearchPanel(),
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
      padding: const EdgeInsets.only(left: 20.0, top: 61.0, right: 12.0),
      child: Container(
        height: 60.0,
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
                    onChanged: (searchTxt) {
                      var text = searchTxt;
                      context
                          .read<SearchPageModel>()
                          .setSearchData(text.toLowerCase());
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
    );
  }
}

class _ListPlayers extends StatelessWidget {
  _ListPlayers({Key? key}) : super(key: key);

  Stream<List<AudioModel>> audio(BuildContext context) => FirebaseFirestore
      .instance
      .collection('Collections')
      .where('searchName',
          arrayContains: context.watch<SearchPageModel>().getSearchData)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => AudioModel.fromJson(doc.data())).toList());

  final AudioRepositories repositories = AudioRepositories();
  Widget buildAudio(AudioModel audio) => PlayerMini(
        duration: '${audio.duration}',
        url: '${audio.audioUrl}',
        name: '${audio.audioName}',
        popupMenu: PopupMenuAudioSearchPage(
          url: '${audio.audioUrl}',
          duration: '${audio.duration}',
          name: '${audio.audioName}',
          image: '',
        ),
      );

  @override
  Widget build(BuildContext context) {
    final data = context.watch<SearchPageModel>().getSearchData;
    final double screenHeight = MediaQuery.of(context).size.height;
    if (data == '') {
      return Column(
        children: [
          SizedBox(
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
                    padding: const EdgeInsets.only(top: 165, bottom: 110),
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
    } else {
      return Column(
        children: [
          SizedBox(
            height: screenHeight * 0.95,
            child: StreamBuilder<List<AudioModel>>(
              stream: audio(context),
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
                    padding: const EdgeInsets.only(top: 165, bottom: 110),
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
}

class PopupMenuAudioSearchPage extends StatelessWidget {
  PopupMenuAudioSearchPage({
    Key? key,
    required this.name,
    required this.url,
    required this.duration,
    required this.image,
  }) : super(key: key);
  final AudioRepositories repositories = AudioRepositories();
  final String name;
  final String url;
  final String duration;
  final String image;

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
          () {
            Timer(const Duration(seconds: 1), () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return SavePage(
                  image: image,
                  url: url,
                  duration: duration,
                  name: name,
                );
              }));
            });
          },
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

class PopupMenuSearchPage extends StatelessWidget {
  const PopupMenuSearchPage({Key? key}) : super(key: key);

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
