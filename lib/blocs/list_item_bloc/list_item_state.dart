part of 'list_item_bloc.dart';

enum ListItemStatus {
  initial,
  emptyList,
  success,
  failed,
}

@immutable
class ListItemState {
  const ListItemState({
    this.status = ListItemStatus.initial,
    this.list = const [],
    this.streamList,
  });
  final ListItemStatus status;
  final List list;
  final StreamSubscription<List>? streamList;

  ListItemState copyWith({
    ListItemStatus? status,
    List? list,
    StreamSubscription<List>? streamList,
  }) {
    return ListItemState(
      status: status ?? this.status,
      list: list ?? this.list,
      streamList: streamList ?? this.streamList,
    );
  }
}
