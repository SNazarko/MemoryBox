part of 'collection_item_anim_bloc.dart';

@immutable
class CollectionItemAnimEvent extends Equatable {
  const CollectionItemAnimEvent({required this.anim});
  final double anim;

  @override
  // TODO: implement props
  List<Object?> get props => [anim];
}