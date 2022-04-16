import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/pages/collections_pages/collection_item/widgets/popup_menu_collection_item_page.dart';
import 'package:memory_box/resources/app_colors.dart';
import 'package:memory_box/widgets/appbar_clipper.dart';
import 'package:memory_box/widgets/icon_back.dart';
import 'package:provider/provider.dart';

import '../collections_item_page_model.dart';

class AppbarHeaderCollectionItem extends StatelessWidget {
  const AppbarHeaderCollectionItem({Key? key}) : super(key: key);

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
              PopupMenuCollectionItemPage(),
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
              '${context.watch<CollectionsItemPageModel>().getTitle}',
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
