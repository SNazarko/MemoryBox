import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/models/audio_model.dart';
import 'package:memory_box/pages/audio_recordings_page/widgets/popup_menu_audio_recording.dart';
import 'package:memory_box/pages/authorization_page/registration_page/registration_page.dart';
import 'package:memory_box/repositories/audio_repositories.dart';
import 'package:memory_box/resources/app_colors.dart';
import 'package:memory_box/widgets/player_mini/player_mini.dart';

class ListPlayer extends StatelessWidget {
  ListPlayer({Key? key}) : super(key: key);
  final AudioRepositories repositories = AudioRepositories();
  Widget buildAudio(AudioModel audio) => PlayerMini(
        duration: '${audio.duration}',
        url: '${audio.audioUrl}',
        name: '${audio.audioName}',
        done: audio.done!,
        id: '${audio.id}',
        collection: audio.collections ?? [],
        popupMenu: PopupMenuAudioRecording(
          url: '${audio.audioUrl}',
          duration: '${audio.duration}',
          name: '${audio.audioName}',
          dateTime: audio.dateTime!,
          done: audio.done!,
          searchName: audio.searchName!,
          idAudio: '${audio.id}',
          collection: audio.collections!,
        ),
      );

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        SizedBox(
          height: screenHeight * 0.95,
          child: StreamBuilder<List<AudioModel>>(
            stream: repositories.readAudioSort('all'),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Column(
                  children: [
                    const SizedBox(
                      height: 200.0,
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 50.0,
                          horizontal: 40.0,
                        ),
                        child: Column(
                          children: [
                            RichText(
                              text: TextSpan(
                                  text: '     Для открытия полного \n '
                                      '            функционала \n '
                                      '   приложения вам нужно \n '
                                      ' зарегистрироваться',
                                  style: const TextStyle(
                                    fontSize: 20.0,
                                    color: AppColor.colorText50,
                                  ),
                                  children: [
                                    TextSpan(
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.pushNamed(context,
                                              RegistrationPage.routeName);
                                        },
                                      text: ' здесь',
                                      style: const TextStyle(
                                        fontSize: 20.0,
                                        color: AppColor.pink,
                                      ),
                                    )
                                  ]),
                            )
                          ],
                        )),
                  ],
                );
              }
              if (snapshot.hasData) {
                final audio = snapshot.data!;
                return ListView(
                  padding: const EdgeInsets.only(top: 127, bottom: 190),
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
