import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/models/audio_model.dart';
import 'package:memory_box/pages/collections_pages/collection_edit/collection_edit_model.dart';
import 'package:memory_box/pages/search_page/search_page_model.dart';
import 'package:memory_box/repositories/audio_repositories.dart';
import 'package:memory_box/widgets/player_mini_podborki.dart';
import 'package:provider/provider.dart';

class ListPlayersCollectionAddAudio extends StatelessWidget {
  ListPlayersCollectionAddAudio({Key? key}) : super(key: key);
  final AudioRepositories repositories = AudioRepositories();

  Stream<List<AudioModel>> readAudioCollectionEdit(BuildContext context) =>
      FirebaseFirestore.instance
          .collection(repositories.user!.phoneNumber!)
          .doc('id')
          .collection('CollectionsTale')
          .doc(Provider.of<CollectionsEditModel>(context, listen: false)
              .getTitle)
          .collection('Audio')
          .where('searchName',
              arrayContains: context.watch<SearchPageModel>().getSearchAddAudio)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => AudioModel.fromJson(doc.data()))
              .toList());

  Widget buildAudio(AudioModel audio) => PlayerMiniPodborki(
        duration: '${audio.duration}',
        url: '${audio.audioUrl}',
        name: '${audio.audioName}',
        done: audio.done!,
      );

  @override
  Widget build(BuildContext context) {
    final state = context.watch<SearchPageModel>().getSearchAddAudio;
    final double screenHeight = MediaQuery.of(context).size.height;
    if (state == '') {
      return Column(
        children: [
          SizedBox(
            height: screenHeight * 0.95,
            child: StreamBuilder<List<AudioModel>>(
              stream: repositories.readAudioCollectionEdit(
                  Provider.of<CollectionsEditModel>(context, listen: false)
                      .getTitle),
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
                    padding: const EdgeInsets.only(top: 230, bottom: 40),
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
              stream: readAudioCollectionEdit(context),
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
                    padding: const EdgeInsets.only(top: 230, bottom: 40),
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
