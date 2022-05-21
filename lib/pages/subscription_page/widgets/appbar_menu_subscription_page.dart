import 'package:flutter/cupertino.dart';
import '../../../resources/app_colors.dart';
import '../../../widgets/uncategorized/appbar_clipper.dart';

class AppbarMenuSubscription extends StatelessWidget {
  const AppbarMenuSubscription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Container(
          height: screenHeight - 150.0,
        ),
        ClipPath(
          clipper: AppbarClipper(),
          child: Container(
            color: AppColor.colorAppbar,
            width: double.infinity,
            height: 200.0,
          ),
        ),
      ],
    );
  }
}
