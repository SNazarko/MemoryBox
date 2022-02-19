import 'package:flutter/cupertino.dart';
import 'package:memory_box/resources/app_colors.dart';
import 'package:memory_box/resources/constants.dart';
import 'package:memory_box/widgets/appbar_clipper.dart';

class AppbarHeaderProfileProfile extends StatelessWidget {
  const AppbarHeaderProfileProfile({Key? key}) : super(key: key);

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
            height: 200.0,
          ),
        ),
        const Align(
          alignment: Alignment.center,
          child: Text(
            'Твоя частичка',
            style: kTitle2TextStyle2,
          ),
        ),
      ],
    );
  }
}
