import 'package:flutter/cupertino.dart';
import 'package:memory_box/resources/app_colors.dart';
import 'package:memory_box/resources/constants.dart';
import 'package:memory_box/widgets/appbar_clipper.dart';

class AppbarHeaderAuthorization extends StatelessWidget {
  const AppbarHeaderAuthorization({Key? key, this.title, this.subtitle})
      : super(key: key);
  final String? title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
        clipper: AppbarClipper(),
        child: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  title!,
                  style: kTitleTextStyle,
                ),
                Text(
                  subtitle!,
                  style: kTitle2TextStyle,
                )
              ],
            ),
          ),
          color: AppColor.colorAppbar,
          width: double.infinity,
          height: 285.0,
        ));
  }
}
