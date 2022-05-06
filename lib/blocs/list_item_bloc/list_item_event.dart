part of 'list_item_bloc.dart';

@immutable
abstract class ListItemEvent {}

class LoadListItemEvent extends ListItemEvent {
  LoadListItemEvent({
    this.streamList,
  });
  final Stream<List>? streamList;
}

class UpdateListItemEvent extends ListItemEvent {
  UpdateListItemEvent({
    this.list = const [],
  });
  final List list;
}
