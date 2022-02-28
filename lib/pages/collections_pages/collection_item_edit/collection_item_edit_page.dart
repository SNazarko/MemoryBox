import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:memory_box/models/audio_model.dart';
import 'package:memory_box/pages/collections_pages/collections/collections.dart';
import 'package:memory_box/pages/collections_pages/collections_item/collections_item_page_model.dart';
import 'package:memory_box/repositories/audio_repositories.dart';
import 'package:memory_box/repositories/collections_repositories.dart';
import 'package:memory_box/repositories/user_repositories.dart';
import 'package:memory_box/resources/app_colors.dart';
import 'package:memory_box/resources/constants.dart';
import 'package:memory_box/widgets/appbar_clipper.dart';
import 'package:memory_box/widgets/container_shadow.dart';
import 'package:memory_box/widgets/icon_back.dart';
import 'package:memory_box/widgets/icon_camera.dart';
import 'package:memory_box/widgets/image_pick.dart';
import 'package:memory_box/widgets/player_mini.dart';
import 'package:provider/provider.dart';
import 'collection_item_edit_page_model.dart';

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
              children: const [
                _AppbarHeaderProfileEdit(),
                _PhotoContainer(),
              ],
            ),
            SizedBox(
              height: 450.0,
              child: Column(
                children: [
                  const SizedBox(
                    height: 15.0,
                  ),
                  const Flexible(fit: FlexFit.loose, child: SubTitle()),
                  Flexible(
                      fit: FlexFit.loose,
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
                '${Provider.of<CollectionsItemPageModel>(context, listen: false).getPhoto}',
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
              context
                  .read<CollectionItemEditPageModel>()
                  .setAvatarCollectionsEdit(singleImage!);
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
  const _AppbarHeaderProfileEdit({Key? key}) : super(key: key);

  @override
  State<_AppbarHeaderProfileEdit> createState() =>
      _AppbarHeaderProfileEditState();
}

class _AppbarHeaderProfileEditState extends State<_AppbarHeaderProfileEdit> {
  final TextEditingController _controller = TextEditingController();
  final CollectionsRepositories _repositories = CollectionsRepositories();

  @override
  void didChangeDependencies() {
    _controller.text =
        '${Provider.of<CollectionsItemPageModel>(context, listen: false).getTitle}';
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void editCollections(BuildContext context) {
    _repositories.addCollections(
      Provider.of<CollectionItemEditPageModel>(context, listen: false)
              .getTitleCollectionsEdit ??
          Provider.of<CollectionsItemPageModel>(context, listen: false)
              .getTitle,
      Provider.of<CollectionItemEditPageModel>(context, listen: false)
              .getTitleCollectionsEdit ??
          Provider.of<CollectionsItemPageModel>(context, listen: false)
              .getTitle,
      Provider.of<CollectionItemEditPageModel>(context, listen: false)
              .getSubTitleCollectionsEdit ??
          Provider.of<CollectionsItemPageModel>(context, listen: false)
              .getSubTitle,
      Provider.of<CollectionItemEditPageModel>(context, listen: false)
              .getAvatarCollectionsEdit ??
          Provider.of<CollectionsItemPageModel>(context, listen: false)
              .getPhoto,
    );
    _repositories.copyPastAudioCollections(
        '${Provider.of<CollectionsItemPageModel>(context, listen: false).getTitle}',
        '${Provider.of<CollectionItemEditPageModel>(context, listen: false).getTitleCollectionsEdit}');
    _repositories.deleteCollection(
      '${Provider.of<CollectionsItemPageModel>(context, listen: false).getTitle}',
      'CollectionsTale',
    );
    Navigator.pushNamed(context, Collections.routeName);
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
                onPressed: () => editCollections(context),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Отменить',
                  style: kTitle2TextStyle2,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 90.0, left: 15.0, right: 15.0),
          child: TextField(
            controller: _controller,
            onChanged: (titleCollectionsEdit) {
              context
                  .read<CollectionItemEditPageModel>()
                  .setTitleCollectionsEdit(titleCollectionsEdit);
            },
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
        '${context.read<CollectionsItemPageModel>().getSubTitle}';
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
        onChanged: (subTitleCollectionsEdit) {
          Provider.of<CollectionItemEditPageModel>(context, listen: false)
              .setSubTitleCollectionsEdit(subTitleCollectionsEdit);
        },
        decoration: const InputDecoration(
          border: InputBorder.none,
        ),
        style: const TextStyle(
          fontSize: 16.0,
        ),
        textAlign: TextAlign.start,
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
      popupMenu: const Padding(
        padding: EdgeInsets.only(right: 16.0),
        child: Icon(
          Icons.more_horiz,
          color: AppColor.colorText,
          size: 40.0,
        ),
      ));
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
                  padding: const EdgeInsets.only(bottom: 0.0),
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
