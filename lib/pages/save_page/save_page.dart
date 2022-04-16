import 'package:flutter/material.dart';
import 'package:memory_box/pages/save_page/widgets/cancel_done_save_page.dart';
import 'package:memory_box/pages/save_page/widgets/rename_audio_save_page.dart';
import 'package:memory_box/resources/app_colors.dart';
import 'package:memory_box/widgets/appbar_clipper.dart';
import 'package:memory_box/widgets/player_big.dart';

import '../../utils/constants.dart';

class SavePage extends StatelessWidget {
  const SavePage({
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
