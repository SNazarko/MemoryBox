import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/pages/home_page/widgets/appbar_header_home_page.dart';
import 'package:memory_box/pages/home_page/widgets/home_page_audio.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  static const routeName = '/home_page';

  static Widget create() {
    return const HomePage();
  }

  @override
  Widget build(BuildContext context) {
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
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: screenHeight * 0.89,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                flex: 8,
                child: AppbarHeaderHomePage(),
              ),
              Expanded(
                flex: 11,
                child: HomePageAudio(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
