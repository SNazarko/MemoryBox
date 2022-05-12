part of 'get_image_cubit.dart';

@immutable
class GetImageState extends Equatable {
  const GetImageState({this.image,

  });

  final String? image;

  GetImageState copyWith({

    String? image,
  }) {
    return GetImageState(
      image: image ?? this.image,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
    image,
  ];
}