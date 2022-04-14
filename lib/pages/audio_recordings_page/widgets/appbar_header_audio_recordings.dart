import 'package:flutter/material.dart';
import 'package:memory_box/models/user_model.dart';
import 'package:memory_box/resources/app_colors.dart';
import 'package:memory_box/resources/constants.dart';
import 'package:memory_box/widgets/appbar_clipper.dart';
import '../../../animation/audio_recordings_page_player/audio_recordings_page_player.dart';
import '../../../repositories/user_repositories.dart';

class AppbarHeaderAudioRecordings extends StatelessWidget {
  AppbarHeaderAudioRecordings({Key? key}) : super(key: key);
  final UserRepositories repositories = UserRepositories();

  Widget buildCollections(UserModel model) => _QualityTotalTime(
        quality: model.totalQuality ?? 0,
        totalTime: model.totalTime ?? '00:00',
      );

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(),
        ClipPath(
          clipper: AppbarClipper(),
          child: Container(
            color: AppColor.colorAppbar,
            width: double.infinity,
            height: 125.0,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Все в одном месте',
              style: kTitle2TextStyle2,
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 30.0,
            left: 10.0,
            right: 10.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              StreamBuilder<List<UserModel>>(
                stream: repositories.readUser(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Error');
                  }
                  if (snapshot.hasData) {
                    final collections = snapshot.data!;
                    if (collections.map(buildCollections).toList().isNotEmpty) {
                      return Container(
                        child: collections.map(buildCollections).toList().last,
                      );
                    } else {
                      return Container();
                    }
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
              const AudioRecordingsPagePlayer(),
              // const AppbarPlayer(),
            ],
          ),
        )
      ],
    );
  }
}

class _QualityTotalTime extends StatelessWidget {
  const _QualityTotalTime({
    Key? key,
    required this.quality,
    required this.totalTime,
  }) : super(key: key);
  final int quality;
  final String totalTime;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$quality аудио',
          style: kTitle2TextStyle2,
        ),
        Text(
          '$totalTime часов',
          style: kTitle2TextStyle2,
        ),
      ],
    );
  }
}
