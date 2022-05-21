part of 'list_collection_add_audio_in_collection_bloc.dart';

enum ListCollectionAddAudioInCollectionStatus {
  initial,
  emptyList,
  success,
  failed,
}

@immutable
class ListCollectionAddAudioInCollectionState extends Equatable {
  const ListCollectionAddAudioInCollectionState({
    this.status = ListCollectionAddAudioInCollectionStatus.initial,
    this.list = const [],
  });
  final ListCollectionAddAudioInCollectionStatus status;
  final List list;

  ListCollectionAddAudioInCollectionState copyWith({
    ListCollectionAddAudioInCollectionStatus? status,
    List? list,
  }) {
    return ListCollectionAddAudioInCollectionState(
      status: status ?? this.status,
      list: list ?? this.list,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        status,
        list,
      ];
}
