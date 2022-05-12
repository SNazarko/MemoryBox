part of 'get_image_cubit.dart';

@immutable
class GetImageCollectionItemEditState extends Equatable {
  const GetImageCollectionItemEditState({
    this.image,
  });

  final String? image;

  GetImageCollectionItemEditState copyWith({
    String? image,
  }) {
    return GetImageCollectionItemEditState(
      image: image ?? this.image,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        image,
      ];
}
