part of 'save_page_bloc.dart';

@immutable
class SavePageState extends Equatable {
  const SavePageState({
    this.newSearchName,
    this.newAudioName,
  });
  final List? newSearchName;
  final String? newAudioName;

  SavePageState copyWith({
    List? newSearchName,
    String? newAudioName,
  }) {
    return SavePageState(
      newSearchName: newSearchName ?? this.newSearchName,
      newAudioName: newAudioName ?? this.newAudioName,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        newSearchName,
        newAudioName,
      ];
}
