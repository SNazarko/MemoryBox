part of 'search_page_bloc.dart';

@immutable
abstract class SearchPageEvent extends Equatable {
  const SearchPageEvent();
}

class LoadSearchPageEvent extends SearchPageEvent {
  const LoadSearchPageEvent({
    this.sort,
  });
  final String? sort;

  @override
  // TODO: implement props
  List<Object?> get props => [sort];
}

class UpdateSearchPageEvent extends SearchPageEvent {
  const UpdateSearchPageEvent({
    this.list = const [],
  });
  final List list;

  @override
  // TODO: implement props
  List<Object?> get props => [list];
}