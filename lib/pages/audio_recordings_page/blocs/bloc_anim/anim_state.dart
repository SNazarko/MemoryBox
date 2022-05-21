part of 'anim_bloc.dart';

@immutable
class AnimState {
  const AnimState({
    this.anim = 0.0,
  });
  final double anim;

  AnimState copyWith({
    double? anim,
  }) {
    return AnimState(
      anim: anim ?? this.anim,
    );
  }
}
