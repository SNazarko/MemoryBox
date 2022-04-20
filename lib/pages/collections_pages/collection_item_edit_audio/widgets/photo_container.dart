import 'package:flutter/material.dart';
import 'package:memory_box/utils/constants.dart';
import 'package:memory_box/widgets/uncategorized/container_shadow.dart';

class PhotoContainerCollectionItemEditAudio extends StatelessWidget {
  const PhotoContainerCollectionItemEditAudio({
    Key? key,
    required this.qualityCollection,
    required this.imageCollection,
    required this.dataCollection,
    required this.totalTimeCollection,
  }) : super(key: key);
  final String qualityCollection;
  final String imageCollection;
  final String dataCollection;
  final String totalTimeCollection;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    if (imageCollection == '') {
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
                    dataCollection,
                    style: kTitle4TextStyle,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '$qualityCollection аудио',
                            style: kTitle2TextStyle,
                          ),
                          Text(
                            '$totalTimeCollection часа',
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
              imageCollection,
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
                    dataCollection,
                    style: kTitle4TextStyle,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '$qualityCollection аудио',
                            style: kTitle2TextStyle,
                          ),
                          Text(
                            '$totalTimeCollection часа',
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
