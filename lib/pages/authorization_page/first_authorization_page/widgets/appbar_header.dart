import 'package:flutter/cupertino.dart';
import 'package:memory_box/resources/app_colors.dart';
import 'package:memory_box/resources/constants.dart';
import 'package:memory_box/widgets/appbar_clipper.dart';

class AppbarHeader extends StatelessWidget {
  const AppbarHeader({Key? key}) : super(key: key);

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
                Container(
                  child: const Text(
                    'MemoryBox',
                    style: kTitleTextStyle,
                  ),
                ),
                const Text(
                  'Твой голос всегда рядом',
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
