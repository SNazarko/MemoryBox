import 'package:flutter/material.dart';
import 'package:memory_box/pages/collections_pages/collection/collection.dart';
import 'package:memory_box/pages/collections_pages/collection_item_edit_audio/widgets/popup_menu_collection_item_page.dart';
import 'package:memory_box/repositories/collections_repositories.dart';
import 'package:memory_box/widgets/button/icon_back.dart';

import '../../../../resources/app_colors.dart';
import '../../../../widgets/uncategorized/appbar_clipper.dart';

class AppbarHeaderCollectionItemEditAudio extends StatelessWidget {
  const AppbarHeaderCollectionItemEditAudio({
    Key? key,
    required this.idCollection,
    required this.titleCollection,
    required this.subTitleCollection,
  }) : super(key: key);
  final String idCollection;
  final String titleCollection;
  final String subTitleCollection;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
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
                  Navigator.pushNamed(context, Collections.routeName);
                  CollectionsRepositories.instance
                      .updateQualityAndTotalTime(idCollection);
                },
              ),
              PopupMenuCollectionItemEditAudioPage(
                titleCollection: titleCollection,
                subTitleCollection: subTitleCollection,
                idCollection: idCollection,
              ),
            ],
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(
              top: 90.0,
              left: 15.0,
              right: 15.0,
            ),
            child: Text(
              titleCollection,
              style: const TextStyle(
                fontSize: 24.0,
                color: AppColor.white100,
                fontWeight: FontWeight.w700,
              ),
            )),
      ],
    );
  }
}
