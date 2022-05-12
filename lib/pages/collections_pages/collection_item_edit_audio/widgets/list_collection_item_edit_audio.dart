import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../blocs/list_item_bloc/list_item_bloc.dart';
import '../../../../resources/app_colors.dart';
import '../../../../widgets/player/player_mini/player_mini.dart';
import 'done_collection_item_edit_audio.dart';

class ListCollectionItemEditAudio extends StatelessWidget {
  const ListCollectionItemEditAudio({Key? key, required this.idCollection})
      : super(key: key);
  final String idCollection;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: BlocBuilder<ListItemBloc, ListItemState>(
        builder: (context, state) {
          if (state.status == ListItemStatus.emptyList) {
            return const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 40.0,
              ),
              child: Center(
                child: Text(
                  'Как только ты добавиш аудио, оно появится здесь.',
                  textAlign: TextAlign.center,
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
              padding: const EdgeInsets.only(bottom: 140.0),
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
                  popupMenu: DoneCollectionItemEditAudio(
                    done: audio.done,
                    name: '${audio.audioName}',
                    collection: audio.collections,
                    id: '${audio.id}',
                    idCollection: idCollection,
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
      ),
    );
  }
}
