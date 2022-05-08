part of 'orange_list_collections_bloc.dart';

enum OrangeListItemStatus {
  initial,
  emptyList,
  success,
  failed,
}

@immutable
class OrangeListItemState extends Equatable {
  const OrangeListItemState({
    this.status = OrangeListItemStatus.initial,
    this.list = const <CollectionsModel>[],
    this.streamList,
  });
  final OrangeListItemStatus status;
  final List<CollectionsModel> list;
  final StreamSubscription<List<CollectionsModel>>? streamList;

  OrangeListItemState copyWith({
    OrangeListItemStatus? status,
    List<CollectionsModel>? list,
    StreamSubscription<List<CollectionsModel>>? streamList,
  }) {
    return OrangeListItemState(
      status: status ?? this.status,
      list: list ?? this.list,
      streamList: streamList ?? this.streamList,
    );
  }

  @override
  List<Object?> get props => [status, list, streamList];
}
