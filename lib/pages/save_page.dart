import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/repositories/audio_repositories.dart';
import 'package:memory_box/resources/app_colors.dart';
import 'package:memory_box/widgets/appbar_clipper.dart';
import 'package:memory_box/widgets/player_big.dart';

import '../resources/constants.dart';

class SavePage extends StatelessWidget {
  SavePage({
    Key? key,
    required this.image,
    required this.url,
    required this.duration,
    required this.name,
  }) : super(key: key);
  static const routeName = '/save_page';
  final AudioRepositories repositories = AudioRepositories();
  final String name;
  final String image;
  final String url;
  final String duration;
  String? newName;

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
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
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
                                      name,
                                      newName!,
                                      url,
                                      duration,
                                    );
                                  },
                                  child: const Text(
                                    'Готово',
                                    style: kTitle3TextStyle3,
                                  ))
                            ],
                          ),
                        ),
                        photoCollections(
                          screenWidth,
                          screenHeight,
                        )!,
                        const SizedBox(
                          height: 30.0,
                        ),
                        SizedBox(
                          height: 20.0,
                          width: 200.0,
                          child: TextField(
                            maxLines: 1,
                            autofocus: true,
                            onChanged: (value) {
                              value = newName!;
                            },
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 14.0,
                              color: AppColor.colorText,
                            ),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: '  Название аудиозапи',
                              hintStyle: TextStyle(
                                fontSize: 14.0,
                                color: AppColor.colorText,
                              ),
                            ),
                          ),
                        ),
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
