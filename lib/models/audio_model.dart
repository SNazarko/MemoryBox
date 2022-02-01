class AudioModel {
  String? audioName;
  String? audioUrl;

  String? get getAudioUrl => audioUrl;
  void setAudioUrl(String audioUrl) {
    this.audioUrl = audioUrl;
  }

  AudioModel({
    this.audioName,
    this.audioUrl,
  });

  factory AudioModel.fromJson(Map<String, dynamic> json) {
    return AudioModel(
      audioName: json['audioName'],
      audioUrl: json['audioUrl'],
    );
  }

  Map<String, dynamic> toJson() => {
        'audioName': audioName,
        'audioUrl': audioUrl,
      };
}
