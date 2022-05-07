import 'dart:async';

import 'package:flutter/cupertino.dart';
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
    this.qualityTotalTime = const [],
    this.streamList,
  });
  final QualityTotalTimeStatus status;
  final List qualityTotalTime;
  final StreamSubscription<List>? streamList;

  QualityTotalTimeState copyWith({
    QualityTotalTimeStatus? status,
    List? qualityTotalTime,
    StreamSubscription<List>? streamList,
  }) {
    return QualityTotalTimeState(
      status: status ?? this.status,
      qualityTotalTime: qualityTotalTime ?? this.qualityTotalTime,
      streamList: streamList ?? this.streamList,
    );
  }
}
