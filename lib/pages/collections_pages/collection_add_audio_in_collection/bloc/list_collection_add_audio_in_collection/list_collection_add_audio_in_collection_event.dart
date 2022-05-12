part of 'list_collection_add_audio_in_collection_bloc.dart';

abstract class ListCollectionAddAudioInCollectionEvent extends Equatable {
  const ListCollectionAddAudioInCollectionEvent();
}

class LoadListCollectionAddAudioInCollectionEvent
    extends ListCollectionAddAudioInCollectionEvent {
  const LoadListCollectionAddAudioInCollectionEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class UpdateListCollectionAddAudioInCollectionEvent
    extends ListCollectionAddAudioInCollectionEvent {
  const UpdateListCollectionAddAudioInCollectionEvent({
    this.list = const [],
  });
  final List list;

  @override
  // TODO: implement props
  List<Object?> get props => [list];
}
