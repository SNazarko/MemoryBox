import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/models/audio_model.dart';
import 'package:memory_box/resources/app_colors.dart';
import 'package:just_audio/just_audio.dart' as ap;
import 'package:memory_box/widgets/player_mini.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);
  static const rootName = '/test';

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  Stream<List<AudioModel>> readAudio() => FirebaseFirestore.instance
      .collection('Колекции')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => AudioModel.fromJson(doc.data())).toList());

  Widget buildAudio(AudioModel audio) => PlayerMini(
        url: '${audio.audioUrl}',
        name: '${audio.audioName}',
        duration: null,
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
