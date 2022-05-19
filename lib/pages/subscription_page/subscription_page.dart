import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memory_box/pages/subscription_page/widgets/appbar_menu_subscription_page.dart';
import 'package:memory_box/pages/subscription_page/widgets/subscription_authorisation.dart';
import 'package:memory_box/pages/subscription_page/widgets/subscription_not_authorisation.dart';
import 'package:memory_box/repositories/auth_repositories.dart';
import '../../utils/constants.dart';
import 'bloc/subscription_page/subscription_page_bloc.dart';

class SubscriptionPage extends StatelessWidget {
  const SubscriptionPage({Key? key}) : super(key: key);
  static const routeName = '/subscription_page';
  final bool shouldPop = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SubscriptionPageBloc>(
      create: (context) => SubscriptionPageBloc()
        ..add(
          LoadSubscriptionPageEvent(),
        ),
      child: WillPopScope(
        onWillPop: () async {
          return shouldPop;
        },
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: const Icon(Icons.menu),
            ),
            title: const Text(
              'Подписка',
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
                    const AppbarMenuSubscription(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Расширь возможности',
                          style: kTitle2TextStyle2,
                        ),
                      ],
                    ),
                    AuthRepositories.instance.user == null
                        ? const SubscriptionNotAuthorisation()
                        : const SubscriptionAuthorisation()
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
