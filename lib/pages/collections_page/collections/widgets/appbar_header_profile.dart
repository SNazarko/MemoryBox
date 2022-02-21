import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/pages/collections_page/collection_edit/collections_edit.dart';
import 'package:memory_box/pages/collections_page/collections/widgets/popup_menu_collection_page.dart';
import 'package:memory_box/resources/app_colors.dart';
import 'package:memory_box/resources/constants.dart';
import 'package:memory_box/widgets/appbar_clipper.dart';
import 'package:memory_box/widgets/popup_menu_button.dart';

class AppbarHeaderProfile extends StatelessWidget {
  const AppbarHeaderProfile({Key? key}) : super(key: key);

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
              const PopupMenuCollectionPage(),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 40.0),
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
