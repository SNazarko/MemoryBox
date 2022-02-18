import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:memory_box/pages/collections_page/collections_add_audio/collections_add_audio.dart';
import 'package:memory_box/repositories/collections_repositories.dart';
import 'package:memory_box/repositories/user_repositories.dart';
import 'package:memory_box/resources/app_colors.dart';
import 'package:memory_box/resources/constants.dart';
import 'package:memory_box/widgets/appbar_clipper.dart';
import 'package:memory_box/widgets/container_shadow.dart';
import 'package:memory_box/widgets/icon_back.dart';
import 'package:memory_box/widgets/icon_camera.dart';
import 'package:memory_box/widgets/image_pick.dart';
import 'package:provider/provider.dart';

import 'collections_edit_model.dart';

class CollectionsEdit extends StatelessWidget {
  const CollectionsEdit({Key? key}) : super(key: key);
  static const routeName = 'collection_edit';
  static Widget create() {
    return const CollectionsEdit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: const [
                _AppbarHeaderProfileEdit(),
                _PhotoContainer(),
              ],
            ),
            const SizedBox(
              height: 15.0,
            ),
            const Padding(
              padding: EdgeInsets.only(
                left: 28.0,
              ),
              child: Text(
                'Введите описание...',
                style: kBodi2TextStyle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
              ),
              child: TextField(
                maxLines: 3,
                onChanged: (subTitle) {
                  context.read<CollectionsEditModel>().userSubTitle(subTitle);
                },
                style: const TextStyle(
                  fontSize: 16.0,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                right: 10.0,
              ),
              child: Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Готово',
                    style: kLinkColorText,
                  ),
                ),
              ),
            ),
            TextButton(
                onPressed: () {
                  CollectionsRepositories().addCollections(
                    Provider.of<CollectionsEditModel>(context, listen: false)
                            .getTitle ??
                        '',
                    Provider.of<CollectionsEditModel>(context, listen: false)
                            .getTitle ??
                        '',
                    Provider.of<CollectionsEditModel>(context, listen: false)
                            .getSubTitle ??
                        '',
                    Provider.of<CollectionsEditModel>(context, listen: false)
                            .getImage ??
                        '',
                  );

                  Navigator.pushNamed(context, CollectionsAddAudio.routeName);
                },
                child: const Center(
                  child: Text(
                    'Добавить аудиофайл',
                    style: TextStyle(
                      color: AppColor.colorText80,
                      fontSize: 14.0,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

class _PhotoContainer extends StatefulWidget {
  const _PhotoContainer({Key? key}) : super(key: key);

  @override
  State<_PhotoContainer> createState() => _PhotoContainerState();
}

class _PhotoContainerState extends State<_PhotoContainer> {
  ImagePick imagePick = ImagePick();
  String? singleImage;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(
        left: 15.0,
        top: 150.0,
        right: 15.0,
      ),
      child: ContainerShadow(
        image: singleImage != null
            ? Image.network(
                '$singleImage',
                fit: BoxFit.fitWidth,
              )
            : const Text(''),
        width: screenWidth * 0.955,
        height: 200.0,
        widget: IconCamera(
          color: AppColor.glass,
          onTap: () async {
            XFile? _image = await imagePick.singleImagePick();
            if (_image != null && _image.path.isNotEmpty) {
              singleImage = await UserRepositories().uploadImage(_image);
              context.read<CollectionsEditModel>().image(singleImage!);
              setState(() {});
            }
          },
          colorBorder: AppColor.colorText80,
          position: 0.0,
        ),
        radius: 20.0,
      ),
    );
  }
}

class _AppbarHeaderProfileEdit extends StatelessWidget {
  const _AppbarHeaderProfileEdit({Key? key}) : super(key: key);

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
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconBack(
                onPressed: () {
                  Navigator.pop(context);
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
                    CollectionsRepositories().addCollections(
                      Provider.of<CollectionsEditModel>(context, listen: false)
                          .getTitle,
                      Provider.of<CollectionsEditModel>(context, listen: false)
                          .getTitle,
                      Provider.of<CollectionsEditModel>(context, listen: false)
                          .getSubTitle,
                      Provider.of<CollectionsEditModel>(context, listen: false)
                          .getImage,
                    );

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
