import 'package:flutter/cupertino.dart';

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
  });
  final QualityTotalTimeStatus status;
  final List qualityTotalTime;

  QualityTotalTimeState copyWith({
    QualityTotalTimeStatus? status,
    List? qualityTotalTime,
  }) {
    return QualityTotalTimeState(
      status: status ?? this.status,
      qualityTotalTime: qualityTotalTime ?? this.qualityTotalTime,
    );
  }
}
