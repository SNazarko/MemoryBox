part of 'collection_item_edit_bloc.dart';

@immutable
class CollectionItemEditState extends Equatable {
  const CollectionItemEditState({
    this.title,
    this.subTitle,
  });
  final String? title;
  final String? subTitle;

  CollectionItemEditState copyWith({
    String? title,
    String? subTitle,
  }) {
    return CollectionItemEditState(
      title: title ?? this.title,
      subTitle: subTitle ?? this.subTitle,
    );
  }

  @override
  List<Object?> get props => [
        title,
        subTitle,
      ];
}
