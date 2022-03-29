import 'package:cloud_firestore/cloud_firestore.dart';

class AudioModel {
  String? id;
  String? audioName;
  String? audioUrl;
  String? duration;
  bool? done;
  String? dateTime;
  Timestamp? dateTimeDelete;
  List? searchName;
  List? collections;
  int? size;

  AudioModel(
      {this.id,
      this.audioName,
      this.audioUrl,
      this.duration,
      this.done,
      this.dateTime,
      this.dateTimeDelete,
      this.searchName,
      this.collections,
      this.size});

  factory AudioModel.fromJson(Map<String, dynamic> json) {
    return AudioModel(
      id: json['id'],
      audioName: json['audioName'],
      audioUrl: json['audioUrl'],
      duration: json['duration'],
      done: json['done'],
      dateTime: json['dateTime'],
      dateTimeDelete: json['dateTimeDelete'],
      searchName: json['searchName'],
      collections: json['collections'],
      size: json['size'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'audioName': audioName,
        'audioUrl': audioUrl,
        'duration': duration,
        'done': done,
        'dateTime': dateTime,
        'dateTimeDelete': dateTimeDelete,
        'searchName': searchName,
        'collections': collections,
        'size': size
      };
}
