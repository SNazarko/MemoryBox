import 'package:flutter/material.dart';
import 'package:memory_box/pages/search_page/search_page_model.dart';
import 'package:memory_box/resources/app_colors.dart';
import 'package:memory_box/resources/app_icons.dart';
import 'package:memory_box/utils/constants.dart';
import 'package:memory_box/widgets/button/icon_back.dart';
import 'package:provider/src/provider.dart';

import '../../../../widgets/uncategorized/appbar_clipper.dart';
import '../collections_add_audio_model.dart';

class AppbarHeaderCollectionAddAudio extends StatelessWidget {
  const AppbarHeaderCollectionAddAudio({Key? key}) : super(key: key);

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
            height: 220.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15, top: 15),
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
                  'Выбрать',
                  style: kTitleTextStyle2,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: Text(
                    'Добавить',
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                        color: AppColor.white100),
                  ),
                ),
              ),
            ],
          ),
        ),
        const _SearchPanel(),
      ],
    );
  }
}

class _SearchPanel extends StatelessWidget {
  const _SearchPanel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, top: 121.0, right: 12.0),
      child: Container(
        height: 60.0,
        decoration: const BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 29),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                  width: screenWidth * 0.65,
                  child: TextField(
                    onChanged: (searchTxt) {
                      var text = searchTxt;
                      context
                          .read<CollectionsAddAudioModel>()
                          .setSearchAddAudio(text.toLowerCase());
                    },
                    style: const TextStyle(
                      fontSize: 20.0,
                      color: AppColor.colorText,
                    ),
                    decoration: const InputDecoration(
                      hintText: 'Поиск',
                      hintStyle: TextStyle(
                        fontSize: 20.0,
                        color: AppColor.colorText50,
                      ),
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                  )),
              GestureDetector(
                onTap: () {},
                child: Image.asset(
                  AppIcons.search,
                  color: AppColor.colorText,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
