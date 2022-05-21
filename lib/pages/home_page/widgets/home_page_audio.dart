import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memory_box/pages/home_page/widgets/popup_menu_home_page.dart';
import 'package:memory_box/utils/constants.dart';
import '../../../Blocs/navigation_bloc/navigation__bloc.dart';
import '../../../Blocs/navigation_bloc/navigation__state.dart';
import '../../../blocs/list_item_bloc/list_item_bloc.dart';
import '../../../resources/app_colors.dart';
import '../../../widgets/navigation/navigate_to_page.dart';
import '../../../widgets/player/player_mini/player_mini.dart';
import '../../audio_recordings_page/audio_recordings_page.dart';

class HomePageAudio extends StatelessWidget {
  const HomePageAudio({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.grey.shade300,
              offset: const Offset(
                0.0,
                -5.0,
              ),
              blurRadius: 10.0,
            )
          ]),
      child: Container(
        decoration: kBorderContainer2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            Expanded(
              flex: 1,
              child: _TitleAudioList(),
            ),
            Expanded(
              flex: 5,
              child: _AudioList(),
            )
          ],
        ),
      ),
    );
  }
}

class _AudioList extends StatelessWidget {
  const _AudioList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child:
          BlocBuilder<ListItemBloc, ListItemState>(builder: (context, state) {
        if (state.status == ListItemStatus.emptyList) {
          return const Padding(
            padding: EdgeInsets.symmetric(
              vertical: 50.0,
              horizontal: 40.0,
            ),
            child: Text(
              'Как только ты запишешь аудио, она появится здесь.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.0,
                color: AppColor.colorText50,
              ),
            ),
          );
        }
        if (state.status == ListItemStatus.success) {
          return ListView.builder(
            padding: const EdgeInsets.only(
              bottom: 75.0,
            ),
            itemCount: state.list.length,
            itemBuilder: (BuildContext context, int index) {
              final audio = state.list[index];
              return PlayerMini(
                duration: '${audio.duration}',
                url: '${audio.audioUrl}',
                name: '${audio.audioName}',
                done: audio.done!,
                id: '${audio.id}',
                collection: audio.collections!,
                popupMenu: PopupMenuHomePage(
                  url: '${audio.audioUrl}',
                  duration: '${audio.duration}',
                  name: '${audio.audioName}',
                  image: '',
                  done: audio.done!,
                  searchName: audio.searchName!,
                  dateTime: audio.dateTime!,
                  idAudio: '${audio.id}',
                  collection: audio.collections!,
                ),
              );
            },
          );
        }
        if (state.status == ListItemStatus.initial) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state.status == ListItemStatus.failed) {
          return const Center(
            child: Text(
              'Ой: сталася помилка!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.0,
                color: AppColor.colorText50,
              ),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      }),
    );
  }
}

class _TitleAudioList extends StatelessWidget {
  const _TitleAudioList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Аудиозаписи',
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
              GestureDetector(
                onTap: () => NavigateToPage.instance?.navigate(context,
                    index: 3,
                    currentIndex: state.currentIndex,
                    route: AudioRecordingsPage.routeName),
                child: const Text(
                  'Открыть все',
                  style: TextStyle(
                    fontSize: 14.0,
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
