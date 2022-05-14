part of 'blue_list_collections_bloc.dart';

@immutable
abstract class BlueListItemEvent extends Equatable {
  const BlueListItemEvent();
}

class LoadBlueListItemEvent extends BlueListItemEvent {
  const LoadBlueListItemEvent();
  @override
  List<Object?> get props => [];
}

class UpdateBlueListItemEvent extends BlueListItemEvent {
  const UpdateBlueListItemEvent({
    this.list = const <CollectionsModel>[],
  });
  final List<CollectionsModel> list;

  @override
  List<Object?> get props => [list];
}
