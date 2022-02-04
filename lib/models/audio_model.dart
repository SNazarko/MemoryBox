class AudioModel {
  String? audioName;
  String? audioUrl;
  String? duration;

  AudioModel({
    this.audioName,
    this.audioUrl,
    this.duration,
  });

  factory AudioModel.fromJson(Map<String, dynamic> json) {
    return AudioModel(
      audioName: json['audioName'],
      audioUrl: json['audioUrl'],
      duration: json['duration'],
    );
  }

  Map<String, dynamic> toJson() => {
        'audioName': audioName,
        'audioUrl': audioUrl,
        'duration': duration,
      };
}
