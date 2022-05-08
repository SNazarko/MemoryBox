part of 'green_list_collections_bloc.dart';

enum GreenListItemStatus {
  initial,
  emptyList,
  success,
  failed,
}

@immutable
class GreenListItemState extends Equatable {
  const GreenListItemState({
    this.status = GreenListItemStatus.initial,
    this.list = const <CollectionsModel>[],
    this.streamList,
  });
  final GreenListItemStatus status;
  final List<CollectionsModel> list;
  final StreamSubscription<List<CollectionsModel>>? streamList;

  GreenListItemState copyWith({
    GreenListItemStatus? status,
    List<CollectionsModel>? list,
    StreamSubscription<List<CollectionsModel>>? streamList,
  }) {
    return GreenListItemState(
      status: status ?? this.status,
      list: list ?? this.list,
      streamList: streamList ?? this.streamList,
    );
  }

  @override
  List<Object?> get props => [status, list, streamList];
}
