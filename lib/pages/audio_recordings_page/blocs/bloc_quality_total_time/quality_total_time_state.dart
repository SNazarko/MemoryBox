import 'package:flutter/cupertino.dart';
import 'package:memory_box/pages/collections_pages/collection/collection_model.dart';

import '../../../../models/audio_model.dart';
import '../../../../models/user_model.dart';

enum QualityTotalTimeStatus {
  initial,
  success,
  failed,
}

@immutable
class QualityTotalTimeState {
  const QualityTotalTimeState({
    this.status = QualityTotalTimeStatus.initial,
    this.qualityTotalTime = const <UserModel>[],
  });
  final QualityTotalTimeStatus status;
  final List<UserModel> qualityTotalTime;

  QualityTotalTimeState copyWith({
    QualityTotalTimeStatus? status,
    List<UserModel>? qualityTotalTime,
  }) {
    return QualityTotalTimeState(
      status: status ?? this.status,
      qualityTotalTime: qualityTotalTime ?? this.qualityTotalTime,
    );
  }
}
