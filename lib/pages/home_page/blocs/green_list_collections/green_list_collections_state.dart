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
  });
  final GreenListItemStatus status;
  final List<CollectionsModel> list;

  GreenListItemState copyWith({
    GreenListItemStatus? status,
    List<CollectionsModel>? list,
  }) {
    return GreenListItemState(
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
