import 'package:flutter/material.dart';
import 'package:memory_box/pages/save_page/save_page_model.dart';
import 'package:memory_box/pages/save_page/widgets/cancel_done_save_page.dart';
import 'package:memory_box/pages/save_page/widgets/rename_audio_save_page.dart';
import 'package:memory_box/resources/app_colors.dart';
import 'package:memory_box/widgets/player/player_big.dart';
import 'package:provider/provider.dart';

import '../../utils/constants.dart';
import '../../widgets/uncategorized/appbar_clipper.dart';

class SavePageArguments {
  SavePageArguments(
    this.idAudio,
    this.audioName,
    this.audioImage,
    this.audioUrl,
    this.audioDuration,
    this.audioDone,
    this.audioTime,
    this.audioSearchName,
    this.audioCollection,
  );
  final String idAudio;
  final String audioName;
  final String audioImage;
  final String audioUrl;
  final String audioDuration;
  final bool audioDone;
  final String audioTime;
  final List audioSearchName;
  final List audioCollection;
}

class SavePage extends StatelessWidget {
  const SavePage({
    Key? key,
    required this.audioImage,
    required this.audioUrl,
    required this.audioDuration,
    required this.audioName,
    required this.idAudio,
    required this.audioDone,
    required this.audioTime,
    required this.audioSearchName,
    required this.audioCollection,
  }) : super(key: key);
  static const routeName = '/save_page';
  final String idAudio;
  final String audioName;
  final String audioImage;
  final String audioUrl;
  final String audioDuration;
  final bool audioDone;
  final String audioTime;
  final List audioSearchName;
  final List audioCollection;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SavePageModel>(
        create: (BuildContext context) => SavePageModel(),
        child: SavePageCreate(
          audioName: audioName,
          audioDuration: audioDuration,
          audioSearchName: audioSearchName,
          audioDone: audioDone,
          audioImage: audioImage,
          audioUrl: audioUrl,
          idAudio: idAudio,
          audioCollection: audioCollection,
          audioTime: audioTime,
        ));
  }
}

class SavePageCreate extends StatelessWidget {
  const SavePageCreate({
    Key? key,
    required this.idAudio,
    required this.audioName,
    required this.audioImage,
    required this.audioUrl,
    required this.audioDuration,
    required this.audioDone,
    required this.audioTime,
    required this.audioSearchName,
    required this.audioCollection,
  }) : super(key: key);
  final String idAudio;
  final String audioName;
  final String audioImage;
  final String audioUrl;
  final String audioDuration;
  final bool audioDone;
  final String audioTime;
  final List audioSearchName;
  final List audioCollection;
  Widget? photoCollections(double screenWidth, double screenHeight) {
    if (audioImage == '') {
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
            audioImage,
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
                        CancelDoneSavePage(
                          audioUrl: audioUrl,
                          audioDone: audioDone,
                          audioCollection: audioCollection,
                          idAudio: idAudio,
                          audioName: audioName,
                          audioDuration: audioDuration,
                          audioTime: audioTime,
                          audioSearchName: audioSearchName,
                        ),
                        photoCollections(
                          screenWidth,
                          screenHeight,
                        )!,
                        const SizedBox(
                          height: 30.0,
                        ),
                        RenameAudioSavePage(
                          audioName: audioName,
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        PlayerBig(
                          url: audioUrl,
                          duration: audioDuration,
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
