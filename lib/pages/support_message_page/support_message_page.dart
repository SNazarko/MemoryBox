import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memory_box/pages/support_message_page/widgets/appbar_menu_support_message_page.dart';
import 'package:memory_box/pages/support_message_page/widgets/support_message_page_list.dart';
import 'package:memory_box/pages/support_message_page/widgets/support_not_authorisation_page.dart';
import 'package:memory_box/pages/support_message_page/widgets/text_field_support_message_page.dart';
import 'package:memory_box/repositories/auth_repositories.dart';
import '../../repositories/user_repositories.dart';
import '../../utils/constants.dart';
import 'bloc/support_message/support_message_bloc.dart';

class SupportMessagePage extends StatelessWidget {
  const SupportMessagePage({Key? key}) : super(key: key);
  static const routeName = '/support_message_page';

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return BlocProvider<SupportMessageBloc>(
      create: (context) =>
          SupportMessageBloc()..add(const LoadSupportMessageEvent()),
      child: Scaffold(
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
                      child: AuthRepositories.instance.user == null
                          ? const SupportNotAuthorisationPage()
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
      ),
    );
  }
}
