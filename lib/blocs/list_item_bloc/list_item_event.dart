part of 'list_item_bloc.dart';

@immutable
abstract class ListItemEvent {}

class LoadListItemEvent extends ListItemEvent {
  LoadListItemEvent({
    this.collection,
    this.sort,
  });
  final String? collection;
  final String? sort;
}

class UpdateListItemEvent extends ListItemEvent {
  UpdateListItemEvent({
    this.list = const [],
  });
  final List list;
}
