import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/repositories/collections_repositories.dart';
import 'package:memory_box/resources/app_colors.dart';
import 'package:memory_box/resources/constants.dart';
import 'package:memory_box/widgets/appbar_clipper.dart';
import 'package:memory_box/widgets/icon_back.dart';
import 'package:provider/provider.dart';

import '../collection_edit_model.dart';

class AppbarHeaderEdit extends StatelessWidget {
  AppbarHeaderEdit({Key? key}) : super(key: key);
  // final CollectionsRepositories repositories = CollectionsRepositories();
  //
  // Future<String?> stateId(BuildContext context) async {
  //   String? state;
  //   await FirebaseFirestore.instance
  //       .collection(repositories.user!.phoneNumber!)
  //       .doc('id')
  //       .collection('Collections')
  //       .where('id',
  //           isEqualTo:
  //               Provider.of<CollectionsEditModel>(context, listen: false).getId)
  //       .get()
  //       .then((querySnapshot) {
  //     for (var result in querySnapshot.docs) {
  //       state = result.data()['id'];
  //     }
  //   });
  //   return state;
  // }

  void updateCollection(BuildContext context) {
    CollectionsRepositories().updateCollection(
      Provider.of<CollectionsEditModel>(context, listen: false).getId,
      Provider.of<CollectionsEditModel>(context, listen: false).getTitle,
      Provider.of<CollectionsEditModel>(context, listen: false).getSubTitle,
      Provider.of<CollectionsEditModel>(context, listen: false).getImage,
    );
  }

  void addCollections(BuildContext context) {
    CollectionsRepositories().addCollections(
      Provider.of<CollectionsEditModel>(context, listen: false).getTitle ?? '',
      Provider.of<CollectionsEditModel>(context, listen: false).getTitle ?? '',
      Provider.of<CollectionsEditModel>(context, listen: false).getSubTitle ??
          '',
      Provider.of<CollectionsEditModel>(context, listen: false).getImage ?? '',
    );
  }

  @override
  Widget build(BuildContext context) {
    final state =
        Provider.of<CollectionsEditModel>(context, listen: false).getId;
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
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconBack(
                onPressed: () {
                  Navigator.pop(context);
                  // getQualityAudio(context);
                },
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: Text(
                  'Создание',
                  style: kTitleTextStyle2,
                ),
              ),
              TextButton(
                  onPressed: () {
                    // print('$state до');
                    state == null
                        ? addCollections(context)
                        : updateCollection(context);

                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Готово',
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                        color: AppColor.white100),
                  ))
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 90.0, left: 15.0, right: 15.0),
          child: TextField(
            onChanged: (title) {
              context.read<CollectionsEditModel>().userTitle(title);
            },
            style: const TextStyle(
              fontSize: 24.0,
              color: AppColor.white100,
              fontWeight: FontWeight.w700,
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: 'Название',
              hintStyle: TextStyle(fontSize: 24.0, color: AppColor.white100),
            ),
          ),
        ),
      ],
    );
  }
}
