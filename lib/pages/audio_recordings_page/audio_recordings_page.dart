import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memory_box/bloc/bloc_all_bloc.dart';
import 'package:memory_box/pages/audio_recordings_page/widgets/appbar_header_audio_recordings.dart';
import 'package:memory_box/pages/audio_recordings_page/widgets/appbar_header_audio_recordings_not_authorization.dart';
import 'package:memory_box/pages/audio_recordings_page/widgets/list_player.dart';
import '../../resources/constants.dart';

class _AudioRecordingsPageArguments {
  _AudioRecordingsPageArguments({this.auth, this.user}) {
    init();
  }
  FirebaseAuth? auth;
  User? user;

  void init() {
    auth = FirebaseAuth.instance;
    user = auth!.currentUser;
  }
}

class AudioRecordingsPage extends StatelessWidget {
  AudioRecordingsPage({Key? key}) : super(key: key);
  final _AudioRecordingsPageArguments arguments =
      _AudioRecordingsPageArguments();
  static const routeName = '/audio_recordings_page';
  static Widget create() {
    return AudioRecordingsPage();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PlayAllRepeatBloc(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: const Icon(Icons.menu),
          ),
          elevation: 0.0,
          title: const Text(
            'Аудиозаписи',
            style: kTitleTextStyle2,
          ),
          actions: [
            arguments.user == null
                ? const SizedBox()
                : const Icon(
                    Icons.more_horiz,
                    color: Colors.white,
                    size: 40.0,
                  ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Stack(
                children: [
                  ListPlayer(),
                  arguments.user == null
                      ? const AppbarHeaderAudioRecordingsNotAuthorization()
                      : const AppbarHeaderAudioRecordings(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
