import 'package:flutter/cupertino.dart';
import '../../../resources/app_colors.dart';
import '../../../resources/constants.dart';
import '../../../widgets/appbar_clipper.dart';

class AppbarHeaderDeletePage extends StatelessWidget {
  const AppbarHeaderDeletePage({
    Key? key,
  }) : super(key: key);

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
            height: 125.0,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'удаленные',
              style: kTitleTextStyle2,
            ),
          ],
        ),
      ],
    );
  }
}
