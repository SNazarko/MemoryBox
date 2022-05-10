import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../../../Blocs/navigation_bloc/navigation__bloc.dart';
import '../../../../Blocs/navigation_bloc/navigation__state.dart';
import '../../../../repositories/collections_repositories.dart';
import '../../../../resources/app_colors.dart';
import '../../../../utils/constants.dart';
import '../../../../widgets/navigation/navigate_to_page.dart';
import '../../../../widgets/uncategorized/appbar_clipper.dart';
import '../../collection/collection.dart';
import '../../collection_edit/collection_edit.dart';

class AppbarHeaderCollectionAddAudioInCollection extends StatelessWidget {
  const AppbarHeaderCollectionAddAudioInCollection({Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
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
                      var uuid = const Uuid();
                      var id = uuid.v1();
                      CollectionsRepositories.instance
                          .addCollections('Без названия', '...', '', id);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return CollectionsEdit(
                          idCollection: id,
                          titleCollection: 'Без названия',
                          subTitleCollection: '...',
                          imageCollection: '',
                        );
                      }));
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
                  GestureDetector(
                    onTap: () => NavigateToPage.instance?.navigate(
                      context,
                      index: 1,
                      currentIndex: state.currentIndex,
                      route: Collections.routeName,
                    ),
                    child: const Text(
                      'Добавить',
                      style: kTitle2TextStyle2,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
