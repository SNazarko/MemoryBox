part of 'profile_page_bloc.dart';

@immutable
class ProfilePageState extends Equatable {
  const ProfilePageState({
    this.name = 'Имя',
    this.number = '+0(000)000 00 00',
    this.image = 'assets/images/profile_avatar.png',
  });
  final String? name;
  final String? number;
  final String? image;

  ProfilePageState copyWith({
    String? name,
    String? number,
    String? image,
  }) {
    return ProfilePageState(
      name: name ?? this.name,
      number: number ?? this.number,
      image: image ?? this.image,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [name, number, image];
}
