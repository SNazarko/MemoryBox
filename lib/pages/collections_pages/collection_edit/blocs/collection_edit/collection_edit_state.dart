part of 'collection_edit_bloc.dart';

@immutable
class CollectionEditState extends Equatable {
  const CollectionEditState({
    this.title,
    this.subTitle,
  });
  final String? title;
  final String? subTitle;

  CollectionEditState copyWith({
    String? title,
    String? subTitle,
  }) {
    return CollectionEditState(
      title: title ?? this.title,
      subTitle: subTitle ?? this.subTitle,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        title,
        subTitle,
      ];
}
