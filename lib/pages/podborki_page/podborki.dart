import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/models/collections_model.dart';
import 'package:memory_box/repositories/collections_repositories.dart';
import 'package:memory_box/resources/app_colors.dart';
import 'package:memory_box/resources/constants.dart';
import 'package:memory_box/pages/podborki_page/podborki_edit.dart';
import 'package:memory_box/widgets/appbar_clipper.dart';
import 'package:memory_box/widgets/bottom_nav_bar.dart';

class Podborki extends StatelessWidget {
  const Podborki({Key? key}) : super(key: key);
  static const rootName = 'podborki';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomNavBar(),
      body: SafeArea(
        child: Stack(
          children: [
            _AppbarHeaderProfileEdit(),
            _listPodborki(),
          ],
        ),
      ),
    );
  }
}

class _listPodborki extends StatelessWidget {
  _listPodborki({Key? key}) : super(key: key);
  CollectionsRepositories repositories = CollectionsRepositories();

  Widget buildCollections(CollectionsModel collections) => PodborkiItem(
        image: '${collections.avatarCollections}',
        title: '${collections.titleCollections}',
      );
  //     PlayerMini(
  //   duration: '${audio.duration}',
  //   url: '${audio.audioUrl}',
  //   name: '${audio.audioName}',
  // );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 90.0),
      child: StreamBuilder<List<CollectionsModel>>(
        stream: repositories.readAudio(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Ошибка');
          }
          if (snapshot.hasData) {
            final collections = snapshot.data!;
            return GridView.count(
              primary: false,
              padding: const EdgeInsets.all(20.0),
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
              crossAxisCount: 2,
              childAspectRatio: 0.76,
              children: collections.map(buildCollections).toList(),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      // GridView.count(
      //   primary: false,
      //   padding: const EdgeInsets.all(20.0),
      //   crossAxisSpacing: 16.0,
      //   mainAxisSpacing: 16.0,
      //   crossAxisCount: 2,
      //   childAspectRatio: 0.76,
      //   children: <Widget>[
      //     PodborkiItem(),
      //     PodborkiItem(),
      //     PodborkiItem(),
      //     PodborkiItem(),
      //     PodborkiItem(),
      //     PodborkiItem(),
      //     PodborkiItem(),
      //     PodborkiItem(),
      //   ],
      // ),
    );
  }
}

class PodborkiItem extends StatelessWidget {
  PodborkiItem({Key? key, this.image, this.title}) : super(key: key);
  String? title;
  int quality = 5;
  String? image;

  @override
  Widget build(BuildContext context) {
    print(image);
    return ClipRRect(
      borderRadius: const BorderRadius.all(
        Radius.circular(20.0),
      ),
      child: SizedBox(
        width: 185.0,
        height: 250.0,
        child: Stack(
          children: [
            Image.network(
              image!,
              fit: BoxFit.fill,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 5, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Text(
                      title!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w700,
                        color: AppColor.white100,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          '$quality аудио',
                          style: const TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w400,
                            color: AppColor.white100,
                          ),
                        ),
                        const Text(
                          '3:33 часа',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w400,
                            color: AppColor.white100,
                          ),
                        )
                      ],
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
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, PodborkiEdit.rootName);
                },
                icon: const Icon(
                  Icons.add,
                  size: 35.0,
                  color: Colors.white,
                ),
              ),
              const Text(
                'Подборки',
                style: kTitleTextStyle2,
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.more_horiz,
                  size: 35.0,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 40.0),
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
      ],
    );
  }
}
