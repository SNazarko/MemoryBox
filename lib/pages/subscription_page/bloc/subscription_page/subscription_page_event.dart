part of 'subscription_page_bloc.dart';

@immutable
abstract class SubscriptionPageEvent extends Equatable {}

class LoadSubscriptionPageEvent extends SubscriptionPageEvent {
  LoadSubscriptionPageEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class UpdateSubscriptionPageEvent extends SubscriptionPageEvent {
  UpdateSubscriptionPageEvent({
    this.subscription = const [],
  });
  final List subscription;

  @override
  // TODO: implement props
  List<Object?> get props => [subscription];
}
