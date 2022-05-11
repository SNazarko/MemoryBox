part of 'collection_add_audio_bloc.dart';

enum CollectionAddAudioStatus {
  initial,
  emptyList,
  success,
  failed,
}

@immutable
class CollectionAddAudioState extends Equatable {
  const CollectionAddAudioState({
    this.status = CollectionAddAudioStatus.initial,
    this.list = const [],
  });
  final CollectionAddAudioStatus status;
  final List list;

  CollectionAddAudioState copyWith({
    CollectionAddAudioStatus? status,
    List? list,
  }) {
    return CollectionAddAudioState(
      status: status ?? this.status,
      list: list ?? this.list,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [status, list];
}
