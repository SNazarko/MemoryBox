import 'dart:io';

import 'package:memory_box/players/sound_record.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;

class SaveAudio {
  String nameAudio;
  List audiolist = [];

  SaveAudio(this.nameAudio);

  void saveFile() async {
    final directory = await pathProvider.getApplicationDocumentsDirectory();
    final filePath = directory.path + '/' + '$nameAudio' + '.mp4';
    final audioFile = SoundRecording().mPath;
    var file = File(filePath);
    await file.writeAsString(audioFile);
    await for (var entity in directory.list()) {
      audiolist.add(entity.path);
      print(audiolist);
    }
  }
}
