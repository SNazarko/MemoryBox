import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:memory_box/pages/collections_pages/collections/widgets/appbar_header_profile.dart';
import 'package:memory_box/pages/profile_page/data_model_user.dart';
import 'package:memory_box/models/preferences_data_model_user.dart';
import 'package:memory_box/pages/profile_page/profile_page/widgets/appbar_header_profile.dart';
import 'package:memory_box/pages/profile_page/profile_page/widgets/delete_account.dart';
import 'package:memory_box/pages/profile_page/profile_page/widgets/name_and_number.dart';
import 'package:memory_box/pages/profile_page/profile_page/widgets/photo_profile.dart';
import 'package:memory_box/pages/profile_page/profile_page/widgets/progress_indicator.dart';
import 'package:memory_box/repositories/user_repositories.dart';
import 'package:memory_box/resources/app_colors.dart';
import 'package:memory_box/pages/profile_page/profile_edit.dart';
import 'package:memory_box/widgets/appbar_clipper.dart';
import 'package:memory_box/widgets/container_shadow.dart';
import 'package:memory_box/widgets/text_link.dart';
import 'package:provider/provider.dart';
import '../../../resources/constants.dart';

class Profile extends StatelessWidget {
  Profile({Key? key}) : super(key: key);
  static const routeName = '/profile';
  final DataModel model = DataModel();
  final _auth = FirebaseAuth.instance;
  final UserRepositories _repositories = UserRepositories();

  static Widget create() {
    return Profile();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          icon: const Icon(Icons.menu),
        ),
        elevation: 0.0,
        centerTitle: true,
        title: const Text(
          'Профиль',
          style: kTitleTextStyle2,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(
              children: const [
                AppbarHeaderProfileProfile(),
                PhotoProfileProfile(),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                NameAndNumber(screenWidth: screenWidth * 0.75),
                TextLink(
                  onPressed: () {
                    Navigator.pushNamed(context, ProfileEdit.routeName);
                  },
                  text: 'Редактировать',
                ),
                const SizedBox(
                  height: 40.0,
                ),
                TextLink(
                  onPressed: () {},
                  underline: false,
                  text: 'Подписка',
                ),
                const SizedBox(
                  height: 15.0,
                ),
                const CustomProgressIndicator(),
                const SizedBox(
                  height: 25.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextLink(
                        text: 'Вийти из приложения',
                        onPressed: () async {
                          await _auth.signOut();
                          exit(0);
                        },
                      ),
                      DeleteAccount(),
                    ],
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
