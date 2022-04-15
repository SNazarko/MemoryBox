import 'package:flutter/material.dart';
import 'package:memory_box/pages/collections_pages/collection_item/collections_item_page.dart';
import 'package:memory_box/pages/collections_pages/collection_item/collections_item_page_model.dart';
import 'package:memory_box/repositories/collections_repositories.dart';
import 'package:memory_box/resources/app_colors.dart';
import 'package:provider/provider.dart';

import '../collection_model.dart';

class CollectionItem extends StatelessWidget {
  CollectionItem({
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
  bool done = true;

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
                Flexible(
                  flex: 10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
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
          Container(
            width: 185.0,
            height: 250.0,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.4),
              gradient: LinearGradient(
                  colors: doneCollection!
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
                    doneCollection = !doneCollection!;
                    if (!doneCollection!) {
                      CollectionsRepositories().doneCollections(
                        id!,
                        false,
                      );
                    }
                    if (doneCollection!) {
                      CollectionsRepositories().doneCollections(
                        id!,
                        true,
                      );
                    }
                  },
                  icon: Icon(
                    Icons.done,
                    color: doneCollection! ? AppColor.white : AppColor.glass,
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
