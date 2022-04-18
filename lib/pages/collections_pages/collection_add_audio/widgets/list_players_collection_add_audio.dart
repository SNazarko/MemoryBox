import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/models/audio_model.dart';
import 'package:memory_box/pages/search_page/search_page_model.dart';
import 'package:memory_box/repositories/audio_repositories.dart';
import 'package:memory_box/widgets/player/player_mini_podborki.dart';
import 'package:provider/provider.dart';

class ListPlayersCollectionAddAudio extends StatelessWidget {
  ListPlayersCollectionAddAudio({Key? key}) : super(key: key);

  final AudioRepositories _rep = AudioRepositories();

  Stream<List<AudioModel>> audio(BuildContext context) => FirebaseFirestore
      .instance
      .collection(_rep.user!.phoneNumber!)
      .doc('id')
      .collection('Collections')
      .where('searchName',
          arrayContains: context.watch<SearchPageModel>().getSearchAddAudio)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => AudioModel.fromJson(doc.data())).toList());

  Widget buildAudio(AudioModel audio) => PlayerMiniPodborki(
        duration: '${audio.duration}',
        url: '${audio.audioUrl}',
        name: '${audio.audioName}',
        done: audio.done = false,
        id: '${audio.id}',
        collection: audio.collections ?? [],
      );

  @override
  Widget build(BuildContext context) {
    final state = context.watch<SearchPageModel>().getSearchData;
    final double screenHeight = MediaQuery.of(context).size.height;
    if (state == '') {
      return Column(
        children: [
          SizedBox(
            height: screenHeight * 0.95,
            child: StreamBuilder<List<AudioModel>>(
              stream: _rep.readAudioSort('all'),
              builder: (
                context,
                snapshot,
              ) {
                if (snapshot.hasError) {
                  return const Text('Ошибка');
                }
                if (snapshot.hasData) {
                  final audio = snapshot.data!;
                  return ListView(
                    padding: const EdgeInsets.only(top: 225, bottom: 110),
                    children: audio.map(buildAudio).toList(),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ],
      );
    } else {
      return Column(
        children: [
          SizedBox(
            height: screenHeight * 0.95,
            child: StreamBuilder<List<AudioModel>>(
              stream: audio(context),
              builder: (
                context,
                snapshot,
              ) {
                if (snapshot.hasError) {
                  return const Text('Ошибка');
                }
                if (snapshot.hasData) {
                  final audio = snapshot.data!;
                  return ListView(
                    padding: const EdgeInsets.only(top: 225, bottom: 110),
                    children: audio.map(buildAudio).toList(),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ],
      );
    }
  }
}
