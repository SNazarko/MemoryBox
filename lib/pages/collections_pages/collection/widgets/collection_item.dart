import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/pages/collections_pages/collection_item/collections_item_page.dart';
import 'package:memory_box/pages/collections_pages/collection_item/collections_item_page_model.dart';
import 'package:memory_box/repositories/collections_repositories.dart';
import 'package:memory_box/resources/app_colors.dart';
import 'package:memory_box/resources/app_icons.dart';
import 'package:provider/provider.dart';

import '../collection_model.dart';
import '../collection.dart';

class CollectionItem extends StatelessWidget {
  const CollectionItem({
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
  final bool? doneCollection;

  void alertDone(BuildContext context) {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          Timer(const Duration(seconds: 3), () {
            Navigator.pushNamed(context, Collections.routeName);
          });
          return AlertDialog(
            insetPadding: const EdgeInsets.all(75.0),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  20.0,
                ),
              ),
            ),
            content: Image.asset(
              AppIcons.tick,
              width: 175.0,
              height: 175.0,
            ),
          );
        });
  }

  void alertDialog(BuildContext context) => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: const Text(
            'Подтверждаете удаление?',
            style: TextStyle(color: AppColor.pink, fontSize: 18.0),
          ),
          content: const Text(
            'Ваш файл перенесется в папку “Недавно удаленные”. Через 15 дней он исчезнет.',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColor.colorText70, fontSize: 14.0),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextButton(
                onPressed: () async {
                  Navigator.pop(context);
                  alertDone(context);
                },
                child: const Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
                  child: Text(
                    'Да',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(AppColor.colorAppbar),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                      side: const BorderSide(
                        color: AppColor.colorAppbar,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 50.0),
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                  child: Text(
                    'Нет',
                    style: TextStyle(color: AppColor.colorText),
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(AppColor.white100),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                      side: const BorderSide(
                        color: AppColor.blue300,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    final bool itemDone = context.watch<CollectionModel>().getItemDone;
    return ClipRRect(
      borderRadius: const BorderRadius.all(
        Radius.circular(20.0),
      ),
      child: itemDone ? getCollectionDone(context) : getCollectionItem(context),
    );
  }

  getCollectionItem(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<CollectionsItemPageModel>().setIdCollection(id!);
        context.read<CollectionsItemPageModel>().setTitle(title!);
        context.read<CollectionsItemPageModel>().setSubTitle(subTitle!);
        context.read<CollectionsItemPageModel>().setPhoto(image!);
        context.read<CollectionsItemPageModel>().setData(data!);
        context.read<CollectionsItemPageModel>().setQuality(quality!);
        context.read<CollectionsItemPageModel>().setTotalTime(totalTime!);
        Navigator.pushNamed(
          context,
          CollectionsItemPage.routeName,
        );
      },
      child: Container(
        width: 185.0,
        height: 250.0,
        color: Colors.grey,
        child: Stack(
          children: [
            image != ''
                ? Image.network(
                    image!,
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
              padding: const EdgeInsets.only(left: 10, right: 5, bottom: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Flexible(
                    flex: 10,
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
                  const SizedBox(
                    width: 5.0,
                  ),
                  Flexible(
                    flex: 10,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '$quality аудио',
                          style: const TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w400,
                            color: AppColor.white100,
                          ),
                        ),
                        Text(
                          '$totalTime часа',
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
          ],
        ),
      ),
    );
  }

  getCollectionDone(BuildContext context) {
    final bool done = context.watch<CollectionModel>().getStateDone;
    return Container(
      width: 185.0,
      height: 250.0,
      color: Colors.grey,
      child: Stack(
        children: [
          image != ''
              ? Image.network(
                  image!,
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
          Container(
            width: 185.0,
            height: 250.0,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.4),
              gradient: LinearGradient(
                  colors: doneCollection ?? false
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
                    context.read<CollectionModel>().stateDone();
                    CollectionsRepositories().doneCollections(
                      title!,
                      done,
                    );
                    if (!doneCollection!) {
                      CollectionsRepositories().copyPastCollections(
                        title!,
                        'CollectionsTale',
                        'DeleteCollections',
                      );
                    }
                    if (doneCollection!) {
                      CollectionsRepositories().deleteCollection(
                        title!,
                        'DeleteCollections',
                      );
                    }
                  },
                  icon: Icon(
                    Icons.done,
                    color: doneCollection ?? false
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
    );
  }
}
