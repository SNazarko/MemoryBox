import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/pages/save_page/save_page_model.dart';
import 'package:memory_box/repositories/audio_repositories.dart';
import 'package:memory_box/resources/app_colors.dart';
import 'package:memory_box/widgets/appbar_clipper.dart';
import 'package:memory_box/widgets/player_big.dart';
import 'package:provider/provider.dart';

import '../../resources/constants.dart';

class SavePage extends StatelessWidget {
  SavePage({
    Key? key,
    required this.image,
    required this.url,
    required this.duration,
    required this.name,
  }) : super(key: key);
  static const routeName = '/save_page';
  final String name;
  final String image;
  final String url;
  final String duration;

  Widget? photoCollections(double screenWidth, double screenHeight) {
    if (image == '') {
      return SizedBox(
        height: screenHeight * 0.35,
      );
    } else {
      return ClipRRect(
        borderRadius: const BorderRadius.all(
          Radius.circular(20.0),
        ),
        child: SizedBox(
          width: screenWidth * 0.8,
          height: screenHeight * 0.35,
          child: Image.network(
            image,
            fit: BoxFit.fill,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(
              children: [
                Container(
                  height: screenHeight * 0.905,
                ),
                ClipPath(
                  clipper: AppbarClipper(),
                  child: Container(
                    color: AppColor.colorAppbar,
                    width: double.infinity,
                    height: 250.0,
                  ),
                ),
                Positioned(
                  left: 5.0,
                  top: 40.0,
                  child: Container(
                    height: 900.0,
                    width: screenWidth * 0.97,
                    decoration: kBorderContainer2,
                    child: Column(
                      children: [
                        CancelDoneSavePage(),
                        photoCollections(
                          screenWidth,
                          screenHeight,
                        )!,
                        const SizedBox(
                          height: 30.0,
                        ),
                        RenameAudioSavePage(),
                        const SizedBox(
                          height: 30.0,
                        ),
                        PlayerBig(
                          url: url,
                          duration: duration,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CancelDoneSavePage extends StatelessWidget {
  CancelDoneSavePage({Key? key}) : super(key: key);
  final AudioRepositories repositories = AudioRepositories();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Отменить',
                style: kTitle3TextStyle3,
              )),
          TextButton(
              onPressed: () {
                repositories.renameAudio(
                  Provider.of<SavePageModel>(context, listen: false)
                      .getAudioName,
                  Provider.of<SavePageModel>(context, listen: false)
                      .getNewAudioName,
                  Provider.of<SavePageModel>(context, listen: false)
                      .getAudioUrl,
                  Provider.of<SavePageModel>(context, listen: false)
                      .getDuration,
                  Provider.of<SavePageModel>(context, listen: false)
                      .getDateTime,
                  Provider.of<SavePageModel>(context, listen: false)
                      .getSearchName,
                  Provider.of<SavePageModel>(context, listen: false).getDone,
                );
                Navigator.pop(context);
              },
              child: const Text(
                'Готово',
                style: kTitle3TextStyle3,
              )),
        ],
      ),
    );
  }
}

class RenameAudioSavePage extends StatelessWidget {
  RenameAudioSavePage({Key? key}) : super(key: key);
  final Set searchName = {};

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20.0,
      width: 200.0,
      child: TextField(
        maxLines: 1,
        autofocus: true,
        onChanged: (value) {
          if (value != '') {
            final data = value.toLowerCase();
            searchName.add(data);
            if (data != searchName.last) {
              searchName.remove(searchName.last);
            }
            context.read<SavePageModel>().setNewAudioName(value);
            context.read<SavePageModel>().setSearchName(searchName.toList());
          } else {
            context.read<SavePageModel>().setNewAudioName(
                Provider.of<SavePageModel>(context, listen: false)
                    .getAudioName);
          }
        },
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 14.0,
          color: AppColor.colorText,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText:
              '${Provider.of<SavePageModel>(context, listen: false).getAudioName}',
          hintStyle: const TextStyle(
            fontSize: 14.0,
            color: AppColor.colorText,
          ),
        ),
      ),
    );
  }
}
