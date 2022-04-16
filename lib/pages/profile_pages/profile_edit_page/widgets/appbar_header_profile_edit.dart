import 'package:flutter/cupertino.dart';

import '../../../../resources/app_colors.dart';
import '../../../../utils/constants.dart';
import '../../../../widgets/appbar_clipper.dart';
import '../../../../widgets/icon_back.dart';

class AppbarHeaderProfileEdit extends StatelessWidget {
  const AppbarHeaderProfileEdit({Key? key}) : super(key: key);

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
            height: 280.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 30.0,
            left: 15.0,
            right: 10.0,
          ),
          child: IconBack(
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(
            top: 30.0,
            left: 10.0,
            right: 10.0,
          ),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              'Профиль',
              style: kTitleTextStyle2,
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(
            top: 75.0,
          ),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              'Твоя частичка',
              style: kTitle2TextStyle2,
            ),
          ),
        ),
      ],
    );
  }
}
