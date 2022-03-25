class CollectionsModel {
  String? id;
  String? titleCollections;
  String? subTitleCollections;
  String? avatarCollections;
  String? dateTime;
  String? totalTime;
  int? qualityCollections;
  bool? doneCollection;

  CollectionsModel({
    this.id,
    this.titleCollections,
    this.subTitleCollections,
    this.avatarCollections,
    this.dateTime,
    this.totalTime,
    this.qualityCollections,
    this.doneCollection,
  });

  factory CollectionsModel.fromJson(Map<String, dynamic> json) {
    return CollectionsModel(
      id: json['id'],
      titleCollections: json['titleCollections'],
      subTitleCollections: json['subTitleCollections'],
      avatarCollections: json['avatarCollections'],
      dateTime: json['dateTime'],
      totalTime: json['totalTime'],
      qualityCollections: json['qualityCollections'],
      doneCollection: json['doneCollection'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'titleCollections': titleCollections,
        'subTitleCollections': subTitleCollections,
        'avatarCollections': avatarCollections,
        'dateTime': dateTime,
        'totalTime': totalTime,
        'qualityCollections': qualityCollections,
        'doneCollection': doneCollection
      };
}
