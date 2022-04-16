import 'package:flutter/material.dart';
import 'package:memory_box/resources/app_colors.dart';
import 'package:memory_box/resources/app_icons.dart';
import 'package:memory_box/utils/constants.dart';
import 'package:memory_box/widgets/appbar_clipper.dart';
import 'package:provider/src/provider.dart';

import '../search_page_model.dart';

class AppbarHeaderSearchPage extends StatelessWidget {
  const AppbarHeaderSearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(),
        ClipPath(
          clipper: AppbarClipper(),
          child: Container(
            color: AppColor.colorAppbar,
            width: double.infinity,
            height: 160.0,
          ),
        ),
        const Align(
          alignment: Alignment.center,
          child: Text(
            'Найди потеряшку',
            style: kTitle2TextStyle2,
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
      padding: const EdgeInsets.only(left: 20.0, top: 61.0, right: 12.0),
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
                          .read<SearchPageModel>()
                          .setSearchData(text.toLowerCase());
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
