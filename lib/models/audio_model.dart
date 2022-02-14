class AudioModel {
  String? audioName;
  String? audioUrl;
  String? duration;
  bool? done;

  AudioModel({
    this.audioName,
    this.audioUrl,
    this.duration,
    this.done,
  });

  factory AudioModel.fromJson(Map<String, dynamic> json) {
    return AudioModel(
      audioName: json['audioName'],
      audioUrl: json['audioUrl'],
      duration: json['duration'],
      done: json['done'],
    );
  }

  Map<String, dynamic> toJson() => {
        'audioName': audioName,
        'audioUrl': audioUrl,
        'duration': duration,
        'done': done,
      };
}
