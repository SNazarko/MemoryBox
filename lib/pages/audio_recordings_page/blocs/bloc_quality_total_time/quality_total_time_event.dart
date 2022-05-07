import 'package:flutter/cupertino.dart';

import '../../../../models/user_model.dart';

@immutable
abstract class QualityTotalTimeEvent {}

class LoadQualityTotalTimeEvent extends QualityTotalTimeEvent {
  LoadQualityTotalTimeEvent({
    this.streamList,
  });
  final Stream<List>? streamList;
}

class UpdateQualityTotalTimeEvent extends QualityTotalTimeEvent {
  UpdateQualityTotalTimeEvent({
    this.qualityTotalTime = const [],
  });
  final List qualityTotalTime;
}
