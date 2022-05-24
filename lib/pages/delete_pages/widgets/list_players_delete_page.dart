import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../blocs/list_item_bloc/list_item_bloc.dart';
import '../../../resources/app_colors.dart';
import '../../../widgets/player/player_mini/player_mini.dart';
import '../bloc/delete_item_done_cubit/delete_item_done.dart';
import 'icon_delene_audio.dart';
import 'icon_done_delete.dart';

class ListPlayersDeletePage extends StatelessWidget {
  const ListPlayersDeletePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        SizedBox(
          height: screenHeight - (kBottomNavigationBarHeight + 88.0),
          child: BlocBuilder<DeleteItemDoneCubit, bool>(
            builder: (_, stateDone) {
              return BlocBuilder<ListItemBloc, ListItemState>(
                builder: (context, state) {
                  if (state.status == ListItemStatus.emptyList) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 50.0,
                        horizontal: 40.0,
                      ),
                      child: Center(
                        child: Text(
                          'Вы еще ничего \n     не удалили',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: AppColor.colorText50,
                          ),
                        ),
                      ),
                    );
                  }
                  if (state.status == ListItemStatus.initial) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state.status == ListItemStatus.success) {
                    return ListView.builder(
                      padding: const EdgeInsets.only(
                        top: 130.0,
                        bottom: 0,
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
                          popupMenu: stateDone
                              ? IconDoneDelete(
                                  done: audio.done!,
                                  id: '${audio.id}',
                                )
                              : IconDeleteAudio(
                                  idAudio: '${audio.id}',
                                  size: audio.size ?? 0,
                                ),
                        );
                      },
                    );
                  }
                  if (state.status == ListItemStatus.failed) {
                    return const Center(
                      child: Text('Ой: сталася помилка!'),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
