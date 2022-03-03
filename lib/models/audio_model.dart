class AudioModel {
  String? audioName;
  String? audioUrl;
  String? duration;
  bool? done;
  String? dateTime;

  AudioModel({
    this.audioName,
    this.audioUrl,
    this.duration,
    this.done,
    this.dateTime,
  });

  factory AudioModel.fromJson(Map<String, dynamic> json) {
    return AudioModel(
      audioName: json['audioName'],
      audioUrl: json['audioUrl'],
      duration: json['duration'],
      done: json['done'],
      dateTime: json['dateTime'],
    );
  }

  Map<String, dynamic> toJson() => {
        'audioName': audioName,
        'audioUrl': audioUrl,
        'duration': duration,
        'done': done,
        'dateTime': dateTime
      };
}
