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
  });
  final OrangeListItemStatus status;
  final List<CollectionsModel> list;

  OrangeListItemState copyWith({
    OrangeListItemStatus? status,
    List<CollectionsModel>? list,
  }) {
    return OrangeListItemState(
      status: status ?? this.status,
      list: list ?? this.list,
    );
  }

  @override
  List<Object?> get props => [
        status,
        list,
      ];
}
