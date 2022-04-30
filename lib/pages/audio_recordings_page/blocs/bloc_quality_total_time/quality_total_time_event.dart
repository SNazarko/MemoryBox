import 'package:flutter/cupertino.dart';
import 'package:memory_box/pages/collections_pages/collection/collection_model.dart';

import '../../../../models/user_model.dart';

@immutable
abstract class QualityTotalTimeEvent {}

class LoadQualityTotalTimeEvent extends QualityTotalTimeEvent {}

class UpdateQualityTotalTimeEvent extends QualityTotalTimeEvent {
  UpdateQualityTotalTimeEvent({
    this.qualityTotalTime = const <UserModel>[],
  });
  final List<UserModel> qualityTotalTime;
}
