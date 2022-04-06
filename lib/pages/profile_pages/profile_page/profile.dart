import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/pages/profile_pages/profile_model.dart';
import 'package:memory_box/pages/profile_pages/profile_page/widgets/appbar_header_profile.dart';
import 'package:memory_box/pages/profile_pages/profile_page/widgets/delete_account.dart';
import 'package:memory_box/pages/profile_pages/profile_page/widgets/name_and_number.dart';
import 'package:memory_box/pages/profile_pages/profile_page/widgets/photo_profile.dart';
import 'package:memory_box/pages/profile_pages/profile_page/widgets/progress_indicator.dart';
import 'package:memory_box/pages/profile_pages/profile_edit_page/profile_edit_page.dart';
import 'package:memory_box/widgets/text_link.dart';
import 'package:provider/provider.dart';
import '../../../models/user_model.dart';
import '../../../models/view_model.dart';
import '../../../repositories/user_repositories.dart';
import '../../../resources/app_colors.dart';
import '../../../resources/constants.dart';

class Profile extends StatelessWidget {
  Profile({Key? key}) : super(key: key);
  static const routeName = '/profile';
  final DataModel model = DataModel();
  final UserRepositories rep = UserRepositories();

  static Widget create() {
    return Profile();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

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
            rep.user == null
                ? _LinksNotAuthorization(
                    screenWidth: screenWidth,
                  )
                : _Links(
                    screenWidth: screenWidth,
                  ),
          ],
        ),
      ),
    );
  }
}

class _Links extends StatelessWidget {
  _Links({Key? key, required this.screenWidth}) : super(key: key);
  final UserRepositories repositoriesUser = UserRepositories();
  final _auth = FirebaseAuth.instance;
  final double screenWidth;
  Widget buildUser(UserModel model) => CustomProgressIndicator(
        size: model.totalSize ?? 0,
      );

  @override
  Widget build(BuildContext context) {
    return Column(
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
          onPressed: () {
            Provider.of<Navigation>(context, listen: false).setCurrentIndex = 7;
          },
          underline: false,
          text: 'Подписка',
        ),
        const SizedBox(
          height: 15.0,
        ),
        StreamBuilder<List<UserModel>>(
          stream: repositoriesUser.readUser(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return CustomProgressIndicator(
                size: 150,
              );
            }
            if (snapshot.hasData) {
              final user = snapshot.data!;
              if (user.map(buildUser).toList().isNotEmpty) {
                return Container(
                  child: user.map(buildUser).toList().single,
                );
              } else {
                return CustomProgressIndicator(
                  size: 150,
                );
              }
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
        const SizedBox(
          height: 15.0,
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
    );
  }
}

class _LinksNotAuthorization extends StatelessWidget {
  _LinksNotAuthorization({Key? key, required this.screenWidth})
      : super(key: key);
  final _auth = FirebaseAuth.instance;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Column(
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
          onPressed: () {
            Provider.of<Navigation>(context, listen: false).setCurrentIndex = 7;
          },
          underline: false,
          text: 'Подписка',
        ),
        const SizedBox(
          height: 15.0,
        ),
        CustomProgressIndicator(
          size: 150,
        ),
        const SizedBox(
          height: 15.0,
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
    );
  }
}
