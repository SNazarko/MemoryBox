part of 'subscription_page_bloc.dart';

enum SubscriptionPageStatus {
  initial,
  success,
  failed,
}

@immutable
class SubscriptionPageState extends Equatable {
  const SubscriptionPageState({
    this.status = SubscriptionPageStatus.initial,
    this.subscription = const [],
  });
  final SubscriptionPageStatus status;
  final List subscription;

  SubscriptionPageState copyWith({
    SubscriptionPageStatus? status,
    List? subscription,
  }) {
    return SubscriptionPageState(
      status: status ?? this.status,
      subscription: subscription ?? this.subscription,
    );
  }

  @override
  List<Object?> get props => [
        status,
        subscription,
      ];
}
