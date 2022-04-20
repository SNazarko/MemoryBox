import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/pages/collections_pages/collection_item/widgets/popup_menu_collection_item_page.dart';
import 'package:memory_box/resources/app_colors.dart';
import 'package:memory_box/widgets/button/icon_back.dart';
import 'package:provider/provider.dart';

import '../../../../widgets/uncategorized/appbar_clipper.dart';
import '../collections_item_page_model.dart';

class AppbarHeaderCollectionItem extends StatelessWidget {
  const AppbarHeaderCollectionItem({
    Key? key,
    required this.titleCollection,
    required this.idCollection,
    required this.subTitleCollection,
    required this.qualityCollection,
    required this.imageCollection,
    required this.dataCollection,
    required this.totalTimeCollection,
  }) : super(key: key);
  final String idCollection;
  final String titleCollection;
  final String subTitleCollection;
  final String qualityCollection;
  final String imageCollection;
  final String dataCollection;
  final String totalTimeCollection;

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
                  Navigator.pop(context);
                },
              ),
              PopupMenuCollectionItemPage(
                idCollection: idCollection,
                subTitleCollection: subTitleCollection,
                totalTimeCollection: totalTimeCollection,
                imageCollection: imageCollection,
                titleCollection: titleCollection,
                dataCollection: dataCollection,
                qualityCollection: qualityCollection,
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
