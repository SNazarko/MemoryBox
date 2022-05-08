part of 'blue_list_collections_bloc.dart';

enum BlueListItemStatus {
  initial,
  emptyList,
  success,
  failed,
}

@immutable
class BlueListItemState extends Equatable {
  const BlueListItemState({
    this.status = BlueListItemStatus.initial,
    this.list = const <CollectionsModel>[],
    this.streamList,
  });
  final BlueListItemStatus status;
  final List<CollectionsModel> list;
  final StreamSubscription<List<CollectionsModel>>? streamList;

  BlueListItemState copyWith({
    BlueListItemStatus? status,
    List<CollectionsModel>? list,
    StreamSubscription<List<CollectionsModel>>? streamList,
  }) {
    return BlueListItemState(
      status: status ?? this.status,
      list: list ?? this.list,
      streamList: streamList ?? this.streamList,
    );
  }

  @override
  List<Object?> get props => [status, list, streamList];
}
