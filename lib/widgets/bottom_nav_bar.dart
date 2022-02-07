import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/pages/home_page.dart';
import 'package:memory_box/pages/play_page.dart';
import 'package:memory_box/pages/podborki_page/podborki.dart';
import 'package:memory_box/pages/profile_page/profile.dart';
import 'package:memory_box/pages/recordings_page/record_page.dart';
import 'package:memory_box/resources/app_icons.dart';
import 'package:memory_box/resources/constants.dart';
import 'package:memory_box/pages/audio_recordings_page.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 65.0,
      decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade500,
                offset: const Offset(0.0, 0.0),
                blurRadius: 10.0,
                spreadRadius: 1.0),
          ]),
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _ItemBar(
              name: 'Главная',
              icon: Image.asset(
                AppIcons.tabbar_home,
                width: 20.0,
                height: 20.0,
              ),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  HomePage.rootName,
                );
              },
            ),
            _ItemBar(
              name: 'Подбoрки',
              icon: Image.asset(
                AppIcons.tabbar_category,
              ),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  Podborki.rootName,
                );
              },
            ),
            _ItemBar(
              name: 'Запись',
              icon: Image.asset(AppIcons.tabbar_componen),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  RecordPage.rootName,
                );
              },
            ),
            _ItemBar(
              name: 'Аудиозаписи',
              icon: Image.asset(AppIcons.tabbar_paper),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  AudioRecordingsPage.rootName,
                );
              },
            ),
            _ItemBar(
              name: 'Профиль',
              icon: Image.asset(AppIcons.tabbar_profile),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  Profile.rootName,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _ItemBar extends StatelessWidget {
  const _ItemBar(
      {Key? key, required this.name, required this.icon, this.onPressed})
      : super(key: key);
  final String name;
  final Image icon;
  final onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: onPressed,
          icon: icon,
          padding: EdgeInsets.all(2.0),
          splashRadius: 40.0,
        ),
        Text(
          name,
          style: kBottombarTextStyle,
        ),
      ],
    );
  }
}
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:memory_box/pages/home_page.dart';
// import 'package:memory_box/pages/play_page.dart';
// import 'package:memory_box/pages/podborki_page/podborki.dart';
// import 'package:memory_box/pages/profile_page/profile.dart';
// import 'package:memory_box/pages/recordings_page/record_page.dart';
// import 'package:memory_box/resources/app_colors.dart';
// import 'package:memory_box/resources/app_icons.dart';
// import 'package:memory_box/resources/constants.dart';
// import 'package:memory_box/pages/audio_recordings_page.dart';
//
// class BottomNavBar extends StatefulWidget {
//   const BottomNavBar({Key? key}) : super(key: key);
//
//   @override
//   State<BottomNavBar> createState() => _BottomNavBarState();
// }
//
// class _BottomNavBarState extends State<BottomNavBar> {
//   int _selectedIndex = 0;
//   // final screen = [
//   //   Navigator.pushNamed(context, HomePage.rootName),
//   //   Navigator.pushNamed(context, Podborki.rootName),
//   //   Navigator.pushNamed(context, RecordPage.rootName),
//   //   Navigator.pushNamed(context, AudioRecordingsPage.rootName),
//   //   Navigator.pushNamed(context, Profile.rootName),
//   // ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       height: 65.0,
//       decoration: BoxDecoration(
//           color: Colors.grey[100],
//           borderRadius: const BorderRadius.only(
//             topLeft: Radius.circular(20.0),
//             topRight: Radius.circular(20.0),
//           ),
//           boxShadow: [
//             BoxShadow(
//                 color: Colors.grey.shade500,
//                 offset: const Offset(0.0, 0.0),
//                 blurRadius: 10.0,
//                 spreadRadius: 1.0),
//           ]),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           _ItemBar(
//             name: 'Главная',
//             icon: AppIcons.tabbar_home,
//             // onPressed: () {
//             //   Navigator.pushNamed(
//             //     context,
//             //     HomePage.rootName,
//             //   );
//             // },
//             isActive: false,
//             index: 0,
//           ),
//           _ItemBar(
//             name: 'Подбoрки',
//             icon: AppIcons.tabbar_category,
//             // onPressed: () {
//             //   Navigator.pushNamed(
//             //     context,
//             //     Podborki.rootName,
//             //   );
//             // },
//             isActive: false,
//             index: 1,
//           ),
//           _ItemBar(
//             name: 'Запись',
//             icon: AppIcons.tabbar_componen,
//             // onPressed: () {
//             //   Navigator.pushNamed(
//             //     context,
//             //     RecordPage.rootName,
//             //   );
//             // },
//             isActive: false,
//             index: 2,
//           ),
//           _ItemBar(
//             name: 'Аудиозаписи',
//             icon: AppIcons.tabbar_paper,
//             // onPressed: () {
//             //   Navigator.pushNamed(
//             //     context,
//             //     AudioRecordingsPage.rootName,
//             //   );
//             isActive: true,
//             index: 3,
//           ),
//           _ItemBar(
//             name: 'Профиль',
//             icon: AppIcons.tabbar_profile,
//             // onPressed: () {
//             //   Navigator.pushNamed(
//             //     context,
//             //     Profile.rootName,
//             //   );
//             // },
//             isActive: false,
//             index: 4,
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _ItemBar({
//     required String name,
//     required String icon,
//     required bool isActive,
//     required int index,
//   }) {
//     return Container(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           IconButton(
//             onPressed: () {
//               setState(() {
//                 _selectedIndex = index;
//               });
//             },
//             icon: Image.asset(
//               icon,
//               color: index == _selectedIndex
//                   ? AppColor.colorAppbar
//                   : AppColor.colorText,
//             ),
//           ),
//           Text(
//             name,
//             style: kBottombarTextStyle,
//           ),
//         ],
//       ),
//     );
//   }
// }
