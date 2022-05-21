part of 'support_message_bloc.dart';

enum SupportMessageStatus {
  initial,
  emptyList,
  success,
  failed,
}

@immutable
class SupportMessageState extends Equatable {
  const SupportMessageState({
    this.status = SupportMessageStatus.initial,
    this.list = const [],
  });
  final SupportMessageStatus status;
  final List list;

  SupportMessageState copyWith({
    SupportMessageStatus? status,
    List? list,
  }) {
    return SupportMessageState(
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
