part of 'search_page_bloc.dart';

enum SearchPageStatus {
  initial,
  emptyList,
  success,
  failed,
}

@immutable
class SearchPageState extends Equatable {
  const SearchPageState({
    this.status = SearchPageStatus.initial,
    this.list = const [],
  });
  final SearchPageStatus status;
  final List list;

  SearchPageState copyWith({
    SearchPageStatus? status,
    List? list,
  }) {
    return SearchPageState(
      status: status ?? this.status,
      list: list ?? this.list,
    );
  }

  @override
  List<Object?> get props => [
        status,
        list,
      ];
}
