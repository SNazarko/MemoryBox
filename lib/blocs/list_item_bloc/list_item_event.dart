part of 'list_item_bloc.dart';

@immutable
abstract class ListItemEvent {}

class LoadListItemEvent extends ListItemEvent {
  LoadListItemEvent({
    this.collection,
    this.sort,
    this.nameSort,
  });
  final String? collection;
  final String? sort;
  final String? nameSort;
}

class UpdateListItemEvent extends ListItemEvent {
  UpdateListItemEvent({
    this.list = const [],
  });
  final List list;
}
