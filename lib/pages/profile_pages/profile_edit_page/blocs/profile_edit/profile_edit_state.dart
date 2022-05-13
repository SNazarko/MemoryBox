part of 'profile_edit_bloc.dart';

@immutable
class ProfileEditState extends Equatable {
  const ProfileEditState({
    this.userName,
    this.phoneNumber,
  });
  final String? userName;
  final String? phoneNumber;

  ProfileEditState copyWith({
    String? userName,
    String? phoneNumber,
  }) {
    return ProfileEditState(
      userName: userName ?? this.userName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        userName,
        phoneNumber,
      ];
}
