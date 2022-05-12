part of 'collection_item_edit_bloc.dart';

class CollectionItemEditEvent extends Equatable {
  const CollectionItemEditEvent({
    this.title,
    this.subTitle,
  });
  final String? title;
  final String? subTitle;

  @override
  // TODO: implement props
  List<Object?> get props => [
        title,
        subTitle,
      ];
}
