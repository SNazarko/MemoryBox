part of 'orange_list_collections_bloc.dart';

@immutable
abstract class OrangeListItemEvent {}

class LoadOrangeListItemEvent extends OrangeListItemEvent {
  LoadOrangeListItemEvent({
    this.streamList,
  });
  final Stream<List<CollectionsModel>>? streamList;
}

class UpdateOrangeListItemEvent extends OrangeListItemEvent {
  UpdateOrangeListItemEvent({
    this.list = const <CollectionsModel>[],
  });
  final List<CollectionsModel> list;
}
