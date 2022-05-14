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
  });
  final BlueListItemStatus status;
  final List<CollectionsModel> list;

  BlueListItemState copyWith({
    BlueListItemStatus? status,
    List<CollectionsModel>? list,
  }) {
    return BlueListItemState(
      status: status ?? this.status,
      list: list ?? this.list,
    );
  }

  @override
  List<Object?> get props => [status, list];
}
