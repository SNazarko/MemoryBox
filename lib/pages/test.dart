import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/models/audio_model.dart';

class Test extends StatelessWidget {
  const Test({Key? key}) : super(key: key);
  static const rootName = '/test';

  Stream<List<AudioModel>> readAudio() => FirebaseFirestore.instance
      .collection('Колекции')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => AudioModel.fromJson(doc.data())).toList());

  Widget buildAudio(AudioModel audio) => ListTile(
        title: Text('${audio.audioName}'),
        subtitle: Text('${audio.audioUrl}'),
      );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test'),
        centerTitle: true,
      ),
      body: StreamBuilder<List<AudioModel>>(
        stream: readAudio(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Ошибка');
          }
          if (snapshot.hasData) {
            final audio = snapshot.data!;
            return ListView(
              children: audio.map(buildAudio).toList(),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
