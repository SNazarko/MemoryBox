part of 'green_list_collections_bloc.dart';

@immutable
abstract class GreenListItemEvent {}

class LoadGreenListItemEvent extends GreenListItemEvent {
  LoadGreenListItemEvent({
    this.streamList,
  });
  final Stream<List<CollectionsModel>>? streamList;
}

class UpdateGreenListItemEvent extends GreenListItemEvent {
  UpdateGreenListItemEvent({
    this.list = const <CollectionsModel>[],
  });
  final List<CollectionsModel> list;
}
