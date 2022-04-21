import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memory_box/models/view_model.dart';
import 'package:memory_box/pages/collections_pages/collection/collection.dart';
import 'package:memory_box/pages/profile_pages/profile_page/profile.dart';
import 'package:memory_box/resources/app_colors.dart';
import 'package:memory_box/resources/app_icons.dart';
import 'package:provider/provider.dart';
import '../../Blocs/navigation_bloc/navigation__bloc.dart';
import '../../Blocs/navigation_bloc/navigation__event.dart';
import '../../Blocs/navigation_bloc/navigation__state.dart';
import '../../pages/audio_recordings_page/audio_recordings_page.dart';
import '../../pages/delete_pages/delete_page.dart';
import '../../pages/home_page/home_page.dart';
import '../../pages/search_page/search_page.dart';
import '../../pages/subscription_page/subscription_page.dart';
import '../../pages/support_message_page/support_message_page.dart';
import '../../utils/constants.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({Key? key}) : super(key: key);

  void _navigateToPage(
    BuildContext context, {
    required int index,
    required int currentIndex,
    required String route,
  }) {
    Navigator.pop(context);

    if (index != currentIndex) {
      context.read<NavigationBloc>().add(
            NavigateMenu(
              menuIndex: index,
              route: route,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        return ClipRRect(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          ),
          child: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Center(
                    child: Column(
                      children: const [
                        SizedBox(
                          height: 40.0,
                        ),
                        Text(
                          'Аудиосказки',
                          style: TextStyle(
                            fontSize: 24.0,
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          'Меню',
                          style: TextStyle(
                            fontSize: 24.0,
                            color: AppColor.colorText50,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextButton(
                        title: 'Главная',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: state.currentIndex == 0
                              ? AppColor.colorText50
                              : AppColor.colorText,
                          fontWeight: FontWeight.w500,
                        ),
                        onTap: () => _navigateToPage(
                          context,
                          route: HomePage.routeName,
                          currentIndex: state.currentIndex,
                          index: 0,
                        ),
                        image: AppIcons.tabbar_home,
                        color: state.currentIndex == 0
                            ? AppColor.colorText50
                            : AppColor.colorText,
                      ),
                      CustomTextButton(
                        title: 'Профиль',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: state.currentIndex == 4
                              ? AppColor.colorText50
                              : AppColor.colorText,
                          fontWeight: FontWeight.w500,
                        ),
                        onTap: () => _navigateToPage(
                          context,
                          route: Profile.routeName,
                          currentIndex: state.currentIndex,
                          index: 4,
                        ),
                        image: AppIcons.tabbar_profile,
                        color: state.currentIndex == 4
                            ? AppColor.colorText50
                            : AppColor.colorText,
                      ),
                      CustomTextButton(
                        title: 'Подборки',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: state.currentIndex == 1
                              ? AppColor.colorText50
                              : AppColor.colorText,
                          fontWeight: FontWeight.w500,
                        ),
                        onTap: () => _navigateToPage(
                          context,
                          route: Collections.routeName,
                          currentIndex: state.currentIndex,
                          index: 1,
                        ),
                        image: AppIcons.tabbar_category,
                        color: state.currentIndex == 1
                            ? AppColor.colorText50
                            : AppColor.colorText,
                      ),
                      CustomTextButton(
                        title: 'Все аудеофайлы',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: state.currentIndex == 3
                              ? AppColor.colorText50
                              : AppColor.colorText,
                          fontWeight: FontWeight.w500,
                        ),
                        onTap: () => _navigateToPage(
                          context,
                          route: AudioRecordingsPage.routeName,
                          currentIndex: state.currentIndex,
                          index: 3,
                        ),
                        image: AppIcons.tabbar_paper,
                        color: state.currentIndex == 3
                            ? AppColor.colorText50
                            : AppColor.colorText,
                      ),
                      CustomTextButton(
                        title: 'Поиск',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: state.currentIndex == 6
                              ? AppColor.colorText50
                              : AppColor.colorText,
                          fontWeight: FontWeight.w500,
                        ),
                        onTap: () => _navigateToPage(
                          context,
                          route: SearchPage.routeName,
                          currentIndex: state.currentIndex,
                          index: 6,
                        ),
                        image: AppIcons.drawer_search,
                        color: state.currentIndex == 6
                            ? AppColor.colorText50
                            : AppColor.colorText,
                      ),
                      CustomTextButton(
                        title: 'Недавно удальонные',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: state.currentIndex == 5
                              ? AppColor.colorText50
                              : AppColor.colorText,
                          fontWeight: FontWeight.w500,
                        ),
                        onTap: () => _navigateToPage(
                          context,
                          route: DeletePage.routeName,
                          currentIndex: state.currentIndex,
                          index: 5,
                        ),
                        image: AppIcons.delete,
                        color: state.currentIndex == 5
                            ? AppColor.colorText50
                            : AppColor.colorText,
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      CustomTextButton(
                        title: 'Подписка',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: state.currentIndex == 7
                              ? AppColor.colorText50
                              : AppColor.colorText,
                          fontWeight: FontWeight.w500,
                        ),
                        onTap: () => _navigateToPage(
                          context,
                          route: SubscriptionPage.routeName,
                          currentIndex: state.currentIndex,
                          index: 7,
                        ),
                        image: AppIcons.drawer_wallet,
                        color: state.currentIndex == 7
                            ? AppColor.colorText50
                            : AppColor.colorText,
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      CustomTextButton(
                        title: 'Написать в \n поддержку',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: state.currentIndex == 8
                              ? AppColor.colorText50
                              : AppColor.colorText,
                          fontWeight: FontWeight.w500,
                        ),
                        onTap: () => _navigateToPage(
                          context,
                          route: SupportMessagePage.routeName,
                          currentIndex: state.currentIndex,
                          index: 8,
                        ),
                        image: AppIcons.drawer_edit,
                        color: state.currentIndex == 8
                            ? AppColor.colorText50
                            : AppColor.colorText,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    Key? key,
    required this.title,
    this.style,
    required this.onTap,
    required this.image,
    this.color,
  }) : super(key: key);

  final String title;
  final String image;
  final TextStyle? style;
  final Color? color;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 5.0,
          horizontal: 10.0,
        ),
        child: Row(
          children: [
            SizedBox(
              height: 23.0,
              width: 23.0,
              child: Image.asset(
                image,
                fit: BoxFit.fill,
                color: color,
              ),
            ),
            const SizedBox(
              width: 10.0,
            ),
            Text(
              title,
              style: style,
            ),
          ],
        ),
      ),
    );
  }
}
