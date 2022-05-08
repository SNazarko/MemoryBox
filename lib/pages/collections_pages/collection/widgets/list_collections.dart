import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/models/collections_model.dart';
import 'package:memory_box/pages/authorization_pages/registration_page/registration_page.dart';
import 'package:memory_box/repositories/collections_repositories.dart';
import 'package:memory_box/resources/app_colors.dart';

import 'collection_item.dart';

class ListCollections extends StatelessWidget {
  ListCollections({Key? key}) : super(key: key);

  Widget buildCollections(CollectionsModel collections) => CollectionItem(
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
        stream: CollectionsRepositories.instance!.readCollections(),
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
