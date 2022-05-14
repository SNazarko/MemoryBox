part of 'orange_list_collections_bloc.dart';

@immutable
abstract class OrangeListItemEvent extends Equatable {}

class LoadOrangeListItemEvent extends OrangeListItemEvent {
  LoadOrangeListItemEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class UpdateOrangeListItemEvent extends OrangeListItemEvent {
  UpdateOrangeListItemEvent({
    this.list = const <CollectionsModel>[],
  });
  final List<CollectionsModel> list;

  @override
  // TODO: implement props
  List<Object?> get props => [list];
}
