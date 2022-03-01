import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/pages/collections_pages/collection/collection.dart';
import 'package:memory_box/pages/collections_pages/collection_item/collections_item_page_model.dart';
import 'package:memory_box/pages/collections_pages/collection_item/widgets/popup_menu_collection_item_page.dart';
import 'package:memory_box/repositories/collections_repositories.dart';
import 'package:memory_box/resources/app_colors.dart';
import 'package:memory_box/resources/app_icons.dart';
import 'package:memory_box/widgets/appbar_clipper.dart';
import 'package:memory_box/widgets/icon_back.dart';
import 'package:provider/provider.dart';

class AppbarHeaderCollectionItem extends StatelessWidget {
  AppbarHeaderCollectionItem({Key? key}) : super(key: key);
  final CollectionsRepositories repositories = CollectionsRepositories();

  void alertDone(BuildContext context) {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          Timer(const Duration(seconds: 3), () {
            Navigator.pushNamed(context, Collections.routeName);
            repositories.deleteCollection(
                '${Provider.of<CollectionsItemPageModel>(context, listen: false).getTitle}',
                'CollectionsTale');
            repositories.copyPastCollections(
              '${Provider.of<CollectionsItemPageModel>(context, listen: false).getTitle}',
              'CollectionsTale',
              'DeleteCollections',
            );
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
              const PopupMenuCollectionItemPage(),
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
