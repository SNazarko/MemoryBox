part of 'green_list_collections_bloc.dart';

@immutable
abstract class GreenListItemEvent extends Equatable {}

class LoadGreenListItemEvent extends GreenListItemEvent {
  LoadGreenListItemEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class UpdateGreenListItemEvent extends GreenListItemEvent {
  UpdateGreenListItemEvent({
    this.list = const <CollectionsModel>[],
  });
  final List<CollectionsModel> list;

  @override
  // TODO: implement props
  List<Object?> get props => [list];
}
