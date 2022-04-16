import 'dart:async';

import 'package:flutter/material.dart';
import 'package:memory_box/pages/collections_pages/collection/collection.dart';
import 'package:memory_box/pages/collections_pages/collection_item/collections_item_page_model.dart';
import 'package:memory_box/pages/collections_pages/collection_item_edit_audio/widgets/popup_menu_collection_item_page.dart';
import 'package:memory_box/repositories/collections_repositories.dart';
import 'package:memory_box/resources/app_colors.dart';
import 'package:memory_box/resources/app_icons.dart';
import 'package:memory_box/widgets/appbar_clipper.dart';
import 'package:memory_box/widgets/icon_back.dart';
import 'package:provider/provider.dart';

class AppbarHeaderCollectionItemEditAudio extends StatelessWidget {
  AppbarHeaderCollectionItemEditAudio({Key? key}) : super(key: key);
  final CollectionsRepositories _rep = CollectionsRepositories();

  // void _alertDone(BuildContext context) {
  //   showDialog<String>(
  //       context: context,
  //       builder: (BuildContext context) {
  //         Timer(const Duration(seconds: 3), () {
  //           Navigator.pushNamed(context, Collections.routeName);
  //           _rep.deleteCollection(
  //               '${Provider.of<CollectionsItemPageModel>(context, listen: false).getIdCollection}',
  //               'CollectionsTale');
  //           _rep.copyPastCollections(
  //             '${Provider.of<CollectionsItemPageModel>(context, listen: false).getIdCollection}',
  //             'CollectionsTale',
  //             'DeleteCollections',
  //           );
  //         });
  //         return AlertDialog(
  //           insetPadding: const EdgeInsets.all(75.0),
  //           shape: const RoundedRectangleBorder(
  //             borderRadius: BorderRadius.all(
  //               Radius.circular(
  //                 20.0,
  //               ),
  //             ),
  //           ),
  //           content: Image.asset(
  //             AppIcons.tick,
  //             width: 175.0,
  //             height: 175.0,
  //           ),
  //         );
  //       });
  // }

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
                },
              ),
              PopupMenuCollectionItemEditAudioPage(),
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
