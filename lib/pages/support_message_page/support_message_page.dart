import 'package:flutter/material.dart';
import 'package:memory_box/pages/support_message_page/widgets/appbar_menu_support_message_page.dart';
import 'package:memory_box/pages/support_message_page/widgets/support_message_page_list.dart';
import 'package:memory_box/pages/support_message_page/widgets/text_field_support_message_page.dart';
import '../../repositories/user_repositories.dart';
import '../../resources/constants.dart';
import '../subscription_page/widgets/subscription_not_authorisation.dart';

class SupportMessagePage extends StatelessWidget {
  SupportMessagePage({Key? key}) : super(key: key);
  static const routeName = '/support_message_page';
  final UserRepositories rep = UserRepositories();

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
        title: const Text(
          'Поддержка',
          style: kTitleTextStyle2,
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(
              children: [
                const AppbarMenuSupportMessagePage(),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    height: screenHeight - 160.0,
                    width: screenWidth * 0.975,
                    decoration: kBorderContainer2,
                    child: rep.user == null
                        ? const SubscriptionNotAuthorisation()
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const SupportMessagePageList(),
                              TextFieldSupportMessagePage(),
                            ],
                          ),
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
