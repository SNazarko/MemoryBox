import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:memory_box/pages/podborki_page/podborki_edit_model.dart';
import 'package:memory_box/repositories/collections_repositories.dart';
import 'package:memory_box/repositories/user_repositories.dart';
import 'package:memory_box/resources/app_colors.dart';
import 'package:memory_box/resources/constants.dart';
import 'package:memory_box/widgets/appbar_clipper.dart';
import 'package:memory_box/widgets/bottom_nav_bar.dart';
import 'package:memory_box/widgets/container_shadow.dart';
import 'package:memory_box/widgets/icon_back.dart';
import 'package:memory_box/widgets/icon_camera.dart';
import 'package:provider/provider.dart';

class PodborkiEdit extends StatelessWidget {
  const PodborkiEdit({Key? key}) : super(key: key);
  static const rootName = 'podborki_edit';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomNavBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                const _AppbarHeaderProfileEdit(),
                _FotoContainer(),
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
                onChanged: (subTitle) {
                  context.read<PodborkiEditModel>().userSubTitle(subTitle);
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
                onPressed: () {},
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

class _FotoContainer extends StatefulWidget {
  _FotoContainer({Key? key}) : super(key: key);

  @override
  State<_FotoContainer> createState() => _FotoContainerState();
}

class _FotoContainerState extends State<_FotoContainer> {
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
          width: screenWidth * 0.955,
          height: 240.0,
          widget: IconCamera(
            color: AppColor.glass,
            onTap: () async {
              XFile? _image = await UserRepositories().singleImagePick();
              if (_image != null && _image.path.isNotEmpty) {
                singleImage = await UserRepositories().uploadImage(_image);
                context.read<PodborkiEditModel>().image(singleImage!);
                setState(() {});
              }
            },
            colorBorder: AppColor.colorText80,
            position: 0.0,
          ),
          radius: 20.0),
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
                      Provider.of<PodborkiEditModel>(context, listen: false)
                          .getTitle,
                      Provider.of<PodborkiEditModel>(context, listen: false)
                          .getSubTitle,
                      Provider.of<PodborkiEditModel>(context, listen: false)
                          .getImage,
                    );
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
              context.read<PodborkiEditModel>().userTitle(title);
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
