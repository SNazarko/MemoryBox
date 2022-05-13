part of 'list_item_collection_bloc.dart';

@immutable
abstract class ListItemCollectionEvent extends Equatable{
  const ListItemCollectionEvent();
}

class LoadListItemCollectionEvent extends ListItemCollectionEvent {
  const LoadListItemCollectionEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class UpdateListItemCollectionEvent extends ListItemCollectionEvent {
  const UpdateListItemCollectionEvent({
    this.list = const [],
  });
  final List list;

  @override
  // TODO: implement props
  List<Object?> get props => [list];
}