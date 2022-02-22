import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:memory_box/models/audio_model.dart';
import 'package:memory_box/pages/collections_pages/collection_edit/collections_edit_model.dart';
import 'package:memory_box/pages/collections_pages/collections_add_audio/collections_add_audio.dart';
import 'package:memory_box/pages/collections_pages/collections_item/collections_item_page_model.dart';
import 'package:memory_box/repositories/audio_repositories.dart';
import 'package:memory_box/repositories/user_repositories.dart';
import 'package:memory_box/resources/app_colors.dart';
import 'package:memory_box/widgets/appbar_clipper.dart';
import 'package:memory_box/widgets/container_shadow.dart';
import 'package:memory_box/widgets/icon_back.dart';
import 'package:memory_box/widgets/icon_camera.dart';
import 'package:memory_box/widgets/image_pick.dart';
import 'package:memory_box/widgets/player_mini.dart';
import 'package:memory_box/widgets/popup_menu_button.dart';
import 'package:provider/provider.dart';

class CollectionItemEditPage extends StatelessWidget {
  const CollectionItemEditPage({Key? key}) : super(key: key);
  static const routeName = '/collection_item_edit_page.dart';
  static Widget create() {
    return const CollectionItemEditPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                _AppbarHeaderProfileEdit(),
                const _PhotoContainer(),
              ],
            ),
            SizedBox(
              height: 300.0,
              child: Column(
                children: [
                  const SizedBox(
                    height: 15.0,
                  ),
                  const Flexible(fit: FlexFit.loose, child: SubTitle()),
                  Flexible(
                      fit: FlexFit.tight,
                      child: ListCollectionsAudioItemEditPage()),
                ],
              ),
            ),
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
            : Image.network(
                '${context.watch<CollectionsItemPageModel>().getPhoto}',
                fit: BoxFit.fitWidth,
              ),
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

class _AppbarHeaderProfileEdit extends StatefulWidget {
  _AppbarHeaderProfileEdit({Key? key}) : super(key: key);

  @override
  State<_AppbarHeaderProfileEdit> createState() =>
      _AppbarHeaderProfileEditState();
}

class _AppbarHeaderProfileEditState extends State<_AppbarHeaderProfileEdit> {
  final TextEditingController _controller = TextEditingController();

  @override
  void didChangeDependencies() {
    _controller.text = '${context.watch<CollectionsItemPageModel>().getTitle}';
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 27.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconBack(
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              const PopupMenuCollectionEditItemPage()
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 90.0, left: 15.0, right: 15.0),
          child: TextField(
            controller: _controller,
            onChanged: (title) {},
            style: const TextStyle(
              fontSize: 24.0,
              color: AppColor.white100,
              fontWeight: FontWeight.w700,
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}

class PopupMenuCollectionEditItemPage extends StatelessWidget {
  const PopupMenuCollectionEditItemPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: const Icon(
        Icons.more_horiz,
        color: AppColor.white,
      ),
      iconSize: 40,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      itemBuilder: (context) => [
        popupMenuItem('Редактировать', () {}, 0),
        popupMenuItem('Выбрать несколько', () {}, 1),
        popupMenuItem('Удалить подборку', () {}, 2),
        popupMenuItem('Поделиться', () {}, 3),
      ],
    );
  }
}

class SubTitle extends StatefulWidget {
  const SubTitle({Key? key}) : super(key: key);

  @override
  _SubTitleState createState() => _SubTitleState();
}

class _SubTitleState extends State<SubTitle> {
  final TextEditingController _controller = TextEditingController();

  @override
  void didChangeDependencies() {
    _controller.text =
        '${context.watch<CollectionsItemPageModel>().getSubTitle}';
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
      ),
      child: TextField(
        controller: _controller,
        maxLines: 10,
        minLines: 1,
        onChanged: (subTitle) {},
        decoration: const InputDecoration(
          border: InputBorder.none,
        ),
        style: const TextStyle(
          fontSize: 16.0,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class ListCollectionsAudioItemEditPage extends StatelessWidget {
  ListCollectionsAudioItemEditPage({Key? key}) : super(key: key);
  final AudioRepositories repositories = AudioRepositories();

  Widget buildAudio(AudioModel audio) => PlayerMini(
        duration: '${audio.duration}',
        url: '${audio.audioUrl}',
        name: '${audio.audioName}',
        popupMenu: const PopupMenuPlayerMiniItemEditPage(),
      );
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          child: StreamBuilder<List<AudioModel>>(
            stream: repositories.readAudioPodbirka(
                '${context.watch<CollectionsItemPageModel>().getTitle}'),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text('Ошибка');
              }
              if (snapshot.hasData) {
                final audio = snapshot.data!;
                return ListView(
                  padding: const EdgeInsets.only(bottom: 50.0),
                  children: audio.map(buildAudio).toList(),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.4),
          ),
        ),
      ],
    );
  }
}

class PopupMenuPlayerMiniItemEditPage extends StatelessWidget {
  const PopupMenuPlayerMiniItemEditPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: const Icon(
        Icons.more_horiz,
      ),
      iconSize: 40,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      itemBuilder: (context) => [
        popupMenuItem('Переименовать', () {}, 0),
        popupMenuItem('Добавить в подборку', () {}, 1),
        popupMenuItem('Удалить ', () {}, 2),
        popupMenuItem('Поделиться', () {}, 3),
      ],
    );
  }
}
