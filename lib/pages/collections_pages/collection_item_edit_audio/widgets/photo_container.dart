import 'package:flutter/material.dart';
import 'package:memory_box/pages/collections_pages/collection_item/collections_item_page_model.dart';
import 'package:memory_box/utils/constants.dart';
import 'package:memory_box/widgets/uncategorized/container_shadow.dart';
import 'package:provider/provider.dart';

class PhotoContainerCollectionItemEditAudio extends StatelessWidget {
  const PhotoContainerCollectionItemEditAudio({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final String image = context.watch<CollectionsItemPageModel>().getPhoto;
    if (image == '') {
      return Padding(
        padding: const EdgeInsets.only(
          left: 15.0,
          top: 130.0,
          right: 15.0,
        ),
        child: ContainerShadow(
            image: Container(
              color: Colors.grey,
            ),
            width: screenWidth * 0.955,
            height: 200.0,
            radius: 20.0,
            widget: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${context.watch<CollectionsItemPageModel>().getData}',
                    style: kTitle4TextStyle,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${context.watch<CollectionsItemPageModel>().getQuality} аудио',
                            style: kTitle2TextStyle,
                          ),
                          Text(
                            '${context.watch<CollectionsItemPageModel>().getTotalTime} часа',
                            style: kTitle2TextStyle,
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            )),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(
          left: 15.0,
          top: 130.0,
          right: 15.0,
        ),
        child: ContainerShadow(
            image: Image.network(
              image,
              fit: BoxFit.fitWidth,
            ),
            width: screenWidth * 0.955,
            height: 200.0,
            radius: 20.0,
            widget: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${context.watch<CollectionsItemPageModel>().getData}',
                    style: kTitle4TextStyle,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${context.watch<CollectionsItemPageModel>().getQuality} аудио',
                            style: kTitle2TextStyle,
                          ),
                          Text(
                            '${context.watch<CollectionsItemPageModel>().getTotalTime} часа',
                            style: kTitle2TextStyle,
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            )),
      );
    }
  }
}
