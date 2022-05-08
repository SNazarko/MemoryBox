import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memory_box/models/user_model.dart';
import 'package:memory_box/resources/app_colors.dart';
import 'package:memory_box/utils/constants.dart';
import '../../../animation/audio_recordings_page_player/audio_recordings_page_player.dart';
import '../../../widgets/uncategorized/appbar_clipper.dart';
import '../blocs/bloc_quality_total_time/quality_total_time_bloc.dart';
import '../blocs/bloc_quality_total_time/quality_total_time_state.dart';

class AppbarHeaderAudioRecordings extends StatelessWidget {
  const AppbarHeaderAudioRecordings({Key? key}) : super(key: key);

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
              BlocBuilder<QualityTotalTimeBloc, QualityTotalTimeState>(
                builder: (context, state) {
                  if (state.status == QualityTotalTimeStatus.initial) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state.status == QualityTotalTimeStatus.failed) {
                    return const _QualityTotalTime(
                      totalTime: '??:??',
                      quality: 0,
                    );
                  }
                  if (state.status == QualityTotalTimeStatus.success) {
                    if (state.qualityTotalTime.isNotEmpty) {
                      final user = state.qualityTotalTime.last;
                      return _QualityTotalTime(
                        quality: user.totalQuality ?? 0,
                        totalTime: user.totalTime ?? '00:00',
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
