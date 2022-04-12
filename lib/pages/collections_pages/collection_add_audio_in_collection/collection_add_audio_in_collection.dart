import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memory_box/repositories/user_repositories.dart';
import 'package:provider/provider.dart';

import '../../../models/collections_model.dart';
import '../../../models/view_model.dart';
import '../../../repositories/collections_repositories.dart';
import '../../../resources/app_colors.dart';
import '../../../resources/constants.dart';
import '../../../widgets/appbar_clipper.dart';
import '../../authorization_page/registration_page/registration_page.dart';
import '../collection/collection_model.dart';
import '../collection/widgets/collection_item.dart';
import '../collection/widgets/popup_menu_collection_page.dart';
import '../collection_edit/collection_edit.dart';
import '../collection_item/collections_item_page.dart';
import '../collection_item/collections_item_page_model.dart';
import 'collection_add_audio_in_collection_model.dart';

class CollectionAddAudioInCollection extends StatelessWidget {
  const CollectionAddAudioInCollection({Key? key}) : super(key: key);
  static const routeName = '/collection_add_audio_in_collection';
  static Widget create() {
    return ChangeNotifierProvider<CollectionAddAudioInCollectionModel>(
        create: (BuildContext context) => CollectionAddAudioInCollectionModel(),
        child: CollectionAddAudioInCollection());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            _AppbarHeaderCollection(),
            _ListCollections(),
          ],
        ),
      ),
    );
  }
}

class _ListCollections extends StatelessWidget {
  _ListCollections({Key? key}) : super(key: key);
  final CollectionsRepositories repositories = CollectionsRepositories();

  Widget buildCollections(CollectionsModel collections) =>
      CollectionModelAddAudio(
        id: '${collections.id}',
        image: '${collections.avatarCollections}',
        title: '${collections.titleCollections}',
        subTitle: '${collections.subTitleCollections}',
        data: '${collections.dateTime}',
        quality: '${collections.qualityCollections}',
        doneCollection: collections.doneCollection,
        totalTime: '${collections.totalTime}',
      );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 90.0),
      child: StreamBuilder<List<CollectionsModel>>(
        stream: repositories.readCollections(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
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
    );
  }
}

class CollectionModelAddAudio extends StatefulWidget {
  CollectionModelAddAudio({
    Key? key,
    this.title,
    this.quality,
    this.image,
    this.subTitle,
    this.data,
    this.doneCollection,
    this.id,
    this.totalTime,
  }) : super(key: key);
  final String? id;
  final String? title;
  final String? subTitle;
  final String? quality;
  final String? image;
  final String? data;
  final String? totalTime;
  bool? doneCollection = false;

  @override
  State<CollectionModelAddAudio> createState() =>
      _CollectionModelAddAudioState();
}

class _CollectionModelAddAudioState extends State<CollectionModelAddAudio> {
  bool done = true;
  @override
  void initState() {
    final List collectionAudio =
        Provider.of<CollectionAddAudioInCollectionModel>(context, listen: false)
            .getCollectionAudio;
    collectionAudio.contains(widget.id)
        ? CollectionsRepositories().doneCollections(
            widget.id!,
            true,
          )
        : CollectionsRepositories().doneCollections(
            widget.id!,
            false,
          );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(
        Radius.circular(20.0),
      ),
      child: Container(
        width: 185.0,
        height: 250.0,
        color: Colors.grey,
        child: Stack(
          children: [
            widget.image != ''
                ? Image.network(
                    widget.image!,
                    fit: BoxFit.fill,
                    width: 185.0,
                    height: 250.0,
                  )
                : Container(
                    width: 185.0,
                    height: 250.0,
                    color: Colors.grey,
                  ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 5, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Flexible(
                    flex: 10,
                    child: Text(
                      widget.title!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w700,
                        color: AppColor.white100,
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 10,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          '${widget.quality} аудио',
                          style: const TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w400,
                            color: AppColor.white100,
                          ),
                        ),
                        Text(
                          '${widget.totalTime} часа',
                          style: const TextStyle(
                            fontSize: 12.0,
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
            Container(
              width: 185.0,
              height: 250.0,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.4),
                gradient: LinearGradient(
                    colors: widget.doneCollection!

                        // done
                        ? [const Color(0xFF000000), const Color(0xFF000000)]
                        : [const Color(0xFF000000), const Color(0xFF454545)],
                    begin: Alignment.bottomRight),
              ),
            ),
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColor.white),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(25.0),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      widget.doneCollection = !widget.doneCollection!;
                      if (!widget.doneCollection!) {
                        CollectionsRepositories().doneCollections(
                          widget.id!,
                          false,
                        );
                        CollectionsRepositories().addAudioCollections(
                          widget.id!,
                          Provider.of<CollectionAddAudioInCollectionModel>(
                                  context,
                                  listen: false)
                              .getIdAudio,
                          Provider.of<CollectionAddAudioInCollectionModel>(
                                  context,
                                  listen: false)
                              .getCollectionAudio,
                          false,
                        );
                      }
                      if (widget.doneCollection!) {
                        CollectionsRepositories().doneCollections(
                          widget.id!,
                          true,
                        );
                        CollectionsRepositories().addAudioCollections(
                          widget.id!,
                          Provider.of<CollectionAddAudioInCollectionModel>(
                                  context,
                                  listen: false)
                              .getIdAudio,
                          Provider.of<CollectionAddAudioInCollectionModel>(
                                  context,
                                  listen: false)
                              .getCollectionAudio,
                          true,
                        );
                      }
                      CollectionsRepositories().updateQualityAndTotalTime(
                        widget.id!,
                      );
                    },
                    icon: Icon(
                      Icons.done,
                      color: widget.doneCollection!
                          // done
                          // context.watch<ModelPlayerMiniPodborki>().done
                          ? AppColor.white
                          : AppColor.glass,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _AppbarHeaderCollection extends StatelessWidget {
  _AppbarHeaderCollection({Key? key}) : super(key: key);

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
                  CollectionsRepositories()
                      .addCollections('Без названия', '...', '', context);
                  Navigator.pushNamed(context, CollectionsEdit.routeName);
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
              GestureDetector(
                onTap: () {
                  Provider.of<Navigation>(context, listen: false)
                      .setCurrentIndex = 1;
                },
                child: const Text(
                  'Добавить',
                  style: kTitle2TextStyle2,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
