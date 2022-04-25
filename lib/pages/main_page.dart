import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memory_box/pages/home_page/home_page.dart';
import 'package:memory_box/pages/profile_pages/profile_page/profile.dart';
import 'package:memory_box/pages/recordings_page/record_page.dart';
import 'package:memory_box/pages/search_page/search_page.dart';
import 'package:memory_box/pages/subscription_page/subscription_page.dart';
import 'package:memory_box/pages/support_message_page/support_message_page.dart';
import 'package:memory_box/routes/routes.dart';
import 'package:memory_box/widgets/navigation/bottom_nav_bar.dart';
import 'package:memory_box/widgets/navigation/drawer_menu.dart';
import '../Blocs/navigation_bloc/navigation__bloc.dart';
import '../Blocs/navigation_bloc/navigation__event.dart';
import '../Blocs/navigation_bloc/navigation__state.dart';
import 'audio_recordings_page/audio_recordings_page.dart';
import 'collections_pages/collection/collection.dart';
import 'delete_pages/delete_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);
  static const routeName = '/main';

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  static const List<String> _pages = [
    HomePage.routeName,
    Collections.routeName,
    RecordPage.routeName,
    AudioRecordingsPage.routeName,
    Profile.routeName,
    SearchPage.routeName,
    DeletePage.routeName,
    SupportMessagePage.routeName,
    SubscriptionPage.routeName,
  ];

  static final GlobalKey<NavigatorState> _navigatorKey =
      GlobalKey<NavigatorState>();
  void _onSelectMenu(String route) {
    if (_navigatorKey.currentState != null) {
      _navigatorKey.currentState!.pushNamedAndRemoveUntil(
        route,
        (_) => false,
      );
    }
  }

  void _onSelectTab(String route) {
    if (_navigatorKey.currentState != null) {
      _navigatorKey.currentState!.pushNamedAndRemoveUntil(
        route,
        (route) => false,
      );
    }
  }

  Future<bool> _onWillPop() async {
    final bool maybePop = await _navigatorKey.currentState!.maybePop();

    return !maybePop;
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NavigationBloc>(
          create: (_) => NavigationBloc(),
        ),
      ],
      child: BlocConsumer<NavigationBloc, NavigationState>(
        listener: (_, state) {
          if (state.status == NavigationStateStatus.menu) {
            _onSelectMenu(state.route);
          }

          if (state.status == NavigationStateStatus.tab) {
            _onSelectTab(state.route);
          }
        },
        builder: (context, state) {
          return WillPopScope(
            onWillPop: _onWillPop,
            child: Scaffold(
              body: Navigator(
                key: _navigatorKey,
                initialRoute: HomePage.routeName,
                onGenerateRoute: AppRouter.generateRoute,
              ),
              drawerEnableOpenDragGesture: false,
              drawer: const CustomDrawerMenu(),
              bottomNavigationBar: CustomBottomNavBar(
                currentTab: state.currentIndex,
                onSelect: (int index) {
                  if (state.currentIndex != index) {
                    context.read<NavigationBloc>().add(
                          NavigateTab(
                            tabIndex: index,
                            route: _pages[index],
                          ),
                        );
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

///////////////////////////////////
//   final bool? shouldPop = false;
// static final GlobalKey<NavigatorState> _globalKey =
//     GlobalKey<NavigatorState>();
// void globalKey(route) {
//   MainPage._globalKey.currentState?.pushReplacementNamed(route);
// }
//
// @override
// Widget build(BuildContext context) {
//   final int _currentIndex =
//       context.select((Navigation nc) => nc.currentIndex);
//
//   switch (_currentIndex) {
//     case 0:
//       globalKey(HomePage.routeName);
//
//       break;
//     case 1:
//       globalKey(Collections.routeName);
//
//       break;
//     case 2:
//       globalKey(RecordPage.routeName);
//
//       break;
//     case 3:
//       globalKey(AudioRecordingsPage.routeName);
//
//       break;
//     case 4:
//       globalKey(Profile.routeName);
//
//       break;
//     case 5:
//       globalKey(DeletePage.routeName);
//
//       break;
//     case 6:
//       globalKey(SearchPage.routeName);
//
//       break;
//
//     case 7:
//       globalKey(SubscriptionPage.routeName);
//
//       break;
//     case 8:
//       globalKey(SupportMessagePage.routeName);
//
//       break;
//
//     default:
//       globalKey(HomePage.routeName);
//       break;
//   }
//
//     return WillPopScope(
//       onWillPop: () async {
//         return shouldPop!;
//       },
//       child: Scaffold(
//         drawer: const DrawerMenu(),
//         extendBody: true,
//         body: Navigator(
//           initialRoute: HomePage.routeName,
//           key: MainPage._globalKey,
//           onGenerateRoute: AppRouter.generateRoute,
//         ),
//         bottomNavigationBar: const BottomNavBar(),
//       ),
//     );
//   }
// }
