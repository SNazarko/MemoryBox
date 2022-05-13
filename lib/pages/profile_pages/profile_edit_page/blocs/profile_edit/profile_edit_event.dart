part of 'profile_edit_bloc.dart';

class ProfileEditEvent extends Equatable {
  const ProfileEditEvent({
    this.userName,
    this.phoneNumber,
  });
  final String? userName;
  final String? phoneNumber;

  @override
  // TODO: implement props
  List<Object?> get props => [
        userName,
        phoneNumber,
      ];
}
