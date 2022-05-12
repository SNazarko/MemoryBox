part of 'collection_edit_bloc.dart';

class CollectionEditEvent extends Equatable {
  const CollectionEditEvent({
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
