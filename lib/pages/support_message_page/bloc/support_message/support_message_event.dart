part of 'support_message_bloc.dart';

@immutable
abstract class SupportMessageEvent extends Equatable {
  const SupportMessageEvent();
}

class LoadSupportMessageEvent extends SupportMessageEvent {
  const LoadSupportMessageEvent();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class UpdateSupportMessageEvent extends SupportMessageEvent {
  const UpdateSupportMessageEvent({
    this.list,
  });
  final List? list;

  @override
  // TODO: implement props
  List<Object?> get props => [list];
}
