part of 'list_item_collection_bloc.dart';


enum ListItemCollectionStatus {
  initial,
  emptyList,
  success,
  failed,
}

@immutable
class ListItemCollectionState extends Equatable{
  const ListItemCollectionState({
    this.status = ListItemCollectionStatus.initial,
    this.list = const [],
  });
  final ListItemCollectionStatus status;
  final List list;

  ListItemCollectionState copyWith({
    ListItemCollectionStatus? status,
    List? list,
  }) {
    return ListItemCollectionState(
      status: status ?? this.status,
      list: list ?? this.list,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [status,list];
}