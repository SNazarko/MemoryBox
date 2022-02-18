import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/models/collections_model.dart';
import 'package:memory_box/pages/podborki_page/podborki/widgets/appbar_header_profile.dart';
import 'package:memory_box/pages/podborki_page/podborki/widgets/list_podborki.dart';
import 'package:memory_box/widgets/bottom_nav_bar.dart';

class Podborki extends StatelessWidget {
  const Podborki({Key? key}) : super(key: key);
  static const rootName = '/podborki';
  static Widget create() {
    return const Podborki();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomNavBar(),
      body: SafeArea(
        child: Stack(
          children: [
            const AppbarHeaderProfile(),
            listPodborki(),
          ],
        ),
      ),
    );
  }
}
