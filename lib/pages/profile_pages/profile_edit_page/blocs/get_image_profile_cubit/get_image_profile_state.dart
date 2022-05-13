part of 'get_image_profile_cubit.dart';

@immutable
class GetImageProfileState extends Equatable {
  const GetImageProfileState({
    this.image,
  });

  final String? image;

  GetImageProfileState copyWith({
    String? image,
  }) {
    return GetImageProfileState(
      image: image ?? this.image,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        image,
      ];
}
